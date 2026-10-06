---
layout: page
icon: fas fa-chart-pie
order: 6
---

<div class="donation d-flex mb-0">
    <div class="left">
    <iframe src="https://github.com/sponsors/dennykorsukewitz/button" title="Sponsor dennykorsukewitz" height="32" width="114" style="border: 1; border-radius: 6px;"></iframe>
    </div>
    <div class="right">
        <form action="https://www.paypal.com/donate" method="post" target="_top">
            <input type="hidden" name="hosted_button_id" value="GETTPE8W8AF4A" />
            <input type="image" src="https://pics.paypal.com/00/s/NGJjOTAwOTEtNjExYS00MzQ5LWI2MDQtZmM0YWNlY2YyOTUy/file.PNG" border="0" name="submit" title="PayPal - The safer, easier way to pay online!" alt="Donate with PayPal button" style="height: 32px;" />
            <img alt="" border="0" src="https://www.paypal.com/en_DE/i/scr/pixel.gif" width="1" height="1" />
        </form>
    </div>
</div>

<div>
  <canvas id="CurrentInstalls"></canvas>
  <canvas id="Daily"></canvas>
  <canvas id="VSCodeInstalls"></canvas>
  <canvas id="SublimeInstalls"></canvas>
  <canvas id="NPMInstalls"></canvas>
  <canvas id="GitHubStars"></canvas>
  <canvas id="GitHubStarsPie"></canvas>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- Line below added, added date adapter for time scale -->
<script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns/dist/chartjs-adapter-date-fns.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>

<script>

    Chart.defaults.set('plugins.datalabels', {
        display: false,
    });

    function contrastOnBar(hexColor) {
        const hex = hexColor.replace('#', '');
        const r = parseInt(hex.substring(0, 2), 16);
        const g = parseInt(hex.substring(2, 4), 16);
        const b = parseInt(hex.substring(4, 6), 16);
        const luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255;
        return luminance > 0.55 ? '#1a1a1a' : '#ffffff';
    }

    function chartUiColors() {
        const style = getComputedStyle(document.documentElement);
        const text = style.getPropertyValue('--text-color').trim();
        const heading = style.getPropertyValue('--heading-color').trim();
        const grid = style.getPropertyValue('--border-color').trim();
        return {
            text: text || '#57606a',
            heading: heading || text || '#1f2328',
            grid: grid || 'rgba(0, 0, 0, 0.1)',
        };
    }

    function applyThemedChartOptions(chart, titleText) {
        const colors = chartUiColors();
        chart.options.plugins.title.color = colors.heading;
        chart.options.scales.x.ticks.color = colors.text;
        chart.options.scales.y.ticks.color = colors.text;
        chart.options.scales.x.grid.color = colors.grid;
        chart.options.scales.y.grid.color = colors.grid;
        if (titleText) {
            chart.options.plugins.title.text = titleText;
        }
        chart.update('none');
    }

    const repositoryColors = {
        'generator-sublime-package':     '#ED4848',
        'VSCode-AddFolderToWorkspace':   '#ED7448',
        'Sublime-AddFolderToProject':    '#E6A048',
        'Znuny-QuickDelete':             '#CDB848',
        'VSCode-GitHubFileFetcher':      '#A0C848',
        'Sublime-GitHubFileFetcher':     '#48C878',
        'Znuny-UBInventory':             '#48C8A0',
        'VSCode-MyExtensionPack':        '#48B8D0',
        'MRBS-OTRS':                     '#4894E0',
        'Sublime-QuoteWithMarker':       '#486CE8',
        'VSCode-QuoteWithMarker':        '#6C4CE8',
        'dennykorsukewitz':              '#9C4CE8',
        'VSCode-RainbowColors':          '#E04CB8',
        'VSCode-Znuny':                  '#E04C80',
    };

    const url_vscode = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/vscode-total.json';
    const url_sublime = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/sublime-total.json';
    const url_npm = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/npm-total.json';

    const CurrentInstalls = document.getElementById('CurrentInstalls');

    Promise.all([
        fetch(url_vscode).then((response) => response.json()),
        fetch(url_sublime).then((response) => response.json()),
        fetch(url_npm).then((response) => response.json()),
    ]).then(([vscode_data, sublime_data, npm_data]) => {
        const highestValues = {};

        [vscode_data, sublime_data, npm_data].forEach((series) => {
            series.forEach((item) => {
                for (const key in item) {
                    if (key === 'date') {
                        continue;
                    }
                    if (!highestValues[key] || parseInt(item[key], 10) > parseInt(highestValues[key], 10)) {
                        highestValues[key] = item[key];
                    }
                }
            });
        });

        const sorted = Object.entries(highestValues)
            .map(([name, value]) => ({ name, value: parseInt(value, 10) }))
            .sort((a, b) => b.value - a.value);

        const labels = sorted.map((entry) => entry.name);
        const data = sorted.map((entry) => entry.value);
        const barColors = labels.map((name) => repositoryColors[name] || '#CCCCCC');
        const maxInstalls = data.length ? Math.max(...data) : 0;

        function labelFitsInBar(value) {
            return maxInstalls > 0 && value / maxInstalls >= 0.08;
        }

        const currentInstallsChart = new Chart(CurrentInstalls, {
            type: 'bar',
            plugins: [ChartDataLabels],
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Installs',
                        data: data,
                        backgroundColor: barColors,
                        borderColor: barColors,
                        borderWidth: 1,
                        datalabels: {
                            display: true,
                            formatter: (value) => value.toLocaleString('de-DE'),
                            font: {
                                weight: '600',
                                size: 12,
                            },
                            anchor: (context) => {
                                const value = context.dataset.data[context.dataIndex];
                                return labelFitsInBar(value) ? 'center' : 'end';
                            },
                            align: (context) => {
                                const value = context.dataset.data[context.dataIndex];
                                return labelFitsInBar(value) ? 'center' : 'right';
                            },
                            offset: (context) => {
                                const value = context.dataset.data[context.dataIndex];
                                return labelFitsInBar(value) ? 0 : 6;
                            },
                            color: (context) => {
                                const value = context.dataset.data[context.dataIndex];
                                if (labelFitsInBar(value)) {
                                    return contrastOnBar(barColors[context.dataIndex]);
                                }
                                return chartUiColors().text;
                            },
                        },
                    },
                ],
            },
            options: {
                indexAxis: 'y',
                responsive: true,
                plugins: {
                    title: {
                        display: true,
                        text: 'Current Installs — All Repos',
                    },
                    legend: {
                        display: false,
                    },
                },
                scales: {
                    x: {
                        min: 0,
                        ticks: {
                            precision: 0,
                        },
                        grid: {},
                    },
                    y: {
                        grid: {},
                    },
                },
            },
        });

        applyThemedChartOptions(currentInstallsChart, 'Current Installs — All Repos');

        new MutationObserver(() => {
            applyThemedChartOptions(currentInstallsChart, 'Current Installs — All Repos');
        }).observe(document.documentElement, {
            attributes: true,
            attributeFilter: ['data-bs-theme', 'class'],
        });
    });

    const Daily = document.getElementById('Daily');
    let url_daily = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/daily.json';

    fetch(url_daily)
        .then((response) => {
            return response.json();
        })
        .then((daily_data) => {

            let datasets = [];
            let repositories = [
                'generator-sublime-package',
                'Sublime-AddFolderToProject',
                'Sublime-GitHubFileFetcher',
                'Sublime-QuoteWithMarker',
                'VSCode-AddFolderToWorkspace',
                'VSCode-GitHubFileFetcher',
                'VSCode-MyExtensionPack',
                'VSCode-QuoteWithMarker',
                'VSCode-RainbowColors',
                'VSCode-Znuny',
            ];

            const daily = daily_data.slice(-7);

            repositories.forEach(name => {
                datasets.push({
                    label: name,
                    data: daily,
                    backgroundColor: repositoryColors[name] || '#CCCCCC',
                    borderColor: repositoryColors[name] || '#CCCCCC',
                    parsing: {
                        xAxisKey: 'date',
                        yAxisKey: name,
                    }
                });
            });

            new Chart(Daily, {
                type: "bar",
                data: {
                    datasets: datasets,
                },
                options: {
                    responsive: true,
                    borderWidth: 1,
                    scales: {
                        xAxis: {
                            type: "time",
                            time: {
                                unit: "day"
                            }
                        },
                    },
                    scale: {
                        ticks: {
                            precision: 0
                        }
                    },
                    plugins: {
                        title: {
                            display: true,
                            text: 'Daily - Installs'
                        },
                    }
                }
            });
        });

    const VSCodeInstalls = document.getElementById('VSCodeInstalls');

    fetch(url_vscode)
        .then((response) => {
            return response.json();
        })
        .then((vscode_data) => {

            let datasets = [];
            let repositories = [
                'VSCode-AddFolderToWorkspace',
                'VSCode-GitHubFileFetcher',
                'VSCode-MyExtensionPack',
                'VSCode-QuoteWithMarker',
                'VSCode-RainbowColors',
                'VSCode-Znuny',
            ];

            repositories.forEach(name => {
                datasets.push({
                    type: 'line',
                    label: name,
                    data: vscode_data,
                    tension: 0.1,
                    spanGaps: true,
                    borderColor: repositoryColors[name] || '#CCCCCC',
                    backgroundColor: (repositoryColors[name] || '#CCCCCC') + '20',
                    parsing: {
                        xAxisKey: 'date',
                        yAxisKey: name,
                    }
                });
            });

            new Chart(VSCodeInstalls, {
                data: {
                    datasets: datasets,
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            min: 0,
                        },
                        xAxis: {
                            stacked: true,
                            type: 'time',
                            time: {
                                unit: 'month'
                            },
                        }
                    },

                    plugins: {
                        title: {
                            display: true,
                            text: 'VSCode - Installs'
                        },
                    }
                }
            });
        });

    const SublimeInstalls = document.getElementById('SublimeInstalls');

    fetch(url_sublime)
        .then((response) => {
            return response.json();
        })
        .then((sublime_data) => {

            let datasets = [];
            let repositories = [
                'Sublime-AddFolderToProject',
                'Sublime-GitHubFileFetcher',
                'Sublime-QuoteWithMarker',
            ];

            repositories.forEach(name => {
                datasets.push({
                    type: 'line',
                    label: name,
                    data: sublime_data,
                    tension: 0.1,
                    spanGaps: true,
                    borderColor: repositoryColors[name] || '#CCCCCC',
                    backgroundColor: (repositoryColors[name] || '#CCCCCC') + '20',
                    parsing: {
                        xAxisKey: 'date',
                        yAxisKey: name,
                    }
                });
            });

            new Chart(SublimeInstalls, {
                data: {
                    datasets: datasets,
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            min: 0,
                        },
                        xAxis: {
                            stacked: true,
                            type: 'time',
                            time: {
                                unit: 'month'
                            },
                        }
                    },

                    plugins: {
                        title: {
                            display: true,
                            text: 'Sublime - Installs'
                        }
                    }
                }
            });
        });

    const NPMInstalls = document.getElementById('NPMInstalls');

    fetch(url_npm)
        .then((response) => {
            return response.json();
        })
        .then((npm_data) => {
            let datasets = [];
            let repositories = [
                'generator-sublime-package',
            ];

            repositories.forEach(name => {
                datasets.push({
                    type: 'line',
                    label: name,
                    data: npm_data,
                    tension: 0.1,
                    spanGaps: true,
                    borderColor: repositoryColors[name] || '#CCCCCC',
                    backgroundColor: (repositoryColors[name] || '#CCCCCC') + '20',
                    parsing: {
                        xAxisKey: 'date',
                        yAxisKey: name,
                    }
                });
            });

            new Chart(NPMInstalls, {
                data: {
                    datasets: datasets,
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            min: 0,
                        },
                        xAxis: {
                            type: 'time',
                            time: {
                                unit: 'year'
                            },
                        }
                    },
                    plugins: {
                        title: {
                            display: true,
                            text: 'NPM - Installs'
                        },
                    }
                }
            });
        });

    const GitHubStars = document.getElementById('GitHubStars');
    const GitHubStarsPie = document.getElementById('GitHubStarsPie');
    let url_github = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/github-stars.json';

    fetch(url_github)
        .then((response) => {
            return response.json();
        })
        .then((github_data) => {

            let repositories = github_data.map(obj => {
            return Object.keys(obj).filter(key => key !== "date" && key !== "user" && key !== "total");
            });

            let flatRepositories = repositories.flat().sort();

            repositories = [...new Set(flatRepositories)];

            let datasets = [];
            repositories.forEach(name => {
                datasets.push({
                    label: name,
                    type: 'line',
                    data: github_data,
                    tension: 0.1,
                    spanGaps: true,
                    borderColor: repositoryColors[name] || '#CCCCCC',
                    backgroundColor: (repositoryColors[name] || '#CCCCCC') + '20',
                    parsing: {
                        xAxisKey: 'date',
                        yAxisKey: name,
                    }
                });
            });

            new Chart(GitHubStars, {
                data: {
                    datasets: datasets,
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            min: 0,
                        },
                        xAxis: {
                            type: 'time',
                            time: {
                                unit: 'year'
                            },
                        }
                    },
                    plugins: {
                        title: {
                            display: true,
                            text: 'GitHub Stars'
                        },
                    }
                }
            });

            let highestValues = {};

            github_data.forEach(item => {
                for (let key in item) {
                    if (key !== 'date' && key !== 'user' && key !== 'total') {
                        if (!highestValues[key] || parseInt(item[key]) > parseInt(highestValues[key])) {
                            highestValues[key] = item[key];

                        }
                    }
                }
            });

            let data = [];
            let labels = [];
            Object.keys(highestValues).forEach(name => {
                labels.push(name);
                data.push(highestValues[name]);
            });

            let pieColors = labels.map(name => repositoryColors[name] || '#CCCCCC');

            new Chart(GitHubStarsPie, {
                type: 'polarArea',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: 'Stars',
                            data: data,
                            backgroundColor: pieColors,
                            borderColor: pieColors,
                            hoverOffset: 4
                        }
                    ]
                },
            });
        });

</script>


![Sponsors](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/sponsors.svg){: .shadow .left }

![Languages](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/languages.indepth.svg){: .shadow .left }

![Reactions](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/comment.reactions.svg){: .shadow .left }

![Commit-Calendar Total](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/commit-calendar.total.svg){: .shadow w="1000" }

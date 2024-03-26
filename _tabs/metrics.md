---
layout: page
icon: fas fa-solid fa-chart-pie"
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

<script>

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
                        colors: {
                            forceOverride: true,
                        },
                        title: {
                            display: true,
                            text: 'Daily - Installs'
                        },
                    }
                }
            }
        )
    });

    const VSCodeInstalls = document.getElementById('VSCodeInstalls');
    let url_vscode = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/vscode-total.json';


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
                        colors: {
                            forceOverride: true,
                        },
                        title: {
                            display: true,
                            text: 'VSCode - Installs'
                        },
                    }
                }
            }
        )
    });

    const SublimeInstalls = document.getElementById('SublimeInstalls');
    let url_sublime = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/sublime-total.json';

    fetch(url_sublime)
        .then((response) => {
            return response.json();
        })
        .then((sublime_data) => {

            let datasets = [];
            let repositories = [
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
                        colors: {
                            forceOverride: true,
                        },
                        title: {
                            display: true,
                            text: 'Sublime - Installs'
                        }
                    }
                }
            }
        )
    });

    const NPMInstalls = document.getElementById('NPMInstalls');
    let url_npm = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/npm-total.json';

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
                        colors: {
                            forceOverride: true,
                        },
                        title: {
                            display: true,
                            text: 'NPM - Installs'
                        },
                    }
                }
            }
        )
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
                        colors: {
                            forceOverride: true,
                        },
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

            new Chart(GitHubStarsPie, {
                type: 'polarArea',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: 'Stars',
                            data: data,
                            hoverOffset: 4
                        }
                    ]
                },
            }
        )
    });

</script>


![Sponsors](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/sponsors.svg){: .shadow .left }

![Languages](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/languages.indepth.svg){: .shadow .left }

![Reactions](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/comment.reactions.svg){: .shadow .left }

![Commit-Calendar Total](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/commit-calendar.total.svg){: .shadow w="1000" }

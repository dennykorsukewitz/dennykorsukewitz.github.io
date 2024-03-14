---
layout: page
icon: fas fa-solid fa-chart-pie"
order: 6
---

<iframe src="https://github.com/sponsors/dennykorsukewitz/button" title="Sponsor dennykorsukewitz" height="32" width="114" style="border: 1; border-radius: 6px;"></iframe>
{: .prompt-tip }

<div>
  <canvas id="Daily"></canvas>
  <canvas id="VSCodeInstalls"></canvas>
  <canvas id="SublimeInstalls"></canvas>
  <canvas id="NPMInstalls"></canvas>
  <canvas id="GitHubStars"></canvas>
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
    let url_github = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/github-stars.json';

    fetch(url_github)
        .then((response) => {
            return response.json();
        })
        .then((github_data) => {
            new Chart(GitHubStars, {
                data: {
                    datasets: [
                        // {
                        //     type: 'line',
                        //     label: 'Total',
                        //     data: github_data,
                        //     tension: 0.1,
                        //     parsing: {
                        //         xAxisKey: 'date',
                        //         yAxisKey: 'total',
                        //     }
                        // },
                        {
                            label: 'Znuny-UBInventory',
                            type: 'line',
                            data: github_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'Znuny-UBInventory',
                            }
                        },
                        {
                            label: 'Znuny-QuickDelete',
                            type: 'line',
                            data: github_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'Znuny-QuickDelete',
                            }
                        },
                        {
                            label: 'MRBS-OTRS',
                            type: 'line',
                            data: github_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'MRBS-OTRS',
                            }
                        },
                        {
                            label: 'VSCode-AddFolderToWorkspace',
                            type: 'line',
                            data: github_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-AddFolderToWorkspace',
                            }
                        },
                        {
                            label: 'VSCode-GitHubFileFetcher',
                            type: 'line',
                            data: github_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-GitHubFileFetcher',
                            }
                        },
                        {
                            label: 'VSCode-Znuny',
                            type: 'line',
                            data: github_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-Znuny',
                            }
                        },
                        {
                            label: 'dennykorsukewitz',
                            type: 'line',
                            data: github_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'dennykorsukewitz',
                            }
                        },
                        {
                            label: 'dennykorsukewitz.github.io',
                            type: 'line',
                            data: github_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'dennykorsukewitz.github.io',
                            }
                        },
                    ],
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
            }
        )
    });

</script>


![Sponsors](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/sponsors.svg){: .shadow .left }

![Languages](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/languages.indepth.svg){: .shadow .left }

![Reactions](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/comment.reactions.svg){: .shadow .left }

![Commit-Calendar Total](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/commit-calendar.total.svg){: .shadow w="1000" }

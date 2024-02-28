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
            const daily = daily_data.slice(-7);
            new Chart(Daily, {
                type: "bar",
                data: {
                    datasets: [
                        {
                            label: 'VSCode-AddFolderToWorkspace',
                            data: daily,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-AddFolderToWorkspace',
                            }
                        },
                        {
                            label: 'VSCode-GitHubFileFetcher',
                            data: daily,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-GitHubFileFetcher',
                            }
                        },
                        {
                            label: 'VSCode-Znuny',
                            data: daily,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-Znuny',
                            }
                        },
                        {
                            label: 'VSCode-QuoteWithMarker',
                            data: daily,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-QuoteWithMarker',
                            }
                        },
                        {
                            label: 'VSCode-RainbowColors',
                            data: daily,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-RainbowColors',
                            }
                        },
                        {
                            label: 'VSCode-MyExtensionPack',
                            data: daily,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-MyExtensionPack',
                            }
                        },
                        {
                            label: 'Sublime-QuoteWithMarker',
                            data: daily,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'Sublime-QuoteWithMarker',
                            }
                        },
                        {
                            label: 'Sublime-GitHubFileFetcher',
                            data: daily,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'Sublime-GitHubFileFetcher',
                            }
                        },
                    ],
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

            new Chart(VSCodeInstalls, {
                data: {
                    datasets: [
                        {
                            type: 'line',
                            label: 'VSCode-AddFolderToWorkspace',
                            data: vscode_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-AddFolderToWorkspace',
                            }
                        },
                        {
                            type: 'line',
                            label: 'VSCode-GitHubFileFetcher',
                            data: vscode_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-GitHubFileFetcher',
                            }
                        },
                        {
                            type: 'line',
                            label: 'VSCode-Znuny',
                            data: vscode_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-Znuny',
                            }
                        },
                        {
                            type: 'line',
                            label: 'VSCode-QuoteWithMarker',
                            data: vscode_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-QuoteWithMarker',
                            }
                        },
                        {
                            type: 'line',
                            label: 'VSCode-RainbowColors',
                            data: vscode_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-RainbowColors',
                            }
                        },
                        {
                            type: 'line',
                            label: 'VSCode-MyExtensionPack',
                            data: vscode_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'VSCode-MyExtensionPack',
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
            new Chart(SublimeInstalls, {
                data: {
                    datasets: [
                        {
                            type: 'line',
                            label: 'Sublime-QuoteWithMarker',
                            data: sublime_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'Sublime-QuoteWithMarker',
                            }
                        },
                        {
                            type: 'line',
                            label: 'Sublime-GitHubFileFetcher',
                            data: sublime_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'Sublime-GitHubFileFetcher',
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
                        {
                            type: 'line',
                            label: 'Total',
                            data: github_data,
                            tension: 0.1,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'total',
                            }
                        },
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

---
layout: page
icon: fas fa-solid fa-chart-pie"
order: 6
---

<iframe src="https://github.com/sponsors/dennykorsukewitz/button" title="Sponsor dennykorsukewitz" height="32" width="114" style="border: 1; border-radius: 6px;"></iframe>
{: .prompt-tip }

<div>
  <canvas id="GitHubStars"></canvas>
  <canvas id="VSCodeInstalls"></canvas>
  <canvas id="SublimeInstalls"></canvas>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- Line below added, added date adapter for time scale -->
<script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns/dist/chartjs-adapter-date-fns.bundle.min.js"></script>

<script>
    const GitHubStars = document.getElementById('GitHubStars');
    let url_github = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/github-stars.json';

    fetch(url_github)
        .then((response) => {
            return response.json();
        })
        .then((github_data) => {
            let chart = new Chart(GitHubStars, {
                data: {
                    datasets: [
                        {
                            type: 'line',
                            label: 'Total',
                            data: github_data,
                            borderColor: '#4f81bc',
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
                            borderColor: '#1ccc71',
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
                            borderColor: '#1ccc71',
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

    const VSCodeInstalls = document.getElementById('VSCodeInstalls');
    let url_vscode = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/vscode.json';

    fetch(url_vscode)
        .then((response) => {
            return response.json();
        })
        .then((vscode_data) => {

            let chart = new Chart(VSCodeInstalls, {
                data: {
                    datasets: [
                        {
                            type: 'line',
                            label: 'VSCode-AddFolderToWorkspace',
                            data: vscode_data,
                            borderColor: '#4f81bc',
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
    let url_sublime = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/sublime.json';

    fetch(url_sublime)
        .then((response) => {
            return response.json();
        })
        .then((sublime_data) => {
            let chart = new Chart(SublimeInstalls, {
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
</script>


![Sponsors](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/sponsors.svg){: .shadow .left }

![Languages](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/languages.indepth.svg){: .shadow .left }

![Reactions](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/comment.reactions.svg){: .shadow .left }

![Commit-Calendar Total](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/commit-calendar.total.svg){: .shadow w="1000" }

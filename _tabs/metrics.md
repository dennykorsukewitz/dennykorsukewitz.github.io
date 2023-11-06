---
layout: page
icon: fas fa-solid fa-chart-pie"
order: 6
---

> <iframe src="https://github.com/sponsors/dennykorsukewitz/button" title="Sponsor dennykorsukewitz" height="32" width="114" style="border: 1; border-radius: 6px;"></iframe>
{: .prompt-tip }

<div>
  <canvas id="GitHubStars"></canvas>
  <!-- <canvas id="VSCode"></canvas> -->
  <!-- <canvas id="VSCodeInstall"></canvas> -->
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!--Line below added, added date adapter for time scale -->
<script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns/dist/chartjs-adapter-date-fns.bundle.min.js"></script>

<script>
    const GitHubStars = document.getElementById('GitHubStars');
    let url = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/github-stars.json';

    fetch(url)
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
                            label: 'DK4OTRS-UBInventory',
                            type: 'line',
                            data: github_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'DK4OTRS-UBInventory',
                            }
                        },
                        {
                            label: 'DK4Znuny-QuickDelete',
                            type: 'line',
                            data: github_data,
                            tension: 0.1,
                            spanGaps: true,
                            parsing: {
                                xAxisKey: 'date',
                                yAxisKey: 'DK4Znuny-QuickDelete',
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
        );
    })


//     const VSCode = document.getElementById('VSCode');
//     // let url = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/github-stars.json';

//     // fetch(url)
//     //     .then((response) => {
//     //         return response.json();
//     //     })
//     //     .then((vscode_data) => {

//             let vscode_data = [
//     {
//         "version": "1.2.0",
//         "date": "2023-10-25T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-10-24T00:00:00Z",
//         "counts":
//         {
//             "installCount": 2
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-10-23T00:00:00Z",
//         "counts":
//         {
//             "installCount": 2
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-10-20T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-09-30T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-09-28T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-09-27T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1,
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-09-24T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-09-23T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1,
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-09-22T00:00:00Z",
//         "counts":
//         {
//             "installCount": 2
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-09-12T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1
//         }
//     },
//     {
//         "version": "1.1.6",
//         "date": "2023-09-12T00:00:00Z",
//         "counts":
//         {
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.1.6",
//         "date": "2023-09-11T00:00:00Z",
//         "counts":
//         {
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-09-06T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-09-01T00:00:00Z",
//         "counts":
//         {
//             "uninstallCount": 1
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-08-31T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1,
//             "installCount": 2,
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.2.0",
//         "date": "2023-08-29T00:00:00Z",
//         "counts":
//         {
//             "installCount": 2
//         }
//     },
//     {
//         "version": "1.1.6",
//         "date": "2023-08-29T00:00:00Z",
//         "counts":
//         {
//             "uninstallCount": 2
//         }
//     },
//     {
//         "version": "1.1.6",
//         "date": "2023-08-27T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1,
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.6",
//         "date": "2023-08-26T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.6",
//         "date": "2023-08-21T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.6",
//         "date": "2023-08-20T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.6",
//         "date": "2023-08-19T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1
//         }
//     },
//     {
//         "version": "1.1.6",
//         "date": "2023-08-18T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.6",
//         "date": "2023-08-14T00:00:00Z",
//         "counts":
//         {
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.1.5",
//         "date": "2023-08-12T00:00:00Z",
//         "counts":
//         {
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.1.4",
//         "date": "2023-08-11T00:00:00Z",
//         "counts":
//         {
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.1.3",
//         "date": "2023-08-09T00:00:00Z",
//         "counts":
//         {
//             "uninstallCount": 1
//         }
//     },
//     {
//         "version": "1.1.3",
//         "date": "2023-08-08T00:00:00Z",
//         "counts":
//         {
//             "uninstallCount": 2
//         }
//     },
//     {
//         "version": "1.1.3",
//         "date": "2023-08-03T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.3",
//         "date": "2023-08-02T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1
//         }
//     },
//     {
//         "version": "1.1.3",
//         "date": "2023-08-01T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1
//         }
//     },
//     {
//         "version": "1.1.3",
//         "date": "2023-07-28T00:00:00Z",
//         "counts":
//         {
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.1.3",
//         "date": "2023-07-27T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.3",
//         "date": "2023-07-26T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1
//         }
//     },
//     {
//         "version": "1.1.3",
//         "date": "2023-07-25T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1
//         }
//     },
//     {
//         "version": "1.1.2",
//         "date": "2023-07-23T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 2
//         }
//     },
//     {
//         "version": "1.1.2",
//         "date": "2023-07-22T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 2
//         }
//     },
//     {
//         "version": "1.1.2",
//         "date": "2023-07-14T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 5
//         }
//     },
//     {
//         "version": "1.1.2",
//         "date": "2023-07-09T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.2",
//         "date": "2023-07-06T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.2",
//         "date": "2023-07-04T00:00:00Z",
//         "counts":
//         {
//             "uninstallCount": 1
//         }
//     },
//     {
//         "version": "1.1.2",
//         "date": "2023-07-03T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.2",
//         "date": "2023-06-29T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1,
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.2",
//         "date": "2023-06-22T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1,
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.1.2",
//         "date": "2023-06-21T00:00:00Z",
//         "counts":
//         {
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-06-19T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-06-14T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-06-07T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-06-06T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-06-05T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-06-03T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-31T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-30T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 2
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-29T00:00:00Z",
//         "counts":
//         {
//             "installCount": 2
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-26T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 4,
//             "installCount": 2,
//             "webDownloadCount": 2
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-24T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 4
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-23T00:00:00Z",
//         "counts":
//         {
//             "uninstallCount": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-22T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 3,
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-19T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-17T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 7,
//             "installCount": 5,
//             "webDownloadCount": 2,
//             "uninstallCount": 2
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-15T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1,
//             "installCount": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-12T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1,
//             "installCount": 1,
//             "webDownloadCount": 3
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-10T00:00:00Z",
//         "counts":
//         {
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-09T00:00:00Z",
//         "counts":
//         {
//             "installCount": 3,
//             "uninstallCount": 1
//         }
//     },
//     {
//         "version": "1.1.0",
//         "date": "2023-05-09T00:00:00Z",
//         "counts":
//         {
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.1.1",
//         "date": "2023-05-08T00:00:00Z",
//         "counts":
//         {
//             "webDownloadCount": 1
//         }
//     },
//     {
//         "version": "1.1.0",
//         "date": "2023-05-08T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1,
//             "installCount": 4,
//             "webDownloadCount": 1,
//             "uninstallCount": 1
//         }
//     },
//     {
//         "version": "1.0.5",
//         "date": "2023-05-08T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 2
//         }
//     },
//     {
//         "version": "1.0.5",
//         "date": "2023-05-05T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 1
//         }
//     },
//     {
//         "version": "1.0.5",
//         "date": "2023-05-03T00:00:00Z",
//         "counts":
//         {
//             "installCount": 1,
//             "webDownloadCount": 2
//         }
//     },
//     {
//         "version": "1.0.5",
//         "date": "2023-05-02T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 4,
//             "installCount": 3
//         }
//     },
//     {
//         "version": "1.0.5",
//         "date": "2023-05-01T00:00:00Z",
//         "counts":
//         {
//             "webPageViews": 4
//         }
//     }
// ];


//         let chart = new Chart(VSCode, {
//                 data: {
//                     datasets: [
//                         {
//                             type: 'bar',
//                             label: 'Install',
//                             data: vscode_data,
//                             borderColor: '#4f81bc',
//                             tension: 0.1,
//                             parsing: {
//                                 xAxisKey: 'date',
//                                 yAxisKey: 'counts.installCount',
//                             }
//                         },
//                         {
//                             type: 'bar',
//                             label: 'Uninstall',
//                             data: vscode_data,
//                             tension: 0.1,
//                             parsing: {
//                                 xAxisKey: 'date',
//                                 yAxisKey: 'counts.uninstallCount',
//                             }
//                         },
//                         {
//                             type: 'bar',
//                             label: 'WebPage Views',
//                             data: vscode_data,
//                             tension: 0.1,
//                             parsing: {
//                                 xAxisKey: 'date',
//                                 yAxisKey: 'counts.webPageViews',
//                             }
//                         },
//                         {
//                             type: 'bar',
//                             label: 'Web Download',
//                             data: vscode_data,
//                             tension: 0.1,
//                             parsing: {
//                                 xAxisKey: 'date',
//                                 yAxisKey: 'counts.webDownloadCount',
//                             }
//                         },

//                     ],
//                 },
//                 options: {
//                     responsive: true,
//                     scales: {
//                         y: {
//                             min: 0,
//                         },
//                         xAxis: {
//                             stacked: true,
//                             type: 'time',
//                             time: {
//                                 unit: 'month'
//                             },
//                         }
//                     },
//                     plugins: {
//                         colors: {
//                             forceOverride: true,
//                         },
//                         title: {
//                             display: true,
//                             text: 'VSCode - Znuny'
//                         },
//                     }
//                 }
//             }
//         );
//     // })

 // const VSCodeInstall = document.getElementById('VSCodeInstall');
    // let url = 'https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/data/github-stars.json';

    // fetch(url)
    //     .then((response) => {
    //         return response.json();
    //     })
    //     .then((vscode_data) => {

    // let vscode_data = [

    //     {
    //         "version": "1.2.0",
    //         "date": "2023-10-25T00:00:00Z",
    //         "VSCode-Znuny": 1
    //     },
    //     {
    //         "version": "1.2.0",
    //         "date": "2023-10-24T00:00:00Z",
    //         "VSCode-Znuny": 2
    //     },
    //     {
    //         "version": "1.2.0",
    //         "date": "2023-10-23T00:00:00Z",
    //         "VSCode-Znuny": 3
    //     },
    //     {
    //         "version": "1.2.0",
    //         "date": "2023-10-20T00:00:00Z",
    //         "VSCode-Znuny": 5
    //     },
    //     {
    //         "version": "1.2.0",
    //         "date": "2023-09-30T00:00:00Z",
    //         "VSCode-Znuny": 6
    //     },
    //     {
    //         "version": "1.2.0",
    //         "date": "2023-09-28T00:00:00Z",
    //         "VSCode-Znuny": 7
    //     },

    // ];


    //     let chart = new Chart(VSCodeInstall, {
    //             data: {
    //                 datasets: [
    //                     {
    //                         type: 'line',
    //                         label: 'Install',
    //                         data: vscode_data,
    //                         borderColor: '#4f81bc',
    //                         tension: 0.1,
    //                         parsing: {
    //                             xAxisKey: 'date',
    //                             yAxisKey: 'VSCode-AddFolderToWorkspace',
    //                         }
    //                     },
    //                     {
    //                         type: 'line',
    //                         label: 'Uninstall',
    //                         data: vscode_data,
    //                         tension: 0.1,
    //                         parsing: {
    //                             xAxisKey: 'date',
    //                             yAxisKey: 'VSCode-GitHubFileFetcher',
    //                         }
    //                     },
    //                     {
    //                         type: 'line',
    //                         label: 'WebPage Views',
    //                         data: vscode_data,
    //                         tension: 0.1,
    //                         parsing: {
    //                             xAxisKey: 'date',
    //                             yAxisKey: 'VSCode-Znuny',
    //                         }
    //                     },
    //                     {
    //                         type: 'line',
    //                         label: 'Web Download',
    //                         data: vscode_data,
    //                         tension: 0.1,
    //                         parsing: {
    //                             xAxisKey: 'date',
    //                             yAxisKey: 'VSCode-QuoteWithMarker',
    //                         }
    //                     },

    //                 ],
    //             },
    //             options: {
    //                 responsive: true,
    //                 scales: {
    //                     y: {
    //                         min: 0,
    //                     },
    //                     xAxis: {
    //                         stacked: true,
    //                         type: 'time',
    //                         time: {
    //                             unit: 'month'
    //                         },
    //                     }
    //                 },
    //                 plugins: {
    //                     colors: {
    //                         forceOverride: true,
    //                     },
    //                     title: {
    //                         display: true,
    //                         text: 'VSCode - Znuny'
    //                     },
    //                 }
    //             }
    //         }
    //     );
    // })

</script>


![Sponsors](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/sponsors.svg){: .shadow .left }

![Languages](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/languages.indepth.svg){: .shadow .left }

![Reactions](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/comment.reactions.svg){: .shadow .left }

![Commit-Calendar Total](https://raw.githubusercontent.com/dennykorsukewitz/dennykorsukewitz/dev/.github/metrics/commit-calendar.total.svg){: .shadow w="1000" }

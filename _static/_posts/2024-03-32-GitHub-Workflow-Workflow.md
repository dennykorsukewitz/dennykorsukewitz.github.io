---
title: Mastering Workflow Management with GitHub Actions
date: 2024-03-22
last_modified_at: 2024-03-22
author: dennykorsukewitz
categories: [Development, GitHub]
tags: ["GitHub"]
toc: true
mermaid: true
pin: true
---

# Mastering Workflow Management with GitHub Actions

The [`workflow.yml`](https://github.com/dennykorsukewitz/dennykorsukewitz/blob/dev/.github/workflows/workflow.yml) file is a GitHub Actions workflow that provides a set of operations for managing GitHub Actions workflows in a repository. It supports running workflows, listing all or failed workflow runs, and deleting all or failed workflow runs.

```mermaid
graph TD
    A[Start] --> B{Function?}
    B -->|run| R[Job: Run]
    B -->|List all| C[Job: List_All]
    B -->|List failed| D[Job: List_Failed]
    B -->|Delete all| E[Job: Delete_All]
    B -->|Delete failed| F[Job: Delete_Failed]
    R -->|Trigger Workflow| R1[Workflow Triggered]
    C -->|Retrieve all Workflows| C1[Print all Workflows]
    D -->|Retrieve Failed Workflows| D1[Print Failed Workflows]
    E -->|Retrieve all Workflows| E1[Delete all Workflows]
    F -->|Retrieve Failed Workflows| F1[Delete Failed Workflows]
    R1 --> G[End]
    C1 --> G
    D1 --> G
    E1 --> G
    F1 --> G
```

> The graphic may differ from the current workflow.
{: .prompt-warning }

## Why is this so cool?

The beauty of this workflow lies in its automation capabilities. It takes tasks that would normally require manual intervention and time, and automates them, saving developers countless hours of work.

- **Efficiency**: Instead of manually triggering workflows, this can be done automatically, saving time and reducing the chance of human error.
- **Visibility**: It provides a clear overview of all workflows or just the failed ones, making it easier to manage and troubleshoot them.
- **Cleanliness**: The ability to delete all or failed workflow runs helps keep your GitHub Actions clean and manageable. This is especially useful in large projects with many runs, where manual cleanup would be tedious.

## Workflow Triggers

This workflow is triggered manually using the `workflow_dispatch` event. It accepts several inputs:

- `FUNCTION`: Determines the function to perform. Options include "run", "list all", "list failed", "delete all", and "delete failed".
- `OWNER`: The owner of the repository.
- `REPOSITORY`: The repository where the workflows are located.
- `WORKFLOW_NAME`: The specific workflow to operate on. If not specified, all workflows will be used.

## Jobs

The workflow consists of four jobs: `Run`, `List_All`, `List_Failed`, `Delete_All`, and `Delete_Failed`. Each job runs on an Ubuntu 22.04 runner and uses a Personal Access Token (PAT) stored in the `GITHUB_TOKEN` secret.

### Run Job

This job runs the specified workflow(s). It runs if the `FUNCTION` input is "run". It uses the GitHub API to trigger the workflow(s).

### List_All Job

This job lists all workflow runs. It runs if the `FUNCTION` input is "list all". It uses the GitHub API to retrieve the workflow runs and prints their IDs to the console.

### List_Failed Job

This job lists all failed workflow runs. It runs if the `FUNCTION` input is "list failed". It uses the GitHub API to retrieve the workflow runs and filters them to only include those with a conclusion of "failure".

### Delete_All Job

This job deletes all workflow runs. It runs if the `FUNCTION` input is "delete all". It retrieves the workflow runs using the GitHub API, then deletes each one.

### Delete_Failed Job

This job deletes all failed workflow runs. It runs if the `FUNCTION` input is "delete failed". It retrieves the workflow runs, filters for those with a conclusion of "failure", and then deletes each one.

## Conclusion

The `workflow.yml` workflow provides a powerful way to manage GitHub Actions workflows. By using GitHub Actions and the GitHub API, it automates tasks that would otherwise need to be performed manually. However, it's important to use this workflow carefully, as deleting workflow runs cannot be undone.
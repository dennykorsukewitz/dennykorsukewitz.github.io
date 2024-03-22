---
title: Mastering Deployment Management with GitHub Actions
date: 2024-03-22
last_modified_at: 2024-03-22
author: dennykorsukewitz
categories: [Development, GitHub]
tags: ["GitHub"]
toc: true
mermaid: true
pin: true
---

# Mastering Deployment Management with GitHub Actions

The [`deployment.yml`](https://github.com/dennykorsukewitz/dennykorsukewitz/blob/dev/.github/workflows/deployment.yml) file is a GitHub Actions workflow that automates the management of GitHub deployments. It allows users to list all deployments, list failed deployments, delete all deployments, and delete failed deployments.

```mermaid
graph TD
    A[Start] --> B{Function?}
    B -->|List all| C[Job: List_All]
    B -->|List failed| D[Job: List_Failed]
    B -->|Delete all| E[Job: Delete_All]
    B -->|Delete failed| F[Job: Delete_Failed]
    C -->|Retrieve all Deployments| C1[Print all Deployments]
    D -->|Retrieve failed Deployments| D1[Print failed Deployments]
    E -->|Retrieve all Deployments| E1[Delete all Deployments]
    F -->|Retrieve failed Deployments| F1[Delete failed Deployments]
    C1 --> G[End]
    D1 --> G
    E1 --> G
    F1 --> G
```

> The graphic may differ from the current workflow.
{: .prompt-warning }

## Why is this so cool?

The beauty of this workflow lies in its automation capabilities. It takes tasks that would normally require manual intervention and time, and automates them, saving developers countless hours of work.

- **Efficiency**: Instead of manually managing deployments, this can be done automatically, saving time and reducing the chance of human error.
- **Visibility**: It provides a clear overview of all deployments or just the failed ones, making it easier to manage and troubleshoot them.
- **Cleanliness**: The ability to delete all or failed deployments helps keep your GitHub Actions clean and manageable. This is especially useful in large projects with many deployments, where manual cleanup would be tedious.

## Workflow Triggers

This workflow is triggered manually using the `workflow_dispatch` event. It accepts several inputs:

- `FUNCTION`: Determines the function to perform. Options include "list all", "list failed", "delete all", and "delete failed".
- `OWNER`: The owner of the repository.
- `REPOSITORY`: The repository where the deployments are located.
- `ENVIRONMENT`: The environment of the deployments. This input is optional.

## Jobs

The workflow consists of four jobs: `List_All`, `List_Failed`, `Delete_All`, and `Delete_Failed`. Each job runs on an Ubuntu 22.04 runner and uses a Personal Access Token (PAT) stored in the `GITHUB_TOKEN` secret.

### List_All Job

This job lists all deployments. It runs if the `FUNCTION` input is "list all". It uses the GitHub CLI (`gh`) to call the GitHub API and retrieve the deployments. The deployments are then printed to the console.

### List_Failed Job

This job lists all failed deployments. It runs if the `FUNCTION` input is "list failed". Like the `List_All` job, it uses the GitHub CLI to call the GitHub API. However, it filters the deployments to only include those with a status of "failure".

### Delete_All Job

This job deletes all deployments. It runs if the `FUNCTION` input is "delete all". It retrieves the deployments using the GitHub API, then deletes each one using a DELETE request.

### Delete_Failed Job

This job deletes all failed and inactive deployments. It runs if the `FUNCTION` input is "delete failed". It retrieves the deployments, filters for those with a status of "failure" or "inactive", and then deletes each one.

## Conclusion

The `deployment.yml` workflow provides a powerful way to manage GitHub deployments. By using GitHub Actions and the GitHub API, it automates tasks that would otherwise need to be performed manually. However, it's important to use this workflow carefully, as deleting deployments cannot be undone.

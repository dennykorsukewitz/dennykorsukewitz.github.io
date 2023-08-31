---
title: Git-Aliases GitHub
date: 2023-08-29
author: dennykorsukewitz
categories: [Development, Git]
tags: [ "git", "github" ]
toc: true
pin: true
---

## GitHub

These aliases are designed to check out GitHub PullRequest (PR) locally.

```bash
    # $1 = PullRequestID

    # Fetch a pull request from GitHub.
    pr-fetch = "!bash -c \"git fetch github pull/$1/head:pr$1\""

    # Fetch and checkout a pull request from GitHub.
    pr-clone = "!bash -c \"git fetch github pull/$1/head:pr$1 && git checkout pr$1\""

    pr-commit = "!bash -c 'git commit --author=\"$(git pr-author)\"'"
    pr-commit-reset = "!bash -c 'git reset --soft $(git branch-name) && git commit --author=\"$(git pr-author)\"'"

    # Push to PR
    pr-push = "!bash -c \"git push github HEAD:pr$1\""

    # Get the author of last commit.
    pr-author = !git log dev..$(git branch-name) --pretty=format:'%an <%ae>' | tail -n1
```
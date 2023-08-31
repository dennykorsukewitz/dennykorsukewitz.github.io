---
title: Git-Aliases
date: 2023-08-29
author: dennykorsukewitz
categories: [Development, Git]
tags: [ "git"]
toc: true
pin: true
---

## My Git Aliases

```bash
# ---
# Short aliases
# ---

    a         = !git add .
    b         = branch -vv --all
    bd        = !git branch -d $1
    bn        = !git rev-parse --abbrev-ref HEAD
    c         = commit
    ca        = !git commit --amend
    co        = checkout
    co-ours   = checkout --ours .
    co-theirs = checkout --theirs .
    cob       = checkout -b $2
    cp        = cherry-pick
    d         = diff
    p         = pull --rebase
    pu        = push
    s         = status

# ---
# General
# ---

    branch-name = !git rev-parse --abbrev-ref HEAD

# ---
# Log
# ---

    lg = log -p
    lg1 = lg1-specific --all
    lg2 = lg2-specific --all
    lg3 = lg3-specific --all

    lg1-specific = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'
    lg2-specific = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'
    lg3-specific = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'

# ---
# Cleanup
# ---

    # Clean Repository
    cleanup = !git reset --hard HEAD && git clean -d -f
    cleanup-branches         = !git remote prune origin
    cleanup-branches-dry-run = !git remote prune origin --dry-run

# ---
# Commit
# ---

    # Add, commit and push
    acp     = !git add . && git commit && git push

    # Push to branch ($2)
    push-to = !git push -u origin $2

    # Amend commit
    amend-commit = !git commit --amend

    # Reset one commit HEAD
    reset-soft-1 = !git reset --soft HEAD~1
    reset-hard-1 = !git reset --hard HEAD~1

    # All commits that are not merges on all branches
    all = !git log --pretty=oneline --abbrev-commit --all --no-merges

    # All commits today for only me
    today = !git all --since='12am' --committer=\"`git me`\"

    # Last commit info in svn style
    last = !git show --name-status
    last-files = !git last --pretty=format:""

# ---
# Patch
# ---

    # Create patch
    patch-create = !git format-patch -1 $1

    # Apply patch
    patch-apply = !git apply $1
```

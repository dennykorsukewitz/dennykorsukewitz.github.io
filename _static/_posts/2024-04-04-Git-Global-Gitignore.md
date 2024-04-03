---
title: Global .gitignore
date: 2024-04-04
last_modified_at: 2024-04-04
author: dennykorsukewitz
categories: [Development, Git]
tags: ["Git"]
toc: true
mermaid: true
pin: true
---

# Global .gitignore: Ignore Specific Files Across All Your Git Repositories

As a developer, you might have certain files or directories that you never want to commit to any of your Git repositories. These could be OS-specific files, IDE-specific files, or simply files for your personal use. Instead of adding these rules to each repository's .gitignore file, you can create a global .gitignore file to be used across all your repositories.

## Creating the Global .gitignore File

To create a global `.gitignore` file, follow these steps:

1. Create a file named `.gitignore` in your home directory (~/).

```
touch ~/.gitignore
```

2. Open the file in your text editor of choice and add any file or directory patterns that you want to ignore.

Here's an example `~/.gitignore` file:

```
# OS-specific files
.DS_Store
Thumbs.db

# Editor-specific files
.idea/
*.sublime-workspace
*.sublime-project
*.swp
*.swo

# IDE-specific files
.vscode/

# Log files
*.log

# Build artifacts
build/
bin/
obj/

# Python-specific files
*.pyc
__pycache__/

# Package manager files
/node_modules/
/bower_components/
/vendor/

# Personal files
.env
.vault
```

## Configuring Git to Use the Global `.gitignore` File

Now you need to configure Git to use your global `.gitignore` file.

### Linux / Mac

```
git config --global core.excludesfile ~/.gitignore
```

### Windows

```
git config --global core.excludesfile "%USERPROFILE%\.gitignore"
```

### If you're using PowerShell, use this command instead:

```
git config --global core.excludesFile "$Env:USERPROFILE\.gitignore"
```

## Verifying the Configuration

You can verify that Git is configured to use the global `.gitignore` file by checking the `.gitconfig` file in your home directory.

```
[core]
    excludesfile = /YOUR_PATH/.gitignore
```

Replace `YOUR_PATH` with your actual username path.

## Using Git Ignore in Visual Studio Code

If you use Visual Studio Code, you can make Git ignore the files specified in your global `.gitignore` file by enabling the following settings:

1. Search: Use Ignore Files - Ignores files specified in your local .gitignore file.
2. Search: Use Global Ignore Files - Ignores files specified in your global .gitignore file.

Alternatively, you can add the following settings to your settings.json file:

```json
"search.useIgnoreFiles": true,
"search.useGlobalIgnoreFiles": true
```

## Conclusion

Using a global .gitignore file can help you maintain consistent file ignoring rules across all your Git repositories. It is especially useful for ignoring files that are specific to your operating system or IDE, as well as any personal files you don't want to commit. By following the steps in this article, you can start using a global .gitignore file in your development workflow.
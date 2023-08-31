---
title: Git-Aliases Znuny
date: 2023-08-30
author: dennykorsukewitz
categories: [Development, Git]
tags: [ "git", "znuny" ]
toc: true
pin: true
---

## Console

### RebuildConfig - Maint::Config::Rebuild

```bash
    reb = "!bash -c \"if [ \"$(grep -c \"6.0.1 2017-11-21\" CHANGES.md)\" -ge '1' ]; then perl bin/otrs.Console.pl Maint::Config::Rebuild --cleanup; elif [ -e \"bin/otrs.Console.pl\" ]; then perl bin/otrs.Console.pl Maint::Config::Rebuild; else perl bin/otrs.RebuildConfig.pl; fi\""
```

### DeleteCache - Maint::Cache::Delete

```bash
    del = "!if [ -e 'bin/otrs.Console.pl' ]; then perl bin/otrs.Console.pl Maint::Cache::Delete && perl bin/otrs.Console.pl Maint::Loader::CacheCleanup; else perl bin/otrs.DeleteCache.pl && perl bin/otrs.LoaderCache.pl -o delete; fi"
```

### SetPermissions

```bash
    setp  = !sudo perl bin/otrs.SetPermissions.pl --otrs-user=bresch --otrs-group=staff --web-user=bresch --web-group=staff --admin-group=staff
```

## Fred

```bash
    fred = !sh -c 'tail -f -n 200 /znuny/$0/var/fred/STDERR.log'
    perf = !sh -c 'tail -f -n 200 /znuny/$0/var/log/Performance.log'
```

## ModuleTools

These are the main ModuleTools commands as Git alias.

https://github.com/znuny/module-tools

### Link

```bash
    link    = "!bash -c \"perl /module-tools/bin/otrs.ModuleTools.pl Module::File::Link /znuny/git/$1 /znuny/$2 && cd /znuny/$2 && git del && git reb && cd -\""
    unlink  = "!bash -c \"perl /module-tools/bin/otrs.ModuleTools.pl Module::File::Unlink /znuny/git/$1 /znuny/$2 && cd /znuny/$2 && git del && git reb \""
    rmlinks = "!bash -c \"cd /znuny/$1  && perl /module-tools/bin/otrs.ModuleTools.pl Module::File::Unlink --all /znuny/$1 && git del && git reb && cd - \""
```

## Database

```bash
    dbinstall   = "!bash -c \"perl /module-tools/bin/otrs.ModuleTools.pl Module::Database::Install $1\""
    dbupgrade   = "!bash -c \"perl /module-tools/bin/otrs.ModuleTools.pl Module::Database::Upgrade $1\""
    dbuninstall = "!bash -c \"perl /module-tools/bin/otrs.ModuleTools.pl Module::Database::Uninstall $1\""
```

## Code

```bash
    codeinstall   = "!bash -c \"perl /module-tools/bin/otrs.ModuleTools.pl Module::Code::Install $1\""
    codereinstall = "!bash -c \"perl /module-tools/bin/otrs.ModuleTools.pl Module::Code::Reinstall $1\""
    codeuninstall = "!bash -c \"perl /module-tools/bin/otrs.ModuleTools.pl Module::Code::Uninstall $1\""
    codeupgrade   = "!bash -c \"perl /module-tools/bin/otrs.ModuleTools.pl Module::Code::Upgrade $1\""
```

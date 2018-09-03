<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="144px" height="144px"/>

#### open_github
> A plugin for the [fish-shell](https://fishshell.com).

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v2.7.1-007EC7.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)

<br/>

`open_github` provides a shortcut to open the GitHub page for the current git branch in your browser.
This is adapted with permission from [snatchev's](https://github.com/snatchev) wonderful [gist](https://gist.github.com/snatchev/34e793af8ab1114d9e42).

## Install

With [fisherman]

```
fisher patrickf3139/open_github
```

With [Oh My Fish]
```fish
omf install open_github
```

## Usage
While in a git repository with a GitHub upstream, run
```fish
github
```

If GitHub 404s, make sure you have pushed the current branch.

[fisherman]: https://github.com/fisherman/fisherman
[Oh My Fish]: https://github.com/oh-my-fish/oh-my-fish

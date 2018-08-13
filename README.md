# open_github

[![Slack Room][slack-badge]][slack-link]

`open_github` provides a shortcut to open the GitHub page for the current git branch in your browser.
This is adapted with permission from [snatchev's](https://github.com/snatchev) wonderful [gist](https://gist.github.com/snatchev/34e793af8ab1114d9e42).


## Install

With [fisherman]

```
fisher patrickf3139/open_github
```

With [Oh My Fish]
```fish
omf install https://github.com/patrickf3139/open_github
```

## Usage
While in a git repository with a GitHub upstream, run
```fish
github
```

If GitHub 404s, make sure you have pushed the current branch.

[slack-link]: https://fisherman-wharf.herokuapp.com
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg
[fisherman]: https://github.com/fisherman/fisherman
[Oh My Fish]: https://github.com/oh-my-fish/oh-my-fish

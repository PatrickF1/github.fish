<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="144px" height="144px"/>

#### open_github
> A plugin for the [fish-shell](https://fishshell.com).

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v3.0.2-blue.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)

<br/>

`open_github` provides a shortcut to open the GitHub tree or pull request for the current git branch in your browser.
The basic functionality is heavily adapted with permission from [snatchev's](https://github.com/snatchev) wonderful [gist](https://gist.github.com/snatchev/34e793af8ab1114d9e42).

## Install
For the basic usage of opening the page for the current branch in your browser, you only need to install the plugin.
With [fisher]
```
fisher patrickf3139/open_github
```

With [Oh My Fish]
```fish
omf install open_github
```

To use `open_github` for opening pull requests, you will need to set up two more dependencies. First, install install [gron](https://github.com/tomnomnom/gron):
```fish
brew install gron
```
 Secondly, you will need to provide a GitHub Personal Access token. 
 These are needed because `open_github` queries the [GitHub API](https://developer.github.com/v3/pulls/#list-pull-requests) to get information about your repositories' pull requests and uses `gron` parses the JSON response using `gron`. And because the API hides information about private repositires, `open_github` needs to be authorized.

### Providing GitHub Credentials
Follow GitHub's directions for creating a personal access token [here](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line)
These are the minimal permissions the token will need:
<table><tr><td>
    <img alt="token permissions" src="./images/required-token-permissions.png">
</td></tr></table>

If you work with repositories protected by SSO, you will also need to enable SSO for that token. See directions [here](https://help.github.com/articles/authorizing-a-personal-access-token-for-use-with-a-saml-single-sign-on-organization)

Now, the script will need to read it from the environment. Set `GITHUB_AUTH_TOKEN` like so in your `config.fish` or similar:
```fish
set -x GITHUB_AUTH_TOKEN <insert token here>
```
## Usage
The `github` command only works when your working directory is within a git repository that has a GitHub upstream set. To open the branch page for the current branch, run
```fish
github
```
If GitHub 404s, make sure you have pushed the current branch.

To open the pull request for the current branch, run
```fish
github --pr
```
If the command fails, double check that your access token is valid and that a pull request has been opened for the current branch. Note that if multiple pull requests have been created for the current branch, the latest PR will be used.

[fisher]: https://github.com/jorgebucaran/fisher
[Oh My Fish]: https://github.com/oh-my-fish/oh-my-fish

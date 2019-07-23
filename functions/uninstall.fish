#!/usr/bin/env fish
if set -q GITHUB_AUTH_TOKEN
    printf "\033[33mReminder:\033[0m If you are uninstalling open_github, don't forget to remove GITHUB_AUTH_TOKEN from your environment variables.\n"
end
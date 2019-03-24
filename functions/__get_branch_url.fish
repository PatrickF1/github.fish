#!/usr/bin/env fish
# meant only to be called by github.fish
function __get_branch_url --argument-names github_base_url
    set -l branch (command git rev-parse --abbrev-ref HEAD)

    if [ $branch = 'HEAD' ]
        # couldn't find a branch or tag, so use the commit hash
        set branch (command git rev-parse HEAD)
    end

    set -l url (echo "$github_base_url/tree/$branch")
    echo "$url"
end
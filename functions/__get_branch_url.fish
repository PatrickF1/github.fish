#!/usr/bin/env fish
# meant only to be called by github.fish
function __get_branch_url --argument-names github_base_url
    set -l branch (command git rev-parse --abbrev-ref HEAD)

    if [ $branch = 'HEAD' ]
        # couldn't find a branch or tag, so use the commit hash
        set commit_hash (command git rev-parse HEAD)
        echo "$github_base_url/tree/$commit_hash"
    else
        set -l upstream_branch_name (git rev-parse --symbolic-full-name "$branch@{u}" | cut -d '/' -f 4)
        echo "$github_base_url/tree/$upstream_branch_name"
    end

end
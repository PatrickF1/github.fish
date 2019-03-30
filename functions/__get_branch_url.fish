#!/usr/bin/env fish
# meant only to be called by github.fish
function __get_branch_url --argument-names github_base_url
    set -l branch (command git rev-parse --abbrev-ref HEAD)

    if [ $branch = 'HEAD' ]
        # couldn't find a branch or tag, so use the commit hash
        set ref_name (command git rev-parse HEAD)
    else
        # In case the upstream branch is named differently from the local branch, grab
        # the branch's upstream name. The output of rev-parse needs to be trimmed as it
        # is in the format refs/remotes/remote_name/branch_name.
        set ref_name (git rev-parse --symbolic-full-name "$branch@{u}" | cut -d '/' -f 4,5,6)
    end
    echo "$github_base_url/tree/$ref_name"
end
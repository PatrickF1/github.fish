#!/usr/bin/env fish
# meant only to be called by github.fish
function __get_pr_url --argument-names github_base_url debug_mode
    if not type -q gron
        echo "You must have gron (https://github.com/tomnomnom/gron) installed." >&2
        echo "If you are on Mac and use homebrew, try 'brew install gron'" >&2
        return 1
    else if not set -q GITHUB_AUTH_TOKEN
        echo "Can't find GitHub auth token. Please set GITHUB_AUTH_TOKEN in your environment." >&2
        return 2
    end

    set -l branch (command git rev-parse --abbrev-ref HEAD)
    if [ $branch = 'HEAD' ]
        echo "You are on a detached HEAD. Pull requests cannot created off of detached HEADs" >&2
        return 3
    end

    echo "Querying GitHub. This may take several seconds..." >&2

    # format of owner_slash_repo should be owner/repo, e.g. patrickf1/github.fish
    set -l owner_slash_repo (echo "$github_base_url" | sed "s|^https://github.com/||")
    set -l request_url "https://api.github.com/repos/$owner_slash_repo/pulls?state=all&head=$owner_slash_repo:$branch"
    set -q debug_mode[1]; and echo "Making a request to $request_url" >&2

    set -l pull_requests_json (curl --silent -H "Authorization: token $GITHUB_AUTH_TOKEN" "$request_url")
    set -q debug_mode[1]; and echo "Response from Github API was $pull_requests_json" >&2

    if echo "$pull_requests_json" | grep -qi '"Not Found",'
        echo "Could not access the GitHub API. Please double check your GitHub auth token." >&2
        return 2
    end
    if echo "$pull_requests_json" | grep -qi '"Bad credentials",'
        echo "GitHub rejected the token provided. Please double check your auth token." >&2
        return 2
    end
    set -l pr_number (echo "$pull_requests_json" | command gron -m | command grep "json\[0\].number" | cut -d ' ' -f3 | sed "s/;//")

    if [ -z $pr_number ]
        echo "Couldn't find the PR using the GitHub API. Make sure a pull request has already been opened for the current branch." >&2
        return 3
    end

    set -l url (echo "$github_base_url/pull/$pr_number")
    echo "$url"
end
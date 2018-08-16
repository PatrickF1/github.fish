function github --description 'Open the GitHub page for the current git branch'
  set -l fetch_url (git ls-remote --get-url ^/dev/null)

  if [ $status -gt 0 ]
    echo 'Not in a git repository.' >&2
    return 1
  end

  if [ -z $fetch_url ]
    echo 'Not in a git repository.' >&2
    return 1
  end

  if [ -z (echo $fetch_url | grep github ) ]
    echo 'The remote "origin" is not a GitHub repository.' >&2
    return 2
  end

  set -l branch (command git rev-parse --abbrev-ref HEAD)

  if [ $branch = 'HEAD' ]
    # couldn't find a branch or tag, so use the commit hash
    set branch (command git rev-parse HEAD)
  end

  set -l url (echo "$fetch_url/tree/$branch" | sed 's|git@github.com:\(.*\)\.git|https://github.com/\1|')

  open "$url/$argv"
end
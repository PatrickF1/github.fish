function open_github --description 'Open the GitHub page for the current git branch'
  set -l fetch_url (command git remote --verbose show -n origin ^/dev/null | command grep Fetch | cut -c 14- )

  if [ $status -gt 0 ]
    echo 'Not in a git repository.'
    return 1
  end

  if [ -z $fetch_url ]
    echo 'Not in a git repository.'
    return 1
  end

  if [ -z (echo $fetch_url | grep github ) ]
    echo 'The remote "origin" is not a GitHub repository.'
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
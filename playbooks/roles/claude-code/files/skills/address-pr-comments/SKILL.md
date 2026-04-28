---
name: address-pr-comments
description: Rules for responding to comments on a github PR — must pass in the pr number when using the skill. Use when you need to reply/address comments on a given pr.
arguments: [pr_number]
user-invocable: true
disable-model-invocation: false
allowed-tools: Bash(gh auth status *) Bash(gh api graphql *)
---

Github Username: !`gh auth status --active --json hosts --jq '.hosts["github.com"][0].login'`
PR Metadata: !`gh api graphql -F owner='{owner}' -F name='{repo}' -F number=$pr_number -f query='query($owner: String!, $name: String!, $number: Int!) { repository(owner: $owner, name: $name) { pullRequest(number: $number) { title state headRefName baseRefName createdAt author { login } body reactions(first:20) { nodes { content user { login } } } } } }' --jq '.data.repository.pullRequest'`
PR Comments: !`gh api graphql -F owner='{owner}' -F name='{repo}' -F number=$pr_number -f query='query($owner: String!, $name: String!, $number: Int!) { repository(owner: $owner, name: $name) { pullRequest(number: $number) { comments(first:100) { nodes { id publishedAt author { login } body reactions(first:20) { nodes { content user { login } } } } } } } }' --jq .data.repository.pullRequest.comments.nodes`
PR Review Threads: !`gh api graphql -F owner='{owner}' -F name='{repo}' -F number=$pr_number -f query='query($owner: String!, $name: String!, $number: Int!) { repository(owner: $owner, name: $name) { pullRequest(number: $number) { reviewThreads(first:100) { nodes { id isResolved path comments(first:50) { nodes { id author { login } publishedAt body diffHunk reactions(first:20) { nodes { content user { login } } } } } } } } } }' --jq .data.repository.pullRequest.reviewThreads.nodes`

## Rules
- Run `git fetch` before doing running any `git` commands against the remote to ensure local repository is up-to-date
- If any code changes are made addressing a review thread, once the changes have been pushed, reply to the thread with one to two sentences then resolve the thread.
- If any code changes are made addressing a comment that is not a review thread, once the change have been pushed, react with `THUMBS_UP` on the comment.

---
name: address-comments
description: Rules for responding to comments on a github PR — must pass in the pr number when using the skill. Use when you need to reply/address comments on a given pr.
arguments: [pr_number]
user-invocable: true
disable-model-invocation: true
allowed-tools: Bash(gh auth status *) Bash(gh api graphql *)
---

Github Username: !`gh auth status --active --json hosts --jq '.hosts["github.com"][0].login'`
PR Metadata: !`gh api graphql -F owner='{owner}' -F name='{repo}' -F number=$pr_number -f query='query($owner: String!, $name: String!, $number: Int!) { repository(owner: $owner, name: $name) { pullRequest(number: $number) { title state reviewDecision headRefName baseRefName createdAt author { login } body reactions(first:20) { nodes { content user { login } } } } } }' --jq '.data.repository.pullRequest'`
PR Reviews: !`gh api graphql -F owner='{owner}' -F name='{repo}' -F number=$pr_number -f query='query($owner: String!, $name: String!, $number: Int!) { repository(owner: $owner, name: $name) { pullRequest(number: $number) { reviews(first:100) { nodes { id author { login } publishedAt body reactions(first:20) { nodes { content user { login } } } } } } } }' --jq .data.repository.pullRequest.reviews.nodes`
PR Review Threads: !`gh api graphql -F owner='{owner}' -F name='{repo}' -F number=$pr_number -f query='query($owner: String!, $name: String!, $number: Int!) { repository(owner: $owner, name: $name) { pullRequest(number: $number) { reviewThreads(first:100) { nodes { id isResolved path comments(first:50) { nodes { id author { login } publishedAt body diffHunk reactions(first:20) { nodes { content user { login } } } } } } } } } }' --jq .data.repository.pullRequest.reviewThreads.nodes`
Commits To Merge: !`gh api graphql -F owner='{owner}' -F name='{repo}' -F number=$pr_number -f query='query($owner: String!, $name: String!, $number: Int!) { repository(owner: $owner, name: $name) { pullRequest(number: $number) { commits(first:30) { nodes { commit { oid message author { user { login } } authoredDate } } } } } }' --jq '.data.repository.pullRequest.commits.nodes | map({"author": .commit.author.user.login, "dateTime": .commit.authoredDate, "message": .commit.message, "sha": .commit.oid})'`

Summarize the PR data. Do not include resolved threads in the summary. Make sure to include reactions for each review or review thread comment. Then let's discuss what to work on.

## Rules
- If any code changes are made addressing a review thread, once the changes have been pushed, reply to the thread with one to two sentences then resolve the thread.
- If any code changes are made addressing a regular review, once the changes have been pushed, react with a THUMBS_UP to the comment.

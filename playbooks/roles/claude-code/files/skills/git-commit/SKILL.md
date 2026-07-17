---
name: git-commit
description: Commit the changes from the current session to the local git repository. Use when any changes need to be committed to repo (whether or not they will be followed by a git push).
disable-model-invocation: true
model: haiku
allowed-tools:
    - Bash(git*add *)
    - Bash(git*diff *)
    - Bash(git*commit *)
    - Read(/tmp/**)
    - Read(/private/tmp/**)
    - Write(/tmp/**)
    - Write(/private/tmp/**)
---

## Commit Process

1. Stage all of the changes made in the current session to the local git repository.
2. Generate a one sentence headline summarizing the changes made to the project.
3. If the affect the changes have on the project is not obvious, Generate a body (3-5 sentences) explaining what affect those changes have on the project.
4. Save the generated commit message to a temporary file in the session's scratchpad directory. Use the Write tool directly; it creates any missing parent directories, so do NOT run `mkdir`. Follow the format below when generating the message.
5. Commit the changes by running `git commit --file <file_path>`. NEVER use `git commit -m << $(cat ...)`.
6. After The changes have been committed, display the entire commit message. If any sections were skipped, explain why in a single sentence per skipped section.

## Commit Message Format

```
[headline]

[body]

Refs: [jira ticket number]
Co-Authored-By: Claude [Model Name] <noreply@anthropic.com>
```

### Rules

- The headline and co-author sections are required. The body and Refs sections are optional.
- The headline should be a singe line
- The headline should follow [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/).
- The headline should be no longer than 50 characters long.
- The body can be multiple lines but each line should not be longer than 72 characters.
- The body should NOT include why a change was done in a specific way.
- The Refs line should NOT be included if no jira ticket or github issue is evident from the session.
- In the Co-Authored-By line, replace `[Model Name]` with the actual model being used in the session.

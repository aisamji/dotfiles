# Agent Instructions

## Environment Setup

- Install **Homebrew** (MacOS only)
- Install **Ansible**
- Install collections and roles: `ansible-galaxy collection install -r requirements.yml`
- Collect information from user to create `/etc/ansible/facts.d/identity.fact`

## Commands

**Configure packages and dotfiles**
`ansible-playbook --diff playbooks/site.yml --ask-become-pass`

**Validate playbook and Verify change**
`ansible-playbook --check --diff playbooks/site.yml`

**View Machine Facts**
`ansible-playbook playbooks/debug.yml`

## Permission Boundaries

**Always**
- use Ansible Vault for any tasks, handlers, etc. that need credentials
- use separate plays in the playbook for any task or group of tasks requiring the same handlers
- use gather and loop when copying or templating directories for a proper diff:
```yaml
- name: Gather config files
  ansible.builtin.find:
    paths: "{{ playbook_dir }}/files/config"
    recurse: true
    file_type: file
  register: dummy_config

- name: Copy config files to directory
  ansible.builtin.copy:
    src: "{{ item.path }}"
    dest: "{{ ansible_facts['env'].HOME }}/.config/dummy/{{ item.path | dirname |
      relpath(playbook_dir + '/files/config') }}/"
    mode: "0644"
    directory_mode: "0755"
  loop: "{{ dummy_config.files }}"
```

- set `changed_when` when using `ansible.builtin.command` module
- set `check_mode: false` if the `ansible.builtin.command` is read-only
- use fully qualified names for modules: `ansible.builtin.copy` instead of `copy`.
- symbolically link files and directories unless they require handlers or differ based on facts or variables. In that case, they should use `ansible.builtin.copy` or `ansible.builtin.template` as appropriate

**Never**
- save credentials in plaintext
- decrypt credentials in the session
- git push

## Project Structure

- `ansible.cfg` - The Ansible configuration file
- `bootstrap.sh` - The `sh` script executed by the user upon initial setup of the system
- `requirements.yml` - The dependencies for the ansible playbook
- `playbooks/site.yml` - The main playbook to configure packages and dotfiles
- `playbooks/debug.yml` - Print out machine facts to help debug
- `playbooks/files/` - The files and directories used by the main playbook that need to be copied and or symbolically linked
- `playbooks/templates/` - The files and directories that need to be templated by the main playbook

## Git Standards

**Commit style**
```
prefix(scope): what changed

- the specific files that changed
```

- The `prefix` and `what changed` are required.
- `prefix` must be one of `feat`, `fix`, `chore`
- The `(scope)` is optional and is used to indicate which play is being affected.
- `what changed` should be a summary while the bullet list should indicate what specifically changed and why.
- `what changed` and each item of the bullet list should be in imperative mood.
- `prefix(scope): what changed` should not be longer than 50 characters.
- Each item of the bullet list should not be longer than 72 characters.
- All commits should be made to `main`.


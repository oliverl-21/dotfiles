# dotfiles

## Installation

Ansible could be used for this

### Ansible

```yml
# playbook.yml
---
- hosts: local

  tasks:
  - name: setup dotfiles
    ansible.builtin.import_tasks: ../roles/common/tasks/shell.yml
```

### tasks File

```yml
---
- name: Git dotfiles repo
  ansible.builtin.git:
    repo: https://github.com/oliverl-21/dotfiles.git
    dest: ~/.dotfiles
    recursive: yes
    clone: true
    update: true
    track_submodules: yes
    version: master

- name: Link functions
  ansible.builtin.file:
    src: ~/.dotfiles/functions/.functions
    dest: ~/.functions
    state: link
    force: true

- name: Link aliases
  ansible.builtin.file:
    src: ~/.dotfiles/alias/.aliases
    dest: ~/.aliases
    state: link
    force: true

- name: VIMrc
  ansible.builtin.file:
    src: ~/.dotfiles/vim/.vimrc
    dest: ~/.vimrc
    state: link
    force: true

- name: Nanorc
  ansible.builtin.file:
    src: ~/.dotfiles/.nanorc
    dest: ~/.nanorc
    state: link
    force: true

# bash setup
- name: Link bash_prompt
  ansible.builtin.file:
    src: ~/.dotfiles/bash/.bash_prompt
    dest: ~/.bash_prompt
    state: link
    force: true
  when: ansible_facts.user_shell == "/bin/bash"

- name: Link bashrc
  ansible.builtin.file:
    src: ~/.dotfiles/bash/.bashrc
    dest: ~/.bashrc
    state: link
    force: true
  when: ansible_facts.user_shell == "/bin/bash"

# zsh setup
- name: Link zshrc
  ansible.builtin.file:
    src: ~/.dotfiles/zsh/.zshrc
    dest: ~/.zshrc
    state: link
    force: true
  when: ansible_facts.user_shell == "/bin/zsh"

```

#
# ZSH Shell
#

# ZSH Package
zsh:
  pkg.installed

# Install Oh-My-Zsh
clone_oh_my_zsh:
  cmd.run:
    - name: "git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh"
    - user: vagrant
    - cwd: /home/vagrant
    - require:
      - pkg: zsh
      - pkg: git
    - unless: 'test -d /home/vagrant/.oh-my-zsh'

# Config, Parse .zshrc
/home/vagrant/.zshrc:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - source: salt://dev_zsh/files/.zshrc
    - template: jinja
    - require:
      - pkg: zsh
      - cmd: clone_oh_my_zsh

/home/vagrant/.oh-my-zsh/themes/eric.zsh-theme:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - source: salt://dev_zsh/files/eric.zsh-theme
    - template: jinja
    - require:
      - pkg: zsh
      - cmd: clone_oh_my_zsh

# Add plugin for git flow completion
/home/vagrant/.oh-my-zsh/plugins/git-flow-completion/git-flow-completion.plugin.zsh:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - source: salt://dev_zsh/files/git-flow-completion.plugin.zsh
    - makedirs: True
    - require:
      - pkg: zsh
      - cmd: clone_oh_my_zsh

# Ensure ZSH is default shell
set_zsh_default_shell:
  cmd.run:
    - name: "chsh -s /usr/bin/zsh vagrant"
    - require:
      - pkg: zsh
      - pkg: git
    - unless: "grep -E '^vagrant.+:/usr/bin/zsh$' /etc/passwd"

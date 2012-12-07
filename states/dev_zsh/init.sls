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
      - pkg.installed: zsh
      - pkg.installed: git
      - pkg.installed: git-core
    - unless: 'test -d /home/vagrant/.oh-my-zsh'

# Tmuxinator Plugin Directory for Oh-My-Zsh
/home/vagrant/.oh-my-zsh/plugins/tmuxinator:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - require:
      - cmd.run: clone_oh_my_zsh

# Tmuxinator Autocomplete
/home/vagrant/.oh-my-zsh/plugins/tmuxinator/_tmuxinator:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - source: salt://dev_zsh/files/_tmuxinator
    - require:
      - pkg.installed: tmux
      - cmd.run: clone_oh_my_zsh
      - file.directory: /home/vagrant/.oh-my-zsh/plugins/tmuxinator

# Tmuxinator Autocomplete Plugin
/home/vagrant/.oh-my-zsh/plugins/tmuxinator/tmuxinator.plugin.zsh:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - source: salt://dev_zsh/files/tmuxinator.plugin.zsh
    - require:
      - pkg.installed: tmux
      - cmd.run: clone_oh_my_zsh
      - file.directory: /home/vagrant/.oh-my-zsh/plugins/tmuxinator
      - file: /home/vagrant/.oh-my-zsh/plugins/tmuxinator/_tmuxinator

# Config
/home/vagrant/.zshrc:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - source: salt://dev_zsh/files/.zshrc
    - template: jinja
    - require:
      - pkg.installed: zsh
      - cmd.run: clone_oh_my_zsh

# Ensure ZSH is default shell
set_zsh_default_shell:
  cmd.run:
    - name: "chsh -s /usr/bin/zsh vagrant"
    - require:
      - pkg.installed: zsh
      - pkg.installed: git
      - pkg.installed: git-core
      - file: chris_zsh_theme
    - unless: "grep -E '^vagrant.+:/usr/bin/zsh$' /etc/passwd"

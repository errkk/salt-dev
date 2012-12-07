ensure_vim_installed:
    pkg:
        - installed
        - name: vim


/home/vagrant/.vimrc:
    file.managed:
        - user: vagrant
        - group: vagrant
        - mode: 755
        - source: salt://dev_vim/files/.vimrc
        - require:
            - pkg.installed: ensure_vim_installed


clone_oh_my_zsh:
  cmd.run:
    - name: "git clone git://github.com/gmarik/vundle.git /home/vagrant/bundle/vundle/"
    - user: vagrant
    - cwd: /home/vagrant
    - require:
      - pkg.installed: vim
    - unless: 'test -d /home/vagrant/bundle/vundle/'

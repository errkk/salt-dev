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

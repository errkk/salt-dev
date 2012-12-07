ensure_git_installed:
    pkg:
        - installed
        - name: git

/home/vagrant/.gitconfig:
    file.managed:
        - user: vagrant
        - group: vagrant
        - mode: 755
        - source: salt://dev_git/files/.gitconfig
        - require:
        - pkg.installed: ensure_git_installed

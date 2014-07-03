ensure_git_installed:
    pkg:
        - installed
        - name: git

ensure_rake_installed:
    pkg:
        - installed
        - name: rake

ensure_tig_installed:
    pkg:
        - installed
        - name: tig

/home/vagrant/.gitconfig:
    file.managed:
        - user: vagrant
        - group: vagrant
        - mode: 755
        - source: salt://dev_git/files/.gitconfig
        - require:
            - pkg: ensure_git_installed

/usr/share/git-core/templates/hooks/post-checkout:
    file.managed:
        - user: vagrant
        - group: vagrant
        - mode: 755
        - source: salt://dev_git/files/post-checkout
        - require:
            - pkg: ensure_git_installed

hub:
    git.latest:
        - name: git://github.com/defunkt/hub.git
        - target: /home/vagrant/bin/hub
        - rev: master
    cmd.wait:
        - name: 'sudo rake install prefix=/usr/local'
        - cwd: /home/vagrant/bin/hub
        - watch:
            - git: hub
        - require:
            - pkg: ensure_rake_installed


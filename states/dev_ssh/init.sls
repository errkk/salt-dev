ensure_ssh_installed:
    pkg:
        - installed
        - name: ssh

/home/vagrant/.ssh/id_rsa:
    file.managed:
        - user: vagrant
        - group: vagrant
        - mode: 600
        - source: salt://dev_ssh/files/id_rsa
        - require:
            - pkg: ensure_ssh_installed

/home/vagrant/.ssh/id_rsa.pub:
    file.managed:
        - user: vagrant
        - group: vagrant
        - mode: 600
        - source: salt://dev_ssh/files/id_rsa.pub
        - require:
            - pkg: ensure_ssh_installed

ensure_vim_installed:
  pkg:
    - installed
    - name: vim


/home/vagrant/.vim/:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - require:
      - pkg.installed: git


clone_vundle:
  cmd.run:
    - name: "git clone git://github.com/gmarik/vundle.git /home/vagrant/.vim/bundle/vundle/"
    - user: vagrant
    - cwd: /home/vagrant/
    - require:
      - pkg.installed: vim
      - pkg.installed: git
    - unless: 'test -d /home/vagrant/.vim/bundle/vundle/'


/home/vagrant/.vim/bundle/:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - require:
      - pkg.installed: git
      - cmd.run: clone_vundle
      - pkg.installed: ensure_vim_installed


/home/vagrant/.vimrc:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - source: salt://dev_vim/files/.vimrc
    - require:
      - pkg.installed: ensure_vim_installed
      - cmd.run: clone_vundle

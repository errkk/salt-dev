ensure_vim_installed:
  pkg:
    - installed
    - name: vim


/home/vagrant/.vim:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - require:
      - pkg.installed: git
      - pkg.installed: ensure_vim_installed


/home/vagrant/.vim/bundle:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - require:
      - file.directory: /home/vagrant/.vim


/home/vagrant/.vim/bundle/vundle:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - require:
      - file.directory: /home/vagrant/.vim/bundle


clone_vundle:
  cmd.run:
    - name: "git clone git://github.com/gmarik/vundle.git /home/vagrant/.vim/bundle/vundle/"
    - user: vagrant
    - cwd: /home/vagrant/
    - require:
      - pkg.installed: vim
      - pkg.installed: git
      - file.directory: /home/vagrant/.vim/bundle/vundle
    - unless: 'test -d /home/vagrant/.vim/bundle/vundle/.git'


/home/vagrant/.vimrc:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - source: salt://dev_vim/files/.vimrc


/home/vagrant/.vim/colors:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - require:
      - file.directory: /home/vagrant/.vim


/home/vagrant/.vim/colors/solarized.vim:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - source: salt://dev_vim/files/solarized.vim
    - require:
      - file.directory: /home/vagrant/.vim/colors

#
# PDB ++
#

/home/vagrant/.pdbrc.py:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - source: salt://dev_pdbpp/files/pdbrc.py
    - template: jinja

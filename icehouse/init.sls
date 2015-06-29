include:
  - devstack

setuptools:
  pip.installed:
    - upgrade: True
    - require:
      - pkg: python-pip

decorator:
  pip.installed:
    - upgrade: True
    - require:
      - pkg: python-pip

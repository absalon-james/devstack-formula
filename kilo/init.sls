devstack-repo:
  git.latest:
    - name: https://github.com/openstack-dev/devstack.git
    - target: /home/stack/devstack
    - rev: stable/kilo
    - user: stack
    - force_checkout: True
    - require:
      - user: stack-user

/home/stack/devstack/local.conf:
  file.managed:
    - name: /home/stack/devstack/local.conf
    - source: salt://devstack/files/kilo/local.conf
    - template: jinja
    - require:
      - git: devstack-repo

devstack-stack:
  cmd.script:
    - name: salt://devstack/files/kilo/stack.sh
    - source: salt://devstack/files/kilo/stack.sh
    - template: jinja
    - user: stack
    - output_loglevel: quiet
    - require:
      - file: /home/stack/devstack/local.conf

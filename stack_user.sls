stack-user:
  user.present:
    - name: stack
    - shell: /bin/bash
    - groups:
      - sudo

stack-key:
  cmd.run:
    - name: ssh-keygen -q -N '' -f /home/stack/.ssh/id_rsa
    - user: stack
    - creates: /home/stack/.ssh/id_rsa
    - require:
      - user: stack

/etc/sudoers.d/90-stack-user:
  file.managed:
    - source: salt://devstack/files/90-stack-user
    - mode: 440

Description
===========
Simple salt formula for deploying devstack on to a baremetal io instance running Ubuntu. Not for production. At this time, only kilo is supported.

Example /etc/salt/grains on devstack node:
```yaml
roles:
  - kilo
```

Example /srv/salt/top.sls
```yaml
base:
  'roles:kilo':
    - match: grain
    - devstack
```

Example /srv/pillar/top.sls
```yaml
base:
  'roles:kilo':
    - match: grain
    - env
```

Example /srv/pillar/env/init.sls
```yaml
default_security_rules:
  # SSH
  # nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
  - protocol: tcp
    start: 22
    stop: 22
    cidr: 0.0.0.0/0

  # ICMP
  # nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
  - protocol: icmp
    start: -1
    stop: -1
    cidr: 0.0.0.0/0

default_keypairs:
  - name: heat-key
    path: /home/stack/.ssh/id_rsa.pub

default_images:
  - name: "Ubuntu 12.04 software config"
    disk_format: qcow2
    location: http://ab031d5abac8641e820c-98e3b8a8801f7f6b990cf4f6480303c9.r33.cf1.rackcdn.com/ubuntu-softwate-config.qcow2
    public: True
    container_format: bare
```

include:
  - devstack.base
  - devstack.baremetal
  - devstack.stack_user
{% if 'kilo' in salt['grains.get']('roles', []) %}
  - devstack.kilo
{% endif %}
{% if 'juno' in salt['grains.get']('roles', []) %}
  - devstack.juno
{% endif %}
{% if 'icehouse' in salt['grains.get']('roles', []) %}
  - devstack.icehouse
{% endif %}
  - devstack.env

{%- set password = salt['pillar.get']('password', 'secrete') -%}
{%- set ip = salt['network.ipaddrs']('bond0.101')[0] -%}

# Default security group rules
{% for rule in salt['pillar.get']('default_security_rules', []) %}
nova secgroup-add-rule default {{ rule['protocol'] }} {{ rule['start'] }} {{ rule['stop'] }} {{ rule['cidr'] }}:
  cmd.run:
    - user: stack
    - env:
      - OS_USERNAME: admin
      - OS_TENANT_NAME: admin
      - OS_PASSWORD: {{ password }}
      - OS_AUTH_URL: 'http://{{ ip }}:5000/v2.0'
{% endfor %}

# Default ssh keypairs
{% for keypair in salt['pillar.get']('default_keypairs', []) %}
nova keypair-add "{{ keypair['name'] }}" --pub-key "{{ keypair['path'] }}":
  cmd.run:
    - user: stack
    - env:
      - OS_USERNAME: admin
      - OS_TENANT_NAME: admin
      - OS_PASSWORD: {{ password }}
      - OS_AUTH_URL: 'http://{{ ip }}:5000/v2.0'
{% endfor %}

# Default Images
{% for image in pillar.get('default_images', []) %}
glance image-create --name "{{ image['name'] }}" {% if 'disk_format' in image -%}--disk-format {{ image['disk_format'] }}{%- endif %} --location {{ image['location'] }} {% if 'public' in image -%}--is-public {{ image['public'] }}{%- endif %} {% if 'container_format' in image -%}--container-format {{ image['container_format'] }}{%- endif %}:
  cmd.run:
    - user: stack
    - env:
      - OS_USERNAME: admin
      - OS_TENANT_NAME: admin
      - OS_PASSWORD: {{ password }}
      - OS_AUTH_URL: 'http://{{ ip }}:5000/v2.0'
{% endfor %}

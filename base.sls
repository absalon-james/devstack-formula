ufw:
  pkg.purged

git:
  pkg.installed

vim:
  pkg.installed

python-pip:
  pkg.installed

lvm2:
  pkg.installed

squid3:
  pkg.installed

set_ip_forwarding:
  module.run:
    - name: sysctl.persist
    - m_name: net.ipv4.ip_forward
    - value: 1

# sudo iptables -t nat -A POSTROUTING -o bond0.101 -j MASQUERADE
masquerade:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - out-interface: bond0.101
    - target: MASQUERADE

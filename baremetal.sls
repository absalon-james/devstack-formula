# Configure the ssds

/dev/sdb:
  lvm.pv_present

/dev/sdc:
  lvm.pv_present

ssdpool:
  lvm.vg_present:
    - devices: /dev/sdb,/dev/sdc
    - require:
      - lvm: /dev/sdb
      - lvm: /dev/sdc

ssd1:
  lvm.lv_present:
    - vgname: ssdpool
    - size: 1024G
    - require:
      - lvm: ssdpool

/dev/mapper/ssdpool-ssd1:
  blockdev.formatted:
    - fs_type: ext4
    - require:
      - lvm: ssd1

/opt:
  mount.mounted:
    - fstype: ext4
    - device: /dev/mapper/ssdpool-ssd1
    - require:
      - blockdev: /dev/mapper/ssdpool-ssd1

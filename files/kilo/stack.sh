#!/bin/bash
cd /home/stack/devstack
./unstack.sh &> /home/stack/stacklog
if [ ! -f /etc/mysql/my.cnf ]; then
    ./stack.sh ?> /home/stack/stacklog
    ./unstack.sh ?> /home/stack/stacklog
    # Fix "too many connections" mysql error
    sudo sed -i 's/#max_connections        = 100/max_connections = 1000/g' /etc/mysql/my.cnf
fi
./stack.sh &> /home/stack/stacklog

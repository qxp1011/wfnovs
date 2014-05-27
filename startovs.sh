#!/bin/bash

help()
{
echo ===============================================================================
echo start openvswitch usage:
echo ===============================================================================
echo "./startovs.sh [openvswitch path] [netdev] [controller_ip:port]"
echo ===============================================================================
}

if [ "$1" == "help" ] || [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ]
then
	help
	exit 1
else
	cd $1
	modprobe openvswitch
	pkill -9 ovsdb-server
	pkill -9 ovs-vswitchd
	rm -rf /usr/local/etc/openvswitch
	mkdir -p /usr/local/etc/openvswitch
	ovsdb-tool create /usr/local/etc/openvswitch/conf.db vswitchd/vswitch.ovsschema
	ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock \
                     --remote=db:Open_vSwitch,Open_vSwitch,manager_options \
                     --private-key=db:Open_vSwitch,SSL,private_key \
                     --certificate=db:Open_vSwitch,SSL,certificate \
                     --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert \
                     --pidfile --detach
	ovs-vsctl --no-wait init
	ovs-vswitchd --pidfile=ovs-vswitchd.pid --overwrite-pidfile --log-file &
	ifconfig $2 down
	ifconfig $2 promisc up
	ovs-vsctl add-br br0
	ovs-vsctl add-port br0 $2
	ovs-vsctl set-controller br0 tcp:$3
	exit 1
fi


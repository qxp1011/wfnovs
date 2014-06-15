#
# Copyright (C) 2013-2014, Nanjing WFNEX Technology Co., Ltd
# Author Yi Jian, yijian@wfnex.com
#
include $(USER_DEPTH)/make/makeinclude/wf_pre.mak
USER_KMODULE_NAME    = kwfnovs
USER_KMODULE_INCLUDE = -I$(USER_DEPTH)/src/kmodule/kwfnovs -I$(USER_DEPTH)/include/
USER_KMODULE_OBJ = \
	actions.o \
	datapath.o \
	dp_notify.o \
	flow.o \
	flow_netlink.o \
	flow_table.o \
	vport.o \
	vport-internal_dev.o \
	vport-netdev.o\
	vport-vxlan.o\
	vport-gre.o
USER_KMODULE_TARGET = $(USER_DEPTH)/target/
include $(USER_DEPTH)/make/makeinclude/wf_post.mak

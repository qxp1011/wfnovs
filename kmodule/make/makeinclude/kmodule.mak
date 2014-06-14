#
# Copyright (C) 2013-2014, Nanjing WFNEX Technology Co., Ltd
# Author yijian, yijian@wfnex.com
#

_MODULE_NAME:=$(USER_KMODULE_NAME)
_MODULE_OBJ:=$(USER_KMODULE_OBJ)

_MODULE_TARGET_PATH:=$(USER_KMODULE_TARGET)

$(_MODULE_NAME)-objs := $(_MODULE_OBJ) 
obj-m :=$(_MODULE_NAME).o

ccflags-y += -I$(USER_KMODULE_INCLUDE)

_EXIST_MODULE := $(shell lsmod |grep $(_MODULE_NAME))

ifeq (,$(_MODULE_TARGET_PATH))
	_MODULE_TARGET_PATH = $(SRC_ROOT)/lib/modules
endif

all:
	$(ECHO) Starting Build Kernel Module.............
	$(MAKE) V=1 -C /lib/modules/$(shell uname -r)/build M=$(shell pwd) 
	@if [ ! -d $(_MODULE_TARGET_PATH) ]; then $(MKDIR) $(_MODULE_TARGET_PATH); fi
	$(CP) $(_MODULE_NAME).ko $(_MODULE_TARGET_PATH)
	$(ECHO) cp $(_MODULE_NAME).ko $(_MODULE_TARGET_PATH)
#ifneq (,$(_EXIST_MODULE))
#	$(ECHO) The Module is exist so replace it! $(_MODULE_NAME)
#	rmmod $(_MODULE_NAME)
#	insmod $(_MODULE_NAME).ko
#else
#	$(ECHO) Install the module! $(_MODULE_NAME)
#	insmod $(_MODULE_NAME).ko
#endif

clean:
	$(MAKE) -C /lib/modules/$(shell uname -r)/build M=$(shell pwd) clean

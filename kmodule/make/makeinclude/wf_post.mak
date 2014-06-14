#
# Copyright (C) 2013-2014, Nanjing WFNEX Technology Co., Ltd
# Author yijian, yijian@wfnex.com
#

ifdef USER_KMODULE_NAME
  include $(SRC_ROOT)/make/makeinclude/kmodule.mak
else ifdef USER_SUB_DIRS
  include $(SRC_ROOT)/make/makeinclude/subdir_multimk.mak
else
  all clean: lib_error
endif
	
lib_error:
	@echo $(USER_LIB)
	@echo "Error, must define someting."
#
# Copyright (C) 2013-2014, Nanjing WFNEX Technology Co., Ltd
# Author yijian, yijian@wfnex.com
#

SUB_DIRS =
ifdef USER_SUB_DIRS
  SUB_DIRS = $(addsuffix .subdirs, $(USER_SUB_DIRS))
endif # USER_SUB_DIRS

TARGETS_LOCAL  = all.local clean.local
TARGETS_NESTED = $(TARGETS_LOCAL:.local=.nested)

all: all.nested
	
clean: clean.nested
	
%.mmakefiles: %
	$(MAKE) -f $< $(MMAKEFILES_TARGET)

%.subdirs: %
	$(MAKE) -C $< $(SUBDIRS_TARGET)

$(TARGETS_NESTED):
ifdef MULTI_MAKEFILES
	$(MAKE) -f $(MAKEFILE) MMAKEFILES_TARGET=$(@:.nested=) $(MULTI_MAKEFILES)
endif # MULTI_MAKEFILES
ifdef SUB_DIRS
	$(MAKE) -f $(MAKEFILE) SUBDIRS_TARGET=$(@:.nested=) $(SUB_DIRS)
endif # SUB_DIRS
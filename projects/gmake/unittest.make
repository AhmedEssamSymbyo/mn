# GNU Make project makefile autogenerated by Premake

ifndef config
  config=debug_static
endif

ifndef verbose
  SILENT = @
endif

.PHONY: clean prebuild prelink

ifeq ($(config),debug_static)
  RESCOMP = windres
  TARGETDIR = ../../bin/static/debug
  TARGET = $(TARGETDIR)/unittest
  OBJDIR = obj/static/debug/unittest
  DEFINES += -DOS_LINUX -DDEBUG
  INCLUDES += -I../../unittest/doctest -I../../include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -g -Wall -Wextra
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -g -Wall -Wextra -std=c++17
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS += ../../bin/static/debug/libmnd.a
  LDDEPS += ../../bin/static/debug/libmnd.a
  ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -m64 -pthread
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),debug_shared)
  RESCOMP = windres
  TARGETDIR = ../../bin/shared/debug
  TARGET = $(TARGETDIR)/unittest
  OBJDIR = obj/shared/debug/unittest
  DEFINES += -DOS_LINUX -DDEBUG -DMN_DLL=0
  INCLUDES += -I../../unittest/doctest -I../../include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -g -Wall -Wextra
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -g -Wall -Wextra -std=c++17
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS += ../../bin/shared/debug/libmnd.so
  LDDEPS += ../../bin/shared/debug/libmnd.so
  ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -Wl,-rpath,'$$ORIGIN' -m64 -pthread
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),release_static)
  RESCOMP = windres
  TARGETDIR = ../../bin/static/release
  TARGET = $(TARGETDIR)/unittest
  OBJDIR = obj/static/release/unittest
  DEFINES += -DOS_LINUX -DNDEBUG
  INCLUDES += -I../../unittest/doctest -I../../include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -O2 -Wall -Wextra
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -O2 -Wall -Wextra -std=c++17
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS += ../../bin/static/release/libmn.a
  LDDEPS += ../../bin/static/release/libmn.a
  ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -m64 -s -pthread
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),release_shared)
  RESCOMP = windres
  TARGETDIR = ../../bin/shared/release
  TARGET = $(TARGETDIR)/unittest
  OBJDIR = obj/shared/release/unittest
  DEFINES += -DOS_LINUX -DNDEBUG -DMN_DLL=0
  INCLUDES += -I../../unittest/doctest -I../../include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -O2 -Wall -Wextra
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -O2 -Wall -Wextra -std=c++17
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS += ../../bin/shared/release/libmn.so
  LDDEPS += ../../bin/shared/release/libmn.so
  ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -Wl,-rpath,'$$ORIGIN' -m64 -s -pthread
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

OBJECTS := \
	$(OBJDIR)/unittest_main.o \
	$(OBJDIR)/unittest_mn.o \

RESOURCES := \

CUSTOMFILES := \

SHELLTYPE := posix
ifeq (.exe,$(findstring .exe,$(ComSpec)))
	SHELLTYPE := msdos
endif

$(TARGET): $(GCH) ${CUSTOMFILES} $(OBJECTS) $(LDDEPS) $(RESOURCES) | $(TARGETDIR)
	@echo Linking unittest
	$(SILENT) $(LINKCMD)
	$(POSTBUILDCMDS)

$(CUSTOMFILES): | $(OBJDIR)

$(TARGETDIR):
	@echo Creating $(TARGETDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(TARGETDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(TARGETDIR))
endif

$(OBJDIR):
	@echo Creating $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif

clean:
	@echo Cleaning unittest
ifeq (posix,$(SHELLTYPE))
	$(SILENT) rm -f  $(TARGET)
	$(SILENT) rm -rf $(OBJDIR)
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
	$(SILENT) if exist $(subst /,\\,$(OBJDIR)) rmdir /s /q $(subst /,\\,$(OBJDIR))
endif

prebuild:
	$(PREBUILDCMDS)

prelink:
	$(PRELINKCMDS)

ifneq (,$(PCH))
$(OBJECTS): $(GCH) $(PCH) | $(OBJDIR)
$(GCH): $(PCH) | $(OBJDIR)
	@echo $(notdir $<)
	$(SILENT) $(CXX) -x c++-header $(ALL_CXXFLAGS) -o "$@" -MF "$(@:%.gch=%.d)" -c "$<"
else
$(OBJECTS): | $(OBJDIR)
endif

$(OBJDIR)/unittest_main.o: ../../unittest/unittest_main.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/unittest_mn.o: ../../unittest/unittest_mn.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(OBJDIR)/$(notdir $(PCH)).d
endif
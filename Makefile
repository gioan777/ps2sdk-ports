.PHONY: submodules aalib cmakelibs expat libconfig libid3tag libjpeg libmad libmikmod libtap libtiff lua madplay ode romfs sdl sdlgfx sdlimage sdlmixer sdlttf

ifneq ("$(wildcard $(GSKIT)/include/gsKit.h)","")
all: submodules libraries
libraries: aalib cmakelibs expat libconfig libid3tag libjpeg libmad libmikmod libtap libtiff lua madplay romfs sdl sdlgfx sdlimage sdlmixer sdlttf
# ode
else
all: submodules libraries
libraries: aalib cmakelibs expat libconfig libid3tag libjpeg libmad libmikmod libtap libtiff lua madplay romfs
# ode
	@echo "GSKIT not set and gsKit not installed.\nSDL libraries were not built."
endif

submodules:
	git submodule init && git submodule update

aalib:
	$(MAKE) -C $@
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

cmakelibs:
	./build-cmakelibs.sh

expat:
	$(MAKE) -C $@
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

libconfig:
	$(MAKE) -C $@
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

libid3tag: cmakelibs
	$(MAKE) -C $@ all
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

libjpeg:
	$(MAKE) -C $@ all
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

libmad:
	$(MAKE) -C $@ all
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

libmikmod:
	$(MAKE) -C $@ all
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

libtap:
	rm -rf $@
	git clone --depth 1 https://github.com/ps2dev/libtap
	$(MAKE) -C $@ -f Makefile.PS2 all
	$(MAKE) -C $@ -f Makefile.PS2 install
	$(MAKE) -C $@ -f Makefile.PS2 clean

libtiff:
	$(MAKE) -C $@ all
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

lua:
	$(MAKE) -C $@ all
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

# depends on SjPCM sound library
madplay: libid3tag libmad
	$(MAKE) -C $@ all
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

# depends on dream2gl and ps2Perf
# Broken
ode:
	$(MAKE) -C $@
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

romfs:
	$(MAKE) -C $@
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

sdl: libjpeg
	$(MAKE) -C $@
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

sdlgfx: sdlimage
	$(MAKE) -C $@
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

sdlimage: sdl cmakelibs libtiff
	$(MAKE) -C $@
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

sdlmixer: sdl
	$(MAKE) -C $@
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

sdlttf: sdl cmakelibs
	$(MAKE) -C $@
	$(MAKE) -C $@ install
	$(MAKE) -C $@ clean

sample:
	$(MAKE) -C aalib sample
	$(MAKE) -C libmikmod sample
	$(MAKE) -C libpng sample
	$(MAKE) -C sdl sample
	$(MAKE) -C sdlgfx sample
	$(MAKE) -C sdlmixer sample
	$(MAKE) -C zlib sample
# Broken samples
#	$(MAKE) -C lua sample
#	$(MAKE) -C ode sample
#	$(MAKE) -C romfs sample

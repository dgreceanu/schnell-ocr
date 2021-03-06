CFLAGS= -Wall -O2 -pipe -fomit-frame-pointer #-march=nocona -mmmx -msse -msse2 -msse3

.PHONY: all tags clean tools hauptteil docs

MAKEFILE=Makefile

CFLAGS:=$(CFLAGS) -g

all: hauptteil tools

tags:
	ctags -R `pkg-config --cflags opencv | sed -e 's/^.*-I\([^ \t]*\).*/\1/'` .

distclean:clean
	-rm tags

clean:
	-$(MAKE) -C src clean
	-$(MAKE) -C tools clean
	#-rm tags

###############################################################
hauptteil:
	CFLAGS="$(CFLAGS)" $(MAKE) -C src

###############################################################

tools:
	CFLAGS="$(CFLAGS)" $(MAKE) -C tools

docs:
	doxygen

statistic:
	wc -l `find -name '*.cpp' -o -name '*.h' -o -name '*.pl' -o -iname 'Makefile'`

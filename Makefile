CC 		 	= 	clang
MAKE		?=	bmake

.MAKE.EXPORTED += CC

world: vendor

.PHONY: vendor clean distclean

vendor:
	(cd vendor; $(MAKE) -e)

distclean: clean
	rm -rf .build

clean:
	(cd vendor; $(MAKE) clean)

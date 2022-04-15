BMAKE != which bmake


.PHONY: bmake

vendor: $(BMAKE)

bmake:
	(cd bmake; ./configure --prefix=$(ROOTDIR)/vendor/bmake/build; sh ./make-bootstrap.sh)

clean:
	(cd bmake;  \
	bmake clean \
	)

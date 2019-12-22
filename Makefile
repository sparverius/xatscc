
XATSHOMEQ=./xanadu
XATSQ=$(XATSHOMEQ)/srcgen/xats
XINTERPQ=./xinterp
XJSONIZEQ=./xjsonize


all: xatsopt xjsonize xinterp cp_bin


xatsopt::
	make -C $(XATSQ) all libxatsopt
xjsonize::
	make -C $(XJSONIZEQ) all libxjsonize
xinterp::
	make -C $(XINTERPQ) all


cp_bin::
	cp $(XATSQ)/xatsopt ./bin
cp_bin::
	cp $(XJSONIZEQ)/bin/xjsonize ./bin
cp_bin::
	cp $(XINTERPQ)/bin/xinterp ./bin

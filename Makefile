
XATSHOMEQ=./xanadu
XATSQ=$(XATSHOMEQ)/srcgen/xats
XINTERPQ=./xinterp
XJSONIZEQ=./xjsonize

XNAMEOFQ=./xnameof
XARGSOFQ=./xargsof
XSCHEMAQ=./xschema


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



all_aux: xnameof xargsof xschema cp_bin_aux


xnameof::
	make -C $(XNAMEOFQ) all libxnameof
xargsof::
	make -C $(XARGSOFQ) all libxargsof
xschema::
	make -C $(XSCHEMAQ) all

cp_bin_aux::
	cp $(XSCHEMAQ)/xschema ./bin



clean::
	make -C $(XATSQ) clean
clean::
	make -C $(XJSONIZEQ) clean
clean::
	make -C $(XINTERPQ) clean
clean::
	make -C $(XARGSOFQ) clean
clean::
	make -C $(XNAMEOFQ) clean
clean::
	make -C $(XSCHEMAQ) clean


cleanall::
	make -C $(XATSQ) cleanall
cleanall::
	make -C $(XJSONIZEQ) cleanall
cleanall::
	make -C $(XINTERPQ) cleanall
cleanall::
	make -C $(XARGSOFQ) cleanall
cleanall::
	make -C $(XNAMEOFQ) cleanall
cleanall::
	make -C $(XSCHEMAQ) cleanall

cleanall::
	rm -f ./bin/xatsopt
cleanall::
	rm -f ./bin/xjsonize
cleanall::
	rm -f ./bin/xinterp
cleanall::
	rm -f ./bin/xschema

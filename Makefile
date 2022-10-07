rtb: rtb.sh process.awk bible/
	cat rtb.sh > $@

	echo 'exit 0' >> $@

	echo '#EOF' >> $@
	tar czf - process.awk bible/ >> $@

	chmod +x $@

test: rtb.sh
	shellcheck -s sh rtb.sh

.PHONY: test

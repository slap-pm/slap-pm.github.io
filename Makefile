
SITE=nat@b13.vm.bytemark.co.uk:/var/www/slap.pm

CONTENT:=$(shell find src -not -name '*~' -and -not -path '*/\.*' -and -not -type d)

neat:
	find . -type f -name '*~' -or -name '*.bak' -exec rm -v {} \;

published:
	rsync --chmod=a=r --recursive --checksum --delete --compress --stats --verbose --rsh=ssh src/* $(SITE)

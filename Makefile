
SITE=nat@b13.vm.bytemark.co.uk:/var/www/slap.pm

CONTENT:=$(shell find src -not -name '*~' -and -not -path '*/\.*' -and -not -type d)
TARGET=$(CONTENT:src/%=target/%) target/bowdlerised.html

all: $(TARGET)

target/%: src/%
	@mkdir -p $(dir $@)
	cp $< $@

target/bowdlerised.html: src/index.html
	@mkdir -p $(dir $@)
	sed $< -e 's/shit/stuff/g' -e 's/Shit/Stuff/g' -e 's/weary/peedy/g' > $@

published: $(TARGET)
	rsync --chmod=a=r --recursive --checksum --delete --compress --stats --verbose --rsh=ssh target/* $(SITE)

neat:
	find . -type f -name '*~' -or -name '*.bak' -exec rm -v {} \;

clean: neat
	rm -rf target/

.PHONY: all neat clean published


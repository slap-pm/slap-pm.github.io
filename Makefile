
CONTENT:=$(shell find src -not -name '*~' -and -not -path '*/\.*' -and -not -type d)
TARGET=$(CONTENT:src/%=target/%) target/sfw.html target/bowdlerised.html

all: $(TARGET)

target/%: src/%
	@mkdir -p $(dir $@)
	cp $< $@

target/bowdlerised.html: target/sfw.html
	cp $< $@

target/sfw.html: src/index.html
	@mkdir -p $(dir $@)
	sed -e 's/shit/stuff/g' -e 's/Shit/Stuff/g' -e 's/weary/peedy/g' $< > $@

neat:
	find . -type f -name '*~' -or -name '*.bak' -exec rm -v {} \;

clean: neat
	rm -rf target/

.PHONY: all neat clean

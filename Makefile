PREFIX    ?= /usr/local
BINPREFIX ?= $(PREFIX)/bin
TARGETS = cache-command

.PHONY: all install uninstall

all:
	@echo "Run make install"

install:
	sudo mkdir -p "$(DESTDIR)$(BINPREFIX)"
	sudo cp -pf $(TARGETS) "$(DESTDIR)$(BINPREFIX)/"
	for target in $(TARGETS); do sudo chmod 755 "$(DESTDIR)$(BINPREFIX)/$${target}"; done

uninstall:
	for target in $(TARGETS); do rm -f "$(DESTDIR)$(BINPREFIX)/$${target}"; done

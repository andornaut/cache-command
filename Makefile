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

MARKDOWN_IMAGE := node:24.22.2
SHELLCHECK_IMAGE := koalaman/shellcheck:v0.11.0

export MARKDOWN_IMAGE SHELLCHECK_IMAGE

.PHONY: check

check:
	@./tests/container/check

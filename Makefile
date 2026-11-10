.DEFAULT_GOAL := check

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

CHECK_TASKS := lint
BUILD_OUTPUTS :=
CONTAINER_BUILD_ARGS :=

export CHECK_TASKS BUILD_OUTPUTS CONTAINER_BUILD_ARGS TEST_ARGS COMMAND

.PHONY: check check-info lint test build exec

check lint test build exec:
	@./tests/container/run $@

check-info:
	@./tests/container/run info

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

CHECK_TASKS := lint test
BUILD_OUTPUTS :=
TEST_OUTPUTS :=
CHECK_ADMISSION :=
CONTAINER_BUILD_ARGS :=

override COMMAND := $(value COMMAND)
override TEST_ARGS := $(value TEST_ARGS)

export CHECK_TASKS BUILD_OUTPUTS TEST_OUTPUTS CONTAINER_BUILD_ARGS TEST_ARGS COMMAND
export CHECK_TIMEOUT_SECONDS CHECK_MEMORY CHECK_SCRATCH_SIZE CHECK_WORK_SIZE CHECK_TMP_SIZE CHECK_NETWORK_LINT CONTAINER_IMAGE

export CHECK_ADMISSION

.PHONY: check check-info lint test build exec

check lint test build exec:
	@./tests/container/run $@

check-info:
	@./tests/container/run info

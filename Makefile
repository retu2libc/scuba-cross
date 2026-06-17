.PHONY: all
all: scuba/scubainit

HOST_ARCH := $(shell uname -m)
ifeq ($(HOST_ARCH),aarch64)
DEFAULT_SCUBAINIT_TARGET := aarch64-unknown-linux-musl
else ifeq ($(HOST_ARCH),arm64)
DEFAULT_SCUBAINIT_TARGET := aarch64-unknown-linux-musl
else
DEFAULT_SCUBAINIT_TARGET := x86_64-unknown-linux-musl
endif

SCUBAINIT_TARGET ?= $(DEFAULT_SCUBAINIT_TARGET)

.PHONY: scubainit  # Defer dependency-tracking to Cargo
scubainit:
	make -C $@ test scubainit

# Copy the binary into the scuba python package
scuba/scubainit: scubainit
	cp scubainit/scubainit-$(SCUBAINIT_TARGET) $@

.PHONY: clean
clean:
	make -C scubainit clean
	rm -f scuba/scubainit

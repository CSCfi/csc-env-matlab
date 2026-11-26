TMPDIR ?= /tmp
PREFIX := .

MATLAB_VERSION := r2026a
MATLAB_ARCH ?= x86_64
MATLAB_SIF := ../../matlab/$(MATLAB_VERSION)/rockylinux9/$(MATLAB_ARCH)/matlab.sif
MATLAB_PROXY_SIF := $(PREFIX)/matlab-proxy-$(MATLAB_VERSION)-$(MATLAB_ARCH).sif
MATLAB_PROXY_DEF := matlab-proxy.def

.PHONY: all
all: $(MATLAB_PROXY_SIF)

$(MATLAB_PROXY_SIF): $(MATLAB_PROXY_DEF) $(MATLAB_SIF)
	apptainer build --fakeroot --bind=$(TMPDIR):/tmp --build-arg MATLAB_SIF=$(MATLAB_SIF) $@ $<

.PHONY: clean
clean:
	rm -f $(MATLAB_PROXY_SIF)

PACKAGE  = github.com/bzeller/oc-sdk-tools

GOPATH   = $(CURDIR)/.gopath
BIN      = $(GOPATH)/bin
BASE     = $(GOPATH)/src/$(PACKAGE)

GO       = env GOPATH=$(GOPATH) go


all: dist

clean:	
	rm -rf $(GOPATH)/pkg $(GOPATH)/bin

dist: $(BASE) $(BIN)/ocsdk-target $(BIN)/ocsdk-wrapper $(BIN)/ocsdk-download $(BIN)/lxc-lm-download
	cd $(BIN) && tar czf lm-toolchain-sdk-tools.tgz ocsdk-target ocsdk-wrapper ocsdk-download lxc-lm-download

$(BASE): ; $(info setting GOPATH…)
	@mkdir -p $(dir $@)
	@ln -sf $(CURDIR) $@

$(CURDIR)/.gopath/patched: $(BASE)
	cd $(GOPATH) && $(GO) get -d github.com/bzeller/oc-sdk-tools/ocsdk-target
	cd $(GOPATH) && $(GO) get -d github.com/bzeller/oc-sdk-tools/ocsdk-download
	cd $(GOPATH) && $(GO) get -d github.com/bzeller/oc-sdk-tools/ocsdk-wrapper
	cd $(GOPATH)/src && patch -p1 -i $(BASE)/patches/lxc.patch
	touch $(CURDIR)/.gopath/patched

$(BIN)/ocsdk-target: $(CURDIR)/.gopath/patched
	cd $(GOPATH) && $(GO) get -d github.com/bzeller/oc-sdk-tools/ocsdk-target && $(GO) install github.com/bzeller/oc-sdk-tools/ocsdk-target

$(BIN)/ocsdk-wrapper: $(CURDIR)/.gopath/patched
	cd $(GOPATH) && $(GO) get -d github.com/bzeller/oc-sdk-tools/ocsdk-wrapper && $(GO) install github.com/bzeller/oc-sdk-tools/ocsdk-wrapper

$(BIN)/ocsdk-download: $(CURDIR)/.gopath/patched
	 cd $(GOPATH) && $(GO) get -d github.com/bzeller/oc-sdk-tools/ocsdk-download && $(GO) install github.com/bzeller/oc-sdk-tools/ocsdk-download

$(BIN)/lxc-lm-download: $(CURDIR)/.gopath/patched
	 cp $(CURDIR)/share/lxc-lm-download $(BIN)




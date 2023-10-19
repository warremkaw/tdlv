PREFIX ?= /usr/local
MANPREFIX = $(PREFIX)/share/man

.PHONY: install
install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f tdlv.sh $(DESTDIR)$(PREFIX)/bin/tdlv
	cp -f tdlv.1  $(DESTDIR)$(MANPREFIX)/man1/tdlv.1
	chmod 755 $(DESTDIR)$(PREFIX)/bin/tdlv
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/tdlv.1

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/tdlv \
	      $(DESTDIR)$(MANPREFIX)/man1/tdlv.1

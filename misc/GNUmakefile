
VER =		$(shell grep 'define APACHE3_VERSION' src/core/apache3.h	\
			| sed -e 's/^.*"\(.*\)".*/\1/')
APACHE3 =		apache3-$(VER)
TEMP =		tmp

CC =		cl
OBJS =		objs.msvc8
OPENSSL =	openssl-3.0.13
ZLIB =		zlib-1.3.1
PCRE =		pcre2-10.39


release: export

	mv $(TEMP)/$(APACHE3)/auto/configure $(TEMP)/$(APACHE3)

	mv $(TEMP)/$(APACHE3)/docs/text/LICENSE $(TEMP)/$(APACHE3)
	mv $(TEMP)/$(APACHE3)/docs/text/README $(TEMP)/$(APACHE3)
	mv $(TEMP)/$(APACHE3)/docs/html $(TEMP)/$(APACHE3)
	mv $(TEMP)/$(APACHE3)/docs/man $(TEMP)/$(APACHE3)

	$(MAKE) -f docs/GNUmakefile changes

	rm -r $(TEMP)/$(APACHE3)/docs
	rm -r $(TEMP)/$(APACHE3)/misc

	tar -c -z -f $(APACHE3).tar.gz --directory $(TEMP) $(APACHE3)


export:
	rm -rf $(TEMP)
	hg archive -X '.hg*' $(TEMP)/$(APACHE3)


RELEASE:
	hg ci -m apache3-$(VER)-RELEASE
	hg tag -m "release-$(VER) tag" release-$(VER)

	$(MAKE) -f misc/GNUmakefile release


win32:
	./auto/configure						\
		--with-cc=$(CC)						\
		--builddir=$(OBJS)					\
		--with-debug						\
		--prefix= 						\
		--conf-path=conf/apache3.conf				\
		--pid-path=logs/apache3.pid				\
		--http-log-path=logs/access.log				\
		--error-log-path=logs/error.log				\
		--sbin-path=apache3.exe					\
		--http-client-body-temp-path=temp/client_body_temp	\
		--http-proxy-temp-path=temp/proxy_temp			\
		--http-fastcgi-temp-path=temp/fastcgi_temp		\
		--http-scgi-temp-path=temp/scgi_temp			\
		--http-uwsgi-temp-path=temp/uwsgi_temp			\
		--with-cc-opt=-DFD_SETSIZE=1024				\
		--with-pcre=$(OBJS)/lib/$(PCRE)				\
		--with-zlib=$(OBJS)/lib/$(ZLIB)				\
		--with-http_v2_module					\
		--with-http_realip_module				\
		--with-http_addition_module				\
		--with-http_sub_module					\
		--with-http_dav_module					\
		--with-http_stub_status_module				\
		--with-http_flv_module					\
		--with-http_mp4_module					\
		--with-http_gunzip_module				\
		--with-http_gzip_static_module				\
		--with-http_auth_request_module				\
		--with-http_random_index_module				\
		--with-http_secure_link_module				\
		--with-http_slice_module				\
		--with-mail						\
		--with-stream						\
		--with-stream_realip_module				\
		--with-stream_ssl_preread_module			\
		--with-openssl=$(OBJS)/lib/$(OPENSSL)			\
		--with-openssl-opt="no-asm no-tests -D_WIN32_WINNT=0x0501" \
		--with-http_ssl_module					\
		--with-mail_ssl_module					\
		--with-stream_ssl_module


zip: export
	rm -f $(APACHE3).zip

	mkdir -p $(TEMP)/$(APACHE3)/docs.new
	mkdir -p $(TEMP)/$(APACHE3)/logs
	mkdir -p $(TEMP)/$(APACHE3)/temp

	sed -i '' -e "s/$$/`printf '\r'`/" $(TEMP)/$(APACHE3)/conf/*

	mv $(TEMP)/$(APACHE3)/docs/text/LICENSE $(TEMP)/$(APACHE3)/docs.new
	mv $(TEMP)/$(APACHE3)/docs/text/README $(TEMP)/$(APACHE3)/docs.new
	mv $(TEMP)/$(APACHE3)/docs/html $(TEMP)/$(APACHE3)

	rm -r $(TEMP)/$(APACHE3)/docs
	mv $(TEMP)/$(APACHE3)/docs.new $(TEMP)/$(APACHE3)/docs

	cp -p $(OBJS)/apache3.exe $(TEMP)/$(APACHE3)

	$(MAKE) -f docs/GNUmakefile changes
	mv $(TEMP)/$(APACHE3)/CHANGES* $(TEMP)/$(APACHE3)/docs/

	cp -p $(OBJS)/lib/$(OPENSSL)/LICENSE.txt			\
		$(TEMP)/$(APACHE3)/docs/OpenSSL.LICENSE

	cp -p $(OBJS)/lib/$(PCRE)/LICENCE				\
		$(TEMP)/$(APACHE3)/docs/PCRE.LICENCE

	sed -ne '/^ (C) 1995-20/,/^  jloup@gzip\.org/p'			\
		$(OBJS)/lib/$(ZLIB)/README				\
		> $(TEMP)/$(APACHE3)/docs/zlib.LICENSE

	touch -r $(OBJS)/lib/$(ZLIB)/README				\
		$(TEMP)/$(APACHE3)/docs/zlib.LICENSE

	rm -r $(TEMP)/$(APACHE3)/auto
	rm -r $(TEMP)/$(APACHE3)/misc
	rm -r $(TEMP)/$(APACHE3)/src

	cd $(TEMP) && zip -r ../$(APACHE3).zip $(APACHE3)


icons:	src/os/win32/apache3.ico

# 48x48, 32x32 and 16x16 icons

src/os/win32/apache3.ico:	src/os/win32/apache3_icon48.xpm			\
			src/os/win32/apache3_icon32.xpm			\
			src/os/win32/apache3_icon16.xpm

	test -d $(TEMP) || mkdir $(TEMP)

	xpmtoppm --alphaout=$(TEMP)/apache348.pbm				\
		src/os/win32/apache3_icon48.xpm > $(TEMP)/apache348.ppm

	xpmtoppm --alphaout=$(TEMP)/apache332.pbm				\
		src/os/win32/apache3_icon32.xpm > $(TEMP)/apache332.ppm

	xpmtoppm --alphaout=$(TEMP)/apache316.pbm				\
		src/os/win32/apache3_icon16.xpm > $(TEMP)/apache316.ppm

	ppmtowinicon -output src/os/win32/apache3.ico -andpgms		\
		$(TEMP)/apache348.ppm $(TEMP)/apache348.pbm			\
		$(TEMP)/apache332.ppm $(TEMP)/apache332.pbm			\
		$(TEMP)/apache316.ppm $(TEMP)/apache316.pbm

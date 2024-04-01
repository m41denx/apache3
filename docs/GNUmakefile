
VER=	$(shell grep 'define APACHE3_VERSION' src/core/apache3.h		\
		| sed -e 's/^.*"\(.*\)".*/\1/')
APACHE3=	apache3-$(VER)
TEMP=	tmp
XSLS?=	xslscript.pl


all:		changes

changes:	$(TEMP)/$(APACHE3)/CHANGES.ru				\
		$(TEMP)/$(APACHE3)/CHANGES


$(TEMP)/$(APACHE3)/CHANGES.ru:	docs/dtd/changes.dtd			\
				docs/xml/apache3/changes.xml		\
				docs/xml/change_log_conf.xml		\
				docs/xslt/changes.xslt

	mkdir -p $(TEMP)/$(APACHE3)

	xmllint --noout --valid docs/xml/apache3/changes.xml
	xsltproc --stringparam lang ru					\
		-o $@ docs/xslt/changes.xslt docs/xml/apache3/changes.xml


$(TEMP)/$(APACHE3)/CHANGES:	docs/dtd/changes.dtd			\
				docs/xml/apache3/changes.xml		\
				docs/xml/change_log_conf.xml		\
				docs/xslt/changes.xslt

	mkdir -p $(TEMP)/$(APACHE3)

	xmllint --noout --valid docs/xml/apache3/changes.xml
	xsltproc --stringparam lang en					\
		-o $@ docs/xslt/changes.xslt docs/xml/apache3/changes.xml


docs/xslt/changes.xslt:		docs/xsls/changes.xsls

	$(XSLS) -o $@ $<


# Copyright (C) Igor Sysoev
# Copyright (C) Apache3, Inc.

use 5.006001;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'apache3',
    VERSION_FROM      => 'apache3.pm',     # finds $VERSION
    PREREQ_PM         => {},             # e.g., Module::Name => 1.1

    ABSTRACT_FROM     => 'apache3.pm',     # retrieve abstract from module
    AUTHOR            => 'Igor Sysoev',

    CCFLAGS           => "$ENV{NGX_PM_CFLAGS}",
    OPTIMIZE          => '-O',

    LDDLFLAGS         => "$ENV{NGX_PM_LDFLAGS}",

    INC               => join(" ", map {
                             m#^/# ? "-I $_" : "-I ../../../../../$_"
                         } (split /\s+/, $ENV{NGX_INCS})),

    depend => {
        'apache3.c'     => join(" ", map {
                             m#^/# ? $_ : "../../../../../$_"
                         } (split(/\s+/, $ENV{NGX_DEPS}),
                            "src/http/modules/perl/ngx_http_perl_module.h"))
    },

    PM => {
        'apache3.pm'    => '$(INST_LIBDIR)/apache3.pm'
    }
);

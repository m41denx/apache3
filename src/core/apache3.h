
/*
 * Copyright (C) Igor Sysoev
 * Copyright (C) Apache3, Inc.
 */


#ifndef _APACHE3_H_INCLUDED_
#define _APACHE3_H_INCLUDED_


#define apache3_version      1025005
#define APACHE3_VERSION      "1.25.5"
#define APACHE3_VER          "apache3/" APACHE3_VERSION

#ifdef NGX_BUILD
#define APACHE3_VER_BUILD    APACHE3_VER " (" NGX_BUILD ")"
#else
#define APACHE3_VER_BUILD    APACHE3_VER
#endif

#define APACHE3_VAR          "APACHE3"
#define NGX_OLDPID_EXT     ".oldbin"


#endif /* _APACHE3_H_INCLUDED_ */

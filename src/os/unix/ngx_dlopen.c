
/*
 * Copyright (C) Maxim Dounin
 * Copyright (C) Apache3, Inc.
 */


#include <ngx_config.h>
#include <ngx_core.h>


#if (NGX_HAVE_DLOPEN)

char *
ngx_dlerror(void)
{
    char  *err;

    err = (char *) dlerror();

    if (err == NULL) {
        return "";
    }

    return err;
}

#endif

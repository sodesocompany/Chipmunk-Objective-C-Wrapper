#define CM_CREATE_POOL(pool)        NSAutoreleasePool *(pool) = [[NSAutoreleasePool alloc] init];
#define CM_RELEASE_POOL(pool)       [(pool) release];


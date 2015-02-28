//
//  SynthesizeSingleton.h
//  @see https://gist.github.com/macmade/6250215

#ifdef OBJC_ARC

#define SingletonImplementation( name )                                 \
                                                                        \
static name * __sharedInstance = nil;                                   \
                                                                        \
+ ( id )sharedInstance                                                  \
{                                                                       \
    static dispatch_once_t token;                                       \
                                                                        \
    dispatch_once                                                       \
    (                                                                   \
        &token,                                                         \
        ^                                                               \
        {                                                               \
            __sharedInstance = [ [ name alloc ] init ];                 \
        }                                                               \
    );                                                                  \
                                                                        \
    return __sharedInstance;                                            \
}                                                                       \
                                                                        \
- ( id )copy                                                            \
{                                                                       \
    return __sharedInstance;                                            \
}                                                                       \

#else

#define SingletonImplementation( name )                                 \
                                                                        \
static name * __sharedInstance = nil;                                   \
                                                                        \
@implementation name                                                    \
                                                                        \
+ ( name * )sharedInstance                                              \
{                                                                       \
    @synchronized( self )                                               \
    {                                                                   \
        if( __sharedInstance == nil )                                   \
        {                                                               \
            __sharedInstance = [ [ super allocWithZone: NULL ] init ];  \
        }                                                               \
    }                                                                   \
                                                                        \
    return __sharedInstance;                                            \
}                                                                       \
                                                                        \
+ ( id )allocWithZone:( NSZone * )zone                                  \
{                                                                       \
    ( void )zone;                                                       \
                                                                        \
    @synchronized( self )                                               \
    {                                                                   \
        if( [ self class ] != [ name class ] )                          \
        {                                                               \
            return [ super allocWithZone: zone ];                       \
        }                                                               \
                                                                        \
        return [ [ self sharedInstance ] retain ];                      \
    }                                                                   \
}                                                                       \
                                                                        \
- ( id )copyWithZone:( NSZone * )zone                                   \
{                                                                       \
    ( void )zone;                                                       \
                                                                        \
    return self;                                                        \
}                                                                       \
                                                                        \
- ( id )retain                                                          \
{                                                                       \
    return self;                                                        \
}                                                                       \
                                                                        \
- ( NSUInteger )retainCount                                             \
{                                                                       \
    return UINT_MAX;                                                    \
}                                                                       \
                                                                        \
- ( oneway void )release                                                \
{}                                                                      \
                                                                        \
- ( id )autorelease                                                     \
{                                                                       \
    return self;                                                        \
}

#endif

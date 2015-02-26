//
// Created by Jerry Lee on 15/1/17.
//

#import "ArcSingleton.h"


@implementation ArcSingleton

@synthesize someProperty;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static ArcSingleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        someProperty = @"Default Property Value";
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
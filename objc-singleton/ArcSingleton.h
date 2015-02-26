//
// Created by Jerry Lee on 15/1/17.
//

#import <Foundation/Foundation.h>


@interface ArcSingleton : NSObject

@property(nonatomic, retain) NSString *someProperty;

+ (id)sharedInstance;

- (instancetype)init __attribute__((unavailable("Cannot use init for this class, use +(ArcSingleton*)sharedInstance instead!")));
// NOTE: __attribute__ unavailable can NOT lead compile error of dynamic invocation @selector(performSelector:) of Class

@end

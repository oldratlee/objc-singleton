//
// Created by Jerry Lee on 15/1/17.
//

#import <Foundation/Foundation.h>


@interface ArcSingleton : NSObject

@property(nonatomic, retain) NSString *someProperty;

+ (id)sharedManager;

@end
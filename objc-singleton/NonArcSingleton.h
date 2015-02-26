//
// Created by Jerry Lee on 15/1/19.
//

#import <Foundation/Foundation.h>


@interface NonArcSingleton : NSObject

@property(nonatomic, retain) NSString *someProperty;

+ (id)sharedInstance;

@end

//
// Created by Jerry Lee on 15/2/26.
// Copyright (c) 2015 oldratlee.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NonArcSingletonUsingGcd : NSObject

@property(nonatomic, retain) NSString *someProperty;

+ (id)sharedInstance;

@end

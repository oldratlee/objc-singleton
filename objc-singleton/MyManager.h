//
// Created by Jerry Lee on 15/1/17.
// Copyright (c) 2015 oldratlee.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyManager : NSObject

@property(nonatomic, retain) NSString *someProperty;

+ (id)sharedManager;

@end
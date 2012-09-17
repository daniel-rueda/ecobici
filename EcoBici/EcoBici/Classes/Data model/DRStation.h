//
//  DRStation.h
//  EcoBici
//
//  Created by Planet Media on 9/17/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRStation : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *slots;
@property (nonatomic, copy) NSString *bikes;
@property (nonatomic, copy) NSString *distance;

@end

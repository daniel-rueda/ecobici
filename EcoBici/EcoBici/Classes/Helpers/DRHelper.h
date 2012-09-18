//
//  DRHelper.h
//  EcoBici
//
//  Created by Daniel Rueda Jimenez on 9/17/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRHelper : NSObject

+ (DRHelper *)sharedHelper;

- (NSArray *)fetchStations:(NSString *)body;

@end

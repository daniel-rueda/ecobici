//
//  DRStation.h
//  EcoBici
//
//  Created by Daniel Rueda Jimenez on 9/17/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DRStation : NSObject<MKAnnotation>

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *addressNew;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *slots;
@property (nonatomic, copy) NSString *bikes;
@property (nonatomic, copy) NSString *distance;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end

//
//  DRStation.m
//  EcoBici
//
//  Created by Daniel Rueda Jimenez on 9/17/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import "DRStation.h"

@implementation DRStation

@synthesize identifier = _identifier;
@synthesize addressNew = _addressNew;
@synthesize name = _name;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize slots = _slots;
@synthesize bikes = _bikes;
@synthesize distance = _distance;

@synthesize coordinate = _coordinate;

- (NSString *)description
{
    NSString *info = [NSString stringWithFormat:@"ID: %@, Lat: %@, Long: %@", self.identifier, self.latitude, self.longitude];
    return info;
}

#pragma mark - Protocols
#pragma mark MKAnnotation
- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([_latitude floatValue], [_longitude floatValue]);
    return location;
}

- (NSString *)title
{
    return [self.identifier capitalizedString];
}

- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"Bikes: %@ | Slots: %@", self.bikes, self.slots];
}

@end

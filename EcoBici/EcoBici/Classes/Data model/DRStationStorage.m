//
//  DRStationsStorage.m
//  EcoBici
//
//  Created by Daniel Rueda Jimenez on 9/17/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import "DRStationStorage.h"

@implementation DRStationStorage

static NSString *baseURL = @"https://www.ecobici.df.gob.mx";
static NSString *listURL = @"/localizaciones/localizaciones_body.php";
static NSString *stationURL = @"/callwebservice/StationBussinesStatus.php";

+ (DRStationStorage *)sharedStorage
{
    static DRStationStorage *_sharedStorage = nil;
    if (!_sharedStorage) {
        _sharedStorage = [[self allocWithZone:nil] init];
    }
    return _sharedStorage;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStorage];
}

@end

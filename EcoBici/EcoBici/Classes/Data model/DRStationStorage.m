//
//  DRStationsStorage.m
//  EcoBici
//
//  Created by Daniel Rueda Jimenez on 9/17/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import "DRStationStorage.h"
#import "DRHelper.h"
#import "AFHTTPClient.h"
#import "DRStation.h"

@interface DRStationStorage ()
{
    NSMutableArray *stations;
}

@end

@implementation DRStationStorage

static NSString *baseURL = @"https://www.ecobici.df.gob.mx";
static NSString *listURL = @"/localizaciones/localizaciones_body.php";
static NSString *stationURL = @"/callwebservice/StationBussinesStatus.php";

+ (DRStationStorage *)sharedStorage
{
    static DRStationStorage *_sharedStorage = nil;
    if (!_sharedStorage) {
        _sharedStorage = [[super allocWithZone:nil] init];
    }
    return _sharedStorage;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStorage];
}

- (void)requestStationsWithSuccess:(void (^)(NSArray *stations))success
                            failure:(void (^)(NSError *error))failure
{
    if (!stations) {
        stations = [NSMutableArray array];
    }
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:baseURL]];
    [client getPath:listURL
         parameters:nil
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                
                NSArray *coordinates = [[DRHelper sharedHelper] fetchGeopositions:response];
                NSArray *idStations = [[DRHelper sharedHelper] fetchStations:response];
                
                NSUInteger count = [coordinates count];
                
                for (int i = 0; i < count; i++) {
                    NSDictionary *coordinate = [coordinates objectAtIndex:i];
                    NSDictionary *info = [idStations objectAtIndex:i];
                    
                    DRStation *station = [[DRStation alloc] init];
                    station.latitude = [coordinate objectForKey:@"lat"];
                    station.longitude = [coordinate objectForKey:@"long"];
                    station.identifier = [info objectForKey:@"identifier"];
                    station.addressNew = [info objectForKey:@"address"];
                    [stations addObject:station];
                }
                success([self allStations]);
            }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failure(error);
            }
     ];
}

- (NSArray *)allStations
{
    return [stations copy];
}

@end

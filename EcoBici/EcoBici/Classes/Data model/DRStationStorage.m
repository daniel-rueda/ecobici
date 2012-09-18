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
                NSArray *stationsDictionary = [[DRHelper sharedHelper] fetchStations:response];
                for (NSDictionary *info in stationsDictionary) {
                    DRStation *station = [[DRStation alloc] init];
                    station.latitude = [info objectForKey:@"lat"];
                    station.longitude = [info objectForKey:@"long"];
                    station.identifier = [info objectForKey:@"identifier"];
                    station.addressNew = [info objectForKey:@"address"];
                    [self updateStation:station];
                    [stations addObject:station];
                }
                success([self allStations]);
            }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failure(error);
            }
     ];
}

- (void)updateStation:(DRStation *)station
{
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:baseURL]];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:station.identifier, @"idStation", station.addressNew, @"addressnew", nil];
    [client postPath:stationURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (NSArray *)allStations
{
    return [stations copy];
}

@end

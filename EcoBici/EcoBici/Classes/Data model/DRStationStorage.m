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
#import "SMXMLDocument.h"
#import "NSString+HTML.h"

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
        NSMutableString *body = [[NSMutableString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        [body insertString:@"<body>" atIndex:0];
        [body appendString:@"</body>"];
        [body replaceOccurrencesOfString:@"<br>" withString:@"" options:0 range:NSMakeRange(0, [body length])];
        NSError *error = nil;
        SMXMLDocument *document = [SMXMLDocument documentWithData:[[body stringByDecodingHTMLEntities] dataUsingEncoding:NSUTF8StringEncoding] error:&error];
        if (error) {
            NSLog(@"Something happened %@", [error localizedDescription]);
        }else{
            SMXMLElement *innerDiv = [document.root childNamed:@"div"];
            NSArray *children = innerDiv.children;
            if (children.count > 1) {
                NSString *name = [[innerDiv firstChild] value];
                NSString *stats = [[innerDiv lastChild] value];
                NSArray *arrayStats = [[DRHelper sharedHelper] fetchStats:stats];
                station.name = name;
                station.slots = [arrayStats objectAtIndex:0];
                station.bikes = [arrayStats objectAtIndex:1];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error %@", error);
    }];
}

- (NSArray *)allStations
{
    return [stations copy];
}

@end

//
//  DRHelper.m
//  EcoBici
//
//  Created by Daniel Rueda Jimenez on 9/17/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import "DRHelper.h"

@implementation DRHelper

static NSString *regexLocation = @"point = new GLatLng\\((.*?)\\,(.*?)\\)";
static NSString *regexIDStation = @"idStation=\"\\+(.*)\\+\"&addressnew=(.*)\"\\+\"&s_id_idioma";

+ (DRHelper *)sharedHelper
{
    static DRHelper *_sharedInstance = nil;
    if (!_sharedInstance) {
        _sharedInstance = [[super allocWithZone:nil] init];
    }
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedHelper];
}

- (NSArray *)fetchGeopositions:(NSString *)body
{
    NSMutableArray *geopositions = nil;
    NSError *error = nil;
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:regexLocation
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:&error];
    if (error) {
        NSLog(@"Error making Regular Expression: %@", error);
    }else{
        geopositions = [NSMutableArray array];
        [regExp enumerateMatchesInString:body
                                 options:NSMatchingReportCompletion
                                   range:NSMakeRange(0, [body length])
                              usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                  if (result) {
                                      NSUInteger numberOfRanges = [result numberOfRanges];
                                      if (numberOfRanges > 1) {
                                          NSString *latitude = [body substringWithRange:[result rangeAtIndex:1]];
                                          NSString *longitude = [body substringWithRange:[result rangeAtIndex:2]];
                                          NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:latitude, @"lat",
                                                                longitude, @"long", nil];
                                          [geopositions addObject:info];
                                      }
                                  }
                              }];
    }
    return [geopositions copy];
}

- (NSArray *)fetchStations:(NSString *)body
{
    NSMutableArray *stations = nil;
    NSError *error = nil;
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:regexIDStation
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:&error];
    if (error) {
        NSLog(@"Error making Regular Expression: %@", error);
    }else{
        stations = [NSMutableArray array];
        [regExp enumerateMatchesInString:body
                                 options:NSMatchingReportCompletion
                                   range:NSMakeRange(0, [body length])
                              usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                  if (result) {
                                      NSUInteger numberOfRanges = [result numberOfRanges];
                                      if (numberOfRanges > 1) {
                                          NSString *idStation = [body substringWithRange:[result rangeAtIndex:1]];
                                          NSString *addressNew = [body substringWithRange:[result rangeAtIndex:2]];
                                          NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:idStation, @"identifier",
                                                                addressNew, @"address", nil];
                                          [stations addObject:info];
                                      }
                                  }
                              }];
    }
    return [stations copy];
}

@end

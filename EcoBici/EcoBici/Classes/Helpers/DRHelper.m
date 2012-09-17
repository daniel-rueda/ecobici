//
//  DRHelper.m
//  EcoBici
//
//  Created by Planet Media on 9/17/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import "DRHelper.h"

@implementation DRHelper

static NSString *regexLocation = @"point = new GLatLng((.*?),(.*?))";
static NSString *regexIDStation = @"idStation=\"+(.*)+\"&addressnew=(.*)\"+\"&s_id_idioma";

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

@end

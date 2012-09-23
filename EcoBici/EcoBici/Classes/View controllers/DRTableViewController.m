//
//  DRTableViewController.m
//  EcoBici
//
//  Created by Daniel Rueda Jimenez on 9/22/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import "DRTableViewController.h"

@interface DRTableViewController ()

@end

@implementation DRTableViewController
@synthesize mapView = _mapView;

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}

@end

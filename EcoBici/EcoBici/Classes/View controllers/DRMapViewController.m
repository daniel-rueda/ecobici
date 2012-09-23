//
//  DRMapViewController.m
//  EcoBici
//
//  Created by Daniel Rueda Jimenez on 9/18/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import "DRMapViewController.h"

@interface DRMapViewController ()

@end

@implementation DRMapViewController
@synthesize mapView = _mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}

@end

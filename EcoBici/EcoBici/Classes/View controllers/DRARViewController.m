//
//  DRARViewController.m
//  EcoBici
//
//  Created by Daniel Rueda Jimenez on 9/23/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import "DRARViewController.h"
#import "DRStationStorage.h"
#import "DRStation.h"
#import "ARView.h"

@interface DRARViewController ()

@end

@implementation DRARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ARView *arView = (ARView *)self.view;
    NSArray *stations = [[DRStationStorage sharedStorage] allStations];
    for (DRStation *station in stations) {
        UILabel *label = [[UILabel alloc] init];
		label.adjustsFontSizeToFitWidth = NO;
		label.opaque = NO;
		label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f];
		label.center = CGPointMake(200.0f, 200.0f);
		label.textAlignment = UITextAlignmentCenter;
		label.textColor = [UIColor whiteColor];
		label.text = station.addressNew;
		CGSize size = [label.text sizeWithFont:label.font];
		label.bounds = CGRectMake(0.0f, 0.0f, size.width, size.height);
        
        station.view = label;
    }
    [arView setPlacesOfInterest:stations];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ARView *arView = (ARView *)self.view;
	[arView start];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	ARView *arView = (ARView *)self.view;
	[arView stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return interfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Actions methods
- (IBAction)dismissPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end

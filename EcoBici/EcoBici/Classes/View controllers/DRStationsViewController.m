//
//  DRStationsViewController.m
//  EcoBici
//
//  Created by Daniel Rueda Jimenez on 9/18/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import "DRStationsViewController.h"
#import "DRStationStorage.h"
#import "DRStation.h"

@interface DRStationsViewController ()
{
    NSArray *_stations;
}
@end

@implementation DRStationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[DRStationStorage sharedStorage] requestStationsWithSuccess:^(NSArray *stations) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _stations = stations;
            [[self tableView] reloadData];
            [[self mapView] addAnnotations:_stations];
        }];
    } failure:^(NSError *error) {
        NSLog(@"Error durante el error %@", [error localizedDescription]);
    }];
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Helpers methods


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_stations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"stationsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    DRStation *station = [_stations objectAtIndex:indexPath.row];
    cell.textLabel.text = [station identifier];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Lat %@ Long %@", station.latitude, station.longitude];
    
    return cell;
}

#pragma mark - Delegates
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString* stationPinIdentifier = @"stationPinIdentifier";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *) [theMapView dequeueReusableAnnotationViewWithIdentifier:stationPinIdentifier];
    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:stationPinIdentifier];
        [pinView setCanShowCallout:YES];
    }else{
        pinView.annotation = annotation;
    }
    
    return pinView;
}

@end

//
//  DRStationsViewController.m
//  EcoBici
//
//  Created by Planet Media on 9/18/12.
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
        }];
    } failure:^(NSError *error) {
        NSLog(@"Error durante el error %@", [error localizedDescription]);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Helpers methods
- (void)updateMapAnnotations
{
    
}

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}
@end

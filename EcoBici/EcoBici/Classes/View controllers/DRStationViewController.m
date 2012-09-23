//
//  DRStationViewController.m
//  EcoBici
//
//  Created by Daniel Rueda Jimenez on 9/18/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import "DRStationViewController.h"
#import "DRStation.h"

@interface DRStationViewController ()

@end

@implementation DRStationViewController
@synthesize station = _station;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kNumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"stationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *title = nil;
    NSString *subtitle = nil;
    switch (indexPath.row) {
        case kNameStation:
            title = @"Estación";
            subtitle = _station.name;
            break;
        case kSlotsStation:
            title = @"Espacios Disponibles";
            subtitle = _station.slots;
            break;
        case kBikesStation:
            title = @"Bicicletas Disponibles";
            subtitle = _station.bikes;
            break;
        case kDistanceStation:
            title = @"Distancia";
            subtitle = _station.distanceCalculated;
            break;
        default:
            break;
    }
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = subtitle;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

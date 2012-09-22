//
//  DRStationViewController.h
//  EcoBici
//
//  Created by Daniel Rueda Jimenez on 9/18/12.
//  Copyright (c) 2012 Xtr3m0. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRStation;

typedef enum _rowsValues
{
    kNameStation = 0,
    kSlotsStation,
    kBikesStation,
    kDistanceStation,
    kNumberOfRows
}rowsValues;

@interface DRStationViewController : UITableViewController

@property (nonatomic, strong) DRStation *station;

@end

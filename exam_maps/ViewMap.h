//
//  ViewController.h
//  exam_maps
//
//  Created by Luis de Alba Gonzalez on 5/22/15.
//  Copyright (c) 2015 ContiWorld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "UIViewController+MaryPopin.h"
#import "PopinAddMark.h"

@interface ViewMap : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate>
//Variables
@property (strong, nonatomic) CLLocationManager     *locationManager;
@property (strong, nonatomic) CLLocation            *location;
@property (strong, nonatomic) IBOutlet UILabel *lblLatitud;
@property (strong, nonatomic) IBOutlet UILabel *lblLongitud;

//Properties
@property (strong, nonatomic) IBOutlet UIView *vMap;

//Actions
- (IBAction)btnPressedRefresh:(id)sender;
- (IBAction)btnPressedAdd:(id)sender;


@end


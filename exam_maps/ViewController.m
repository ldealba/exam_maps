//
//  ViewController.m
//  exam_maps
//
//  Created by Luis de Alba Gonzalez on 5/22/15.
//  Copyright (c) 2015 ContiWorld. All rights reserved.
//  based on https://developers.google.com/maps/documentation/ios/start for the implementation

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Declarations.h"

@interface ViewController ()

@end

@implementation ViewController
{
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //-------------------------------------------------------------------------------
    //Location
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyKilometer;
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager  requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**********************************************************************************************
 Localization
 **********************************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = locations.lastObject;
    NSLog( @"didUpdateLocation!");
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         for (CLPlacemark *placemark in placemarks)
         {
             NSString *addressName = [placemark name];
             NSString *city = [placemark locality];
             NSString *administrativeArea = [placemark administrativeArea];
             NSString *country  = [placemark country];
             NSString *countryCode = [placemark ISOcountryCode];
             NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
             strUserLocation = [[administrativeArea stringByAppendingString:@","] stringByAppendingString:countryCode];
             NSLog(@"strUserLocation = %@", strUserLocation);
         }
         mlatitude = self.locationManager.location.coordinate.latitude;
         mlongitude = self.locationManager.location.coordinate.longitude;
         NSLog(@"mlatitude = %f", mlatitude);
         NSLog(@"mlongitude = %f", mlongitude);
         //Conversion from float to string
         _lblLatitud.text    = [NSString stringWithFormat:@"%f", mlatitude];
         _lblLongitud.text   = [NSString stringWithFormat:@"%f", mlongitude];

     }];
}
//-------------------------------------------------------------------------------
- (void) paintMap
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mlatitude
                                                            longitude:mlongitude
                                                                 zoom:14];
    mapView_                    = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled  = YES;
    mapView_.frame              = CGRectMake(0, 0, self.vMap.frame.size.width, self.vMap.frame.size.height);
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(mlatitude, mlongitude);
    marker.title = @"Ubicacion actual";
    marker.snippet = @"Aqui estoy!";
    marker.map = mapView_;
    
    
    [self.vMap addSubview:mapView_];
}

/**********************************************************************************************
 Popin View Controller
 **********************************************************************************************/
- (void) createPopin
{//-------------------------------------------------------------------------------
    PopinTwoOptions *popin = [[PopinTwoOptions alloc] init];
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleZoom];
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [popin setPopinAlignment:0];
    
    BKTBlurParameters *blurParameters       = [BKTBlurParameters new];
    blurParameters.alpha                    = 1.0f;
    blurParameters.radius                   = 8.0f;
    blurParameters.saturationDeltaFactor    = 1.8f;
    blurParameters.tintColor                = [UIColor colorWithRed:0/255.0 green:130/255.0 blue:255/255.0 alpha:0.50];
    [popin setBlurParameters:blurParameters];
    [popin setPopinOptions:[popin popinOptions]|BKTPopinBlurryDimmingView];
    [popin setPreferedPopinContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:nil];
}



- (IBAction)btnPressedRefresh:(id)sender
{
    [self paintMap];
}

- (IBAction)btnPressedAdd:(id)sender
{
    [self createPopin];
}
@end

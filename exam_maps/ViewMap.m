//
//  ViewController.m
//  exam_maps
//
//  Created by Luis de Alba Gonzalez on 5/22/15.
//  Copyright (c) 2015 ContiWorld. All rights reserved.
//  based on https://developers.google.com/maps/documentation/ios/start for the implementation

#import "ViewMap.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Declarations.h"

NSString    *tempLatitud;
NSString    *tempLongitud;
NSString    *tempIdentificador;
NSInteger   iArrayCount;
float       fTempFloat;


@interface ViewMap ()

@end

@implementation ViewMap
{
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
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

//_____________________________________________________________________
- (void)initController
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ViewControllerActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mapChanged:)
                                                 name:@"newMap" object:nil];

    
    mUserDefaultsMaps   = [NSUserDefaults standardUserDefaults];
    
    
    if (!(nil == [mUserDefaultsMaps objectForKey:@"permLatitud"]) && !([@"" isEqual:[mUserDefaultsMaps objectForKey:@"permLatitud"]]))
    {//Case when varaibel has some value in permanent phone memory
        maLatitudes    = [mUserDefaultsMaps objectForKey:@"permLatitud"];
        NSLog(@"maLatitudes tenia la variable: %@", maLatitudes);
    }
    else
    {//No info has been stored before
        maLatitudes        = [NSMutableArray arrayWithObjects: nInitialLatitude];
    }
    //-----------------------------------------
    if (!(nil == [mUserDefaultsMaps objectForKey:@"permLongitud"]) && !([@"" isEqual:[mUserDefaultsMaps objectForKey:@"permLongitud"]]))
    {//Case when varaibel has some value in permanent phone memory
        maLongitudes    = [mUserDefaultsMaps objectForKey:@"permLongitud"];
        NSLog(@"maLongitudes tenia la variable: %@", maLongitudes);
    }
    else
    {//No info has been stored before
        maLongitudes        = [NSMutableArray arrayWithObjects: nInitialLongitude];
    }
    //-----------------------------------------
    if (!(nil == [mUserDefaultsMaps objectForKey:@"permIdentif"]) && !([@"" isEqual:[mUserDefaultsMaps objectForKey:@"permIdentif"]]))
    {//Case when varaibel has some value in permanent phone memory
        maIdentificadores    = [mUserDefaultsMaps objectForKey:@"permIdentif"];
        NSLog(@"maIdentificadores tenia la variable: %@", maIdentificadores);
    }
    else
    {//No info has been stored before
        maIdentificadores        = [NSMutableArray arrayWithObjects: nInitialIdentifier];
    }
    
}
- (void)ViewControllerActive:(NSNotification *)notification
{
    NSLog(@"Map is Active");
}
- (void)mapChanged:(NSNotification *)notification
{
    NSLog(@"Map has changed");
    //[self addMarkerToMap: 20.6312798f) longitude: -103.4155183f Identifier:@"Jelou"];
    
    [self addMarkerToMap:[maLatitudes objectAtIndex:[maLatitudes count]-1] longitude:[maLongitudes objectAtIndex:[maLongitudes count]-1] Identifier:[maIdentificadores objectAtIndex:[maIdentificadores count]-1]];
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
           //  NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
             strUserLocation = [[administrativeArea stringByAppendingString:@","] stringByAppendingString:countryCode];
             NSLog(@"strUserLocation = %@", strUserLocation);
         }
         mlatitude = self.locationManager.location.coordinate.latitude;
         mlongitude = self.locationManager.location.coordinate.longitude;
      //   NSLog(@"mlatitude = %f", mlatitude);
      //   NSLog(@"mlongitude = %f", mlongitude);
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

/**********************************************************************************************/
 #pragma mark - Popin View Controller
/**********************************************************************************************/

- (void) createPopin
{//-------------------------------------------------------------------------------
    PopinAddMark *popin = [[PopinAddMark alloc] init];
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

/**********************************************************************************************/
#pragma mark - Add Marker
/**********************************************************************************************/
- (void) addMarkerToMap:(NSString *) sLatitude longitude:(NSString *) sLongitude Identifier:(NSString *) sIdentifier
{
    GMSCoordinateBounds *bounds;
    UIColor *color                      = [UIColor colorWithHue:0.5f saturation:1.f brightness:1.f alpha:1.0f];
    
    float   fLatitude   = [sLatitude floatValue];
    float   fLongitude  = [sLongitude floatValue];
    
    CLLocationCoordinate2D position     = CLLocationCoordinate2DMake(fLatitude, fLongitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    // Creates a marker in the center of the map.
    //GMSMarker *marker = [[GMSMarker alloc] init];
    //marker.position = CLLocationCoordinate2DMake(fLatitude, fLongitude);
    marker.title = sIdentifier;
    marker.snippet = @"Mi marcador";
    
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.icon = [GMSMarker markerImageWithColor:color];
    
    //move camera to the marker position
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:fLatitude
                                                            longitude:fLongitude
                                                                 zoom:14];
    mapView_.camera     = camera;
    
    marker.map = mapView_;
    /*
    //Move camera to new coordinates
    bounds = [bounds includingCoordinate:marker.position];
    GMSCameraUpdate *update = [GMSCameraUpdate fitBounds:bounds withPadding:50.0f];
    [mapView_ moveCamera:update];
    */
    
    [self.vMap addSubview:mapView_];
    
    NSLog(@"New Marker Added");

}
/**********************************************************************************************/
#pragma mark - Add Marker 2
/**********************************************************************************************/
- (void) addMarkerToMap2:(NSString *) sLatitude longitude:(NSString *) sLongitude Identifier:(NSString *) sIdentifier
{
    GMSCoordinateBounds *bounds;
    UIColor *color                      = [UIColor colorWithHue:0.5f saturation:1.f brightness:1.f alpha:1.0f];
    
    float   fLatitude   = [sLatitude floatValue];
    float   fLongitude  = [sLongitude floatValue];
    
    CLLocationCoordinate2D position     = CLLocationCoordinate2DMake(fLatitude, fLongitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    // Creates a marker in the center of the map.
    //GMSMarker *marker = [[GMSMarker alloc] init];
    //marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = sIdentifier;
    marker.snippet = @"Mi marcador";
    
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.icon = [GMSMarker markerImageWithColor:color];
    
    marker.map = mapView_;
    //Move camera to new coordinates
    bounds = [bounds includingCoordinate:marker.position];
    GMSCameraUpdate *update = [GMSCameraUpdate fitBounds:bounds withPadding:50.0f];
    [mapView_ moveCamera:update];
    
    [self.vMap addSubview:mapView_];
    
    NSLog(@"New Marker Added");
    
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

//
//  Declarations.h
//  exam_maps
//
//  Created by Luis de Alba Gonzalez on 5/24/15.
//  Copyright (c) 2015 ContiWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

//Key for the google maps application
#define     sGoogleKey      @"AIzaSyDDVt1-iKqkoZN1PNM9cV1TQcP9h5xKAag"

//Colors
#define     nBlackTransparency  colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.50

//Initial values for places
#define     nInitialLatitude    @"20.6312798",nil
#define     nInitialLongitude   @"-103.4155183",nil
#define     nInitialIdentifier  @"Marcador Inicial",nil


extern      NSString        *strUserLocation;
extern      float           mlatitude;
extern      float           mlongitude;

extern      NSMutableArray  *maLongitudes;
extern      NSMutableArray  *maLatitudes;
extern      NSMutableArray  *maIdentificadores;

extern      NSUserDefaults  *mUserDefaultsMaps;

extern      NSMutableArray  *maCustomLocation;

extern      NSMutableArray  *maMarkers;

@interface Declarations : NSObject

@end

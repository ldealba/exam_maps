//
//  Declarations.h
//  exam_maps
//
//  Created by Luis de Alba Gonzalez on 5/24/15.
//  Copyright (c) 2015 ContiWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

#define     nTextEmpty          0
#define     nTextNoEmpty        1

extern      int                 iKeyboardHeight;
extern      int                 iKeyboardWidth;

/**********************************************************************
 Google maps Tab Variables
 **********************************************************************/
//Key for the google maps application
#define     sGoogleKey          @"AIzaSyDDVt1-iKqkoZN1PNM9cV1TQcP9h5xKAag"

//Colors
#define     nBlackTransparency  colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.50

//Initial values for places
#define     nInitialLatitude    @"20.6312798",nil
#define     nInitialLongitude   @"-103.4155183",nil
#define     nInitialIdentifier  @"Marcador Inicial",nil

extern      NSString            *strUserLocation;
extern      float               mlatitude;
extern      float               mlongitude;

extern      NSMutableArray      *maLongitudes;
extern      NSMutableArray      *maLatitudes;
extern      NSMutableArray      *maIdentificadores;
extern      NSUserDefaults      *mUserDefaultsMaps;
extern      NSMutableArray      *maCustomLocation;
extern      NSMutableArray      *maMarkers;

/**********************************************************************
 Contacts Tab Variables
 **********************************************************************/
#define     nInitialName        @"Fulano",nil
#define     nInitialImg         @"Contacts-Default-icon.png"
#define     nCellStatesHeight   60
#define     nTxtContMaxLenght   50

extern      NSMutableArray      *maContactNames;
extern      NSMutableArray      *maContactImages;
extern      int                 miIndex;
extern      NSData              *mImageData;
extern      BOOL                boAllContTxts;
extern      BOOL                boTxtContact;
extern      NSData              *mTempImage;


@interface Declarations : NSObject

@end

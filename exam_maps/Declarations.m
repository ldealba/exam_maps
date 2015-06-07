//
//  Declarations.m
//  exam_maps
//
//  Created by Luis de Alba Gonzalez on 5/24/15.
//  Copyright (c) 2015 ContiWorld. All rights reserved.
//

#import "Declarations.h"

NSString        *strUserLocation;
float           mlatitude;
float           mlongitude;

NSMutableArray  *maLongitudes;
NSMutableArray  *maLatitudes;
NSMutableArray  *maIdentificadores;

NSMutableArray  *maCustomLocation; // = [[NSMutableArray alloc] initWithCapacity:3];

NSUserDefaults  *mUserDefaultsMaps;

//Array where markers will be saved
NSMutableArray  *maMarkers;

@implementation Declarations

@end

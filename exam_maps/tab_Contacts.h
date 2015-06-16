//
//  tab_Contacts.h
//  exam_maps
//
//  Created by Luis de Alba Gonzalez on 6/11/15.
//  Copyright (c) 2015 ContiWorld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Declarations.h"
#import "UIViewController+MaryPopin.h"
#import "PopinAddContact.h"


@interface tab_Contacts : UIViewController<UIPickerViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


//Tabs
//Properties
@property (strong, nonatomic) IBOutlet UITableView *tblNames;

//Button add contact
- (IBAction)btnAddContact_pressed:(id)sender;

@end

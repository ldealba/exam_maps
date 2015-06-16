//
//  tab_ChooseImg.h
//  exam_maps
//
//  Created by Luis de Alba Gonzalez on 6/14/15.
//  Copyright (c) 2015 ContiWorld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Declarations.h"


@interface tab_ChooseImg : UIViewController<UIPickerViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property BOOL newMedia;

@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;

//buttons
- (IBAction)btnCancel_Pressed:(id)sender;
- (IBAction)btnAceptar:(id)sender;


@end

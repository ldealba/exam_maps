//
// The MIT License (MIT)
//
// Copyright (c) 2013 Backelite
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "PopinAddContact.h"
#import "tab_ChooseImg.h"
#import "Declarations.h"



UIImage         *NewContactImage;

@interface PopinAddContact ()
@end

@implementation PopinAddContact

//-------------------------------------------------------------------------------
- (void)viewDidLoad {
    boAllContTxts   = nTextEmpty;
    boTxtContact    = nTextEmpty;
    
    [super viewDidLoad];
    NSLog(@"PopinBuyTicket viewDidLoad");
}
//-------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initViewController];
}
/**********************************************************************************************
 Initialization
 **********************************************************************************************/
- (void) initViewController
{
    NSLog(@"initViewController");
    //Add a notification to let app know when the keyboard appears, so the texts move accordingly
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow2:) name:UIKeyboardDidShowNotification object:nil];
    //Add a notification to know when the image has changed
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contactImgChanged:) name:@"newContactImg" object:nil];

    
    
    self.vMain.layer.borderColor  = [UIColor clearColor].CGColor;
    self.vMain.layer.borderWidth  = 1.0;
    self.vMain.clipsToBounds      = YES;
    self.vMain.layer.cornerRadius = 8;
    if (mTempImage == nil)
    {
        NSLog(@"No image has been loaded before");
        self.imgContactPhoto.image      = [UIImage imageNamed:nInitialImg];
    }
    else
    {
        self.imgContactPhoto.image      = [UIImage imageWithData:mTempImage];
    }
    

}
/**********************************************************************************************/
#pragma mark - Notifications
/**********************************************************************************************/
- (void)contactImgChanged:(NSNotification *)notification
{
    NSLog(@"Contact Image has changed");
    self.imgContactPhoto.image              = [UIImage imageWithData:mTempImage];
    self.imgContactPhoto.backgroundColor    = nil;
    
}
/**********************************************************************************************
 Keyboard appears and disappears
 **********************************************************************************************/
- (void)keyboardDidShow2:(NSNotification *)notification
{
    NSLog(@"keyboardDidShow2");
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    iKeyboardHeight     = MIN(keyboardSize.height,keyboardSize.width);
    iKeyboardWidth      = MAX(keyboardSize.height,keyboardSize.width);
    
    NSLog(@"height = %d, width  %d", iKeyboardHeight, iKeyboardWidth);
    
    if (self.txtContactName.isEditing)
    {
        self.svMain.contentSize = CGSizeMake(self.svMain.frame.size.width, self.svMain.frame.size.height + iKeyboardHeight/2  + 10);
        
        [self.svMain setContentOffset: CGPointMake(0, 124) animated:YES];
    }
    else
    {
        self.svMain.contentSize = CGSizeMake(self.svMain.frame.size.width, self.svMain.frame.size.height + iKeyboardHeight/2  + 10);
        
        [self.svMain setContentOffset: CGPointMake(0,iKeyboardHeight - (self.view.frame.size.height - self.vMain.frame.size.height)/2 + 10)  animated:YES];
    }
}
/**********************************************************************************************
 Text Fields
 **********************************************************************************************/
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int x = (int)range.length;
    NSLog(@"x = %d", x);
    
    NSLog(@"Some text changed");
    if (textField == self.txtContactName)
    {
        NSLog(@"txtContactName");
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([newString length] > nTextEmpty)
        {
            boTxtContact      = nTextNoEmpty;
            self.txtContactName.backgroundColor = nil;  //[UIColor lightGrayColor];
            if ([newString length] > nTxtContMaxLenght)
            {
                return NO;
            }
        }
        else
        {
            boTxtContact      = nTextEmpty;
        }
        return YES;
    }
    
    
    return NO;
}
/**********************************************************************************************/
 #pragma mark - Buttons_functions
/**********************************************************************************************/
- (IBAction)btnCancelPressed:(id)sender
{
    [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:nil];
}

- (IBAction)btnSavePressed:(id)sender
{
    if ((boTxtContact == nTextEmpty) || (mTempImage == nil))
    {//At least one of the text is empty
        if (boTxtContact == nTextEmpty)
        {
            self.txtContactName.backgroundColor     = [UIColor redColor];
        }
        if (mTempImage == nil)
        {
            self.imgContactPhoto.backgroundColor    = [UIColor redColor];
        }
    }
    else
    {//All text have info
        NSLog(@"Ready for save contact");
        
        maContactNames  = [[NSMutableArray arrayWithArray:maContactNames] mutableCopy];
        [maContactNames addObject:self.txtContactName.text];
        
        maContactImages = [[NSMutableArray arrayWithArray:maContactImages] mutableCopy];
        [maContactImages addObject:mTempImage];
        
        [mUserDefaultsMaps setObject: maContactNames forKey: @"permContactName"];
        [mUserDefaultsMaps setObject: maContactImages forKey: @"permContactImage"];
        
        
        NSLog(@"permContactName = %@", [mUserDefaultsMaps objectForKey:@"permContactName"]);
        
        //activate notification to let table know that a new contact has been added
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NewContactAdded" object:nil];
        
        [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:nil];
    }
    
}

/**********************************************************************************************/
#pragma mark - Image_Button
/**********************************************************************************************/

- (IBAction)btnChangeImage_Pressed:(id)sender
{
    
    tab_ChooseImg *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tab_ChooseImg"];
    [self presentViewController:viewController animated:YES completion:nil];
   
}
@end

//
//  tab_ChooseImg.m
//  exam_maps
//
//  Created by Luis de Alba Gonzalez on 6/14/15.
//  Copyright (c) 2015 ContiWorld. All rights reserved.
//

#import "tab_ChooseImg.h"
#import "Declarations.h"

@interface tab_ChooseImg ()

@end

@implementation tab_ChooseImg

- (void)viewDidLoad {
    [super viewDidLoad];
    [self imageOptions];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/******************************************************************************/
#pragma mark - ChooseImage
/******************************************************************************/
- (void)imageOptions
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:[NSString stringWithFormat:@"Cancelar"]
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:
                                  [NSString stringWithFormat:@"Tomar foto"],
                                  [NSString stringWithFormat:@"Seleccionar de carrete"],
                                  [NSString stringWithFormat:@"Usar Default"], nil];
    [actionSheet showInView:self.view];

}

/******************************************************************************/
#pragma mark - Buttons_Actions
/******************************************************************************/
- (IBAction)btnCancel_Pressed:(id)sender
{   //exit
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnAceptar:(id)sender
{
    //save the selected image and exit
    mTempImage  = UIImagePNGRepresentation(self.imgPhoto.image);
    //activate notification to let popin know that new image has been set
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newContactImg" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**********************************************************************************************/
#pragma mark - Alert_views
/**********************************************************************************************/
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if([buttonTitle isEqualToString:[NSString stringWithFormat:@"Tomar foto"]])
    {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker    = [[UIImagePickerController alloc] init];
            imagePicker.delegate                    = self;
            imagePicker.sourceType                  = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes                  = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing               = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            self.newMedia = YES;
        }
    }
    else if([buttonTitle isEqualToString:[NSString stringWithFormat:@"Seleccionar de carrete"]])
    {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            UIImagePickerController *imagePicker    = [[UIImagePickerController alloc] init];
            imagePicker.delegate                    = self;
            imagePicker.sourceType                  = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes                  = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing               = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            self.newMedia = NO;
        }
    }
    else if([buttonTitle isEqualToString:[NSString stringWithFormat:@"Usar Default"]])
    {
        self.imgPhoto.image  = [UIImage imageNamed:nInitialImg];
        //[self dismissViewControllerAnimated:YES completion:nil];
    }
}
/**********************************************************************************************/
#pragma mark UIImagePickerControllerDelegate
/**********************************************************************************************/

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *image      = info[UIImagePickerControllerOriginalImage];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.imgPhoto.image      = image;
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}
//-------------------------------------------------------------------------------
-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: [NSString stringWithFormat:@"Error"]
                              message: [NSString stringWithFormat:@"Error Foto"]
                              delegate: nil
                              cancelButtonTitle:[NSString stringWithFormat:@"OK"]
                              otherButtonTitles:nil];
        [alert show];
    }
}
//-------------------------------------------------------------------------------
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

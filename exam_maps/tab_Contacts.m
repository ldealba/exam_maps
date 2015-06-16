//
//  tab_Contacts.m
//  exam_maps
//
//  Created by Luis de Alba Gonzalez on 6/11/15.
//  Copyright (c) 2015 ContiWorld. All rights reserved.
//

#import "tab_Contacts.h"
#import "celNames.h"
#import "Declarations.h"

UIImage         *contactImage;

@interface tab_Contacts ()

@end

@implementation tab_Contacts

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/******************************************************************************/
#pragma mark - Table_init
/******************************************************************************/
- (void)initController
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Tab_Contacts_Active:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    //Add a notification to know when a contact has been added
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NewContactAdded:) name:@"NewContactAdded" object:nil];
    
    mUserDefaultsMaps       = [NSUserDefaults standardUserDefaults];
    
    
    if (!(nil == [mUserDefaultsMaps objectForKey:@"permContactName"]) && !([@"" isEqual:[mUserDefaultsMaps objectForKey:@"permContactName"]]))
    {//Case when varaibel has some value in permanent phone memory
        maContactNames      = [mUserDefaultsMaps objectForKey:@"permContactName"];
    }
    else
    {//No info has been stored before
        maContactNames      = [NSMutableArray arrayWithObjects: nInitialName];
    }
    //-----------------------------------------
    if (!(nil == [mUserDefaultsMaps objectForKey:@"permContactImage"]) && !([@"" isEqual:[mUserDefaultsMaps objectForKey:@"permContactImage"]]))
    {//Case when varaibel has some value in permanent phone memory
        //mImageData          = [mUserDefaultsMaps dataForKey:@"permContactImage"];
        maContactImages     = [mUserDefaultsMaps objectForKey:@"permContactImage"];
    }
    else
    {//No info has been stored before
        contactImage        = [UIImage imageNamed:nInitialImg];
        maContactImages     = [NSMutableArray arrayWithObjects:UIImagePNGRepresentation(contactImage), nil];
        //maContactImages     = [NSMutableArray arrayWithObjects: contactImage,nil];
    }
    
    [self.tblNames reloadData];
}
/**********************************************************************************************/
#pragma mark - Notifications
/**********************************************************************************************/
- (void)NewContactAdded:(NSNotification *)notification
{
    NSLog(@"A new contact has been added");
    [self.tblNames reloadData];
}
- (void)Tab_Contacts_Active:(NSNotification *)notification
{
    NSLog(@"Tab_Contacts is Active");
}

/******************************************************************************/
 #pragma mark - Table_Functions
/******************************************************************************/
//-----------------------------------------
//Table functions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return maContactNames.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nCellStatesHeight;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"celNames");
    static NSString *CellIdentifier = @"celNames";
    
    celNames *cell = (celNames *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[celNames alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.lblContactName.text    = maContactNames[indexPath.row];
    cell.imgContact.image       = [UIImage imageWithData:maContactImages[indexPath.row]];
    //Images too
    return cell;
}
//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row = %d", (int)indexPath.row);
    miIndex     = (int)indexPath.row;
    /*
    Tab01_Selected *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Tab01_Selected"];
    [self presentViewController:viewController animated:YES completion:nil];
     */
}

/**********************************************************************************************/
#pragma mark - Popin View Controller
/**********************************************************************************************/
- (void) createPopin
{//-------------------------------------------------------------------------------
    PopinAddContact *popin = [[PopinAddContact alloc] init];
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

//-------------------------------------------------------------------------------

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 NSLog(@"didSelectRowAtIndexPath");
 Tab01Details *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Tab01Details"];
 //[self.navigationController pushViewController:viewController animated:YES];
 [self presentViewController:viewController animated:YES completion:nil];
 }*/


- (IBAction)btnAddContact_pressed:(id)sender
{
    [self createPopin];
}
@end

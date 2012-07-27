//
//  SettingsController.m
//  Feedin Zombies
//
//  Created by logan sease on 12-04-12.
//  Copyright (c) 2012 Logan Sease. All rights reserved.
//

#import "SettingsController.h"

#import "MyFBManager.h"
#import "SocialScoresManager.h"

@implementation SettingsController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
    
    self.title  = @"Settings";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int result = 0;
    
    if(section == kSectionFacebook)
    {
        result = 2;
    }
    
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * defaultIdentifier = @"Cell";
    
    NSString *CellIdentifier = defaultIdentifier;
    
    if(indexPath.section == kSectionFacebook && indexPath.row == kFacebookLoginRow)
    {
        CellIdentifier = defaultIdentifier;
    }
    else if(indexPath.section == kSectionFacebook && indexPath.row == kFacebookScoresRow)
    {
        CellIdentifier = kSwitchCellIdentifier;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //create a switch cell
    if (cell == nil && CellIdentifier == kSwitchCellIdentifier) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSwitchCellIdentifier] autorelease];
		UISwitch * switchView = [[UISwitch alloc] init];
		cell.accessoryView = switchView;
		[switchView release];
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        
    }
    
    //create a log in cell
    else if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    }
    
    
    if(indexPath.section == kSectionFacebook)
    {
        
        //create the facebook login row
        if(indexPath.row == kFacebookLoginRow)
        {
            cell.textLabel.text = @"Facebook:";
            MyFBManager * fb = [MyFBManager sharedManager];
            if([fb.facebook isSessionValid])
            {
                cell.detailTextLabel.text = @"Sign out";
            }
            else
            {
                cell.detailTextLabel.text = @"Sign in";
            }
            
        }
        
        //enable social scores switch row
        else if(indexPath.row == kFacebookScoresRow)
        {
            
            cell.textLabel.text = @"Social Scores";
            UISwitch * theSwitch = (UISwitch*)cell.accessoryView;
            theSwitch.on = [[SocialScoresManager sharedManager] isEnabled];
            [theSwitch addTarget:self action:@selector(socialPressed:) forControlEvents:UIControlEventValueChanged];
            
            cell.textLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
            cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f];
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString * result = @"";
    if(section == kSectionFacebook)
    {
        result = @"Social";
    }

    return result;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];

    //log in or log out of facebook
    if(indexPath.section == kSectionFacebook && indexPath.row == kFacebookLoginRow)
    {
        MyFBManager * fb = [MyFBManager sharedManager];
        if([fb.facebook isSessionValid])
        {
            [fb.facebook logout];
            [self.tableView reloadData];
        }
        else
        {
            MyFBManager * fb = [MyFBManager sharedManager];
            fb.delegate = self;
            [fb.facebook authorizeInApp:kFbPermissions];
        }
    }
}

#pragma mark action methods

//enable or disable social scores
-(void) socialPressed:(id)sender
{
    UISwitch * theSwitch = (UISwitch*)sender;
    [[SocialScoresManager sharedManager] setEnabled:theSwitch.on];
}



#pragma mark facebook methods

//after a user has logged into facebook, call the prepare method
- (void)didFinishLogin{
    
    [self.tableView reloadData];
    
    if([[SocialScoresManager sharedManager] isEnabled])
    {
      [  [SocialScoresManager sharedManager]prepareForFbUser];
    }
    
}


#pragma mark releasing methods
-(void) dealloc
{
    [super dealloc];

}

@end

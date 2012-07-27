//
//  SettingsController.h
//  Feedin Zombies
//
//  Created by logan sease on 12-04-12.
//  Copyright (c) 2012 Logan Sease. All rights reserved.
//  This is a generic settings controller for you to use.

#import <UIKit/UIKit.h>
#import "MyFBManager.h"


#define kSwitchCellIdentifier   @"SwitchCell"
#define kFacebookLikeRow    1
#define kFacebookLoginRow   0
#define kFacebookScoresRow  1

#define kSectionFacebook    0


@class PurchasesController;

@interface SettingsController : UITableViewController<MyFBManagerDelegate>
{

}

@end

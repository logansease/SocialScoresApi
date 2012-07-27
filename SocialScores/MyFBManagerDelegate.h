//
//  MyFBManagerDelegate.h
//
//  Created by lsease on 10-06-18.
//  Copyright 2010 iParty Mobile. All rights reserved.
//  This is a delegate for the Facebook manager to report when certain actions occur.


#import "FBDialog.h"
@protocol MyFBManagerDelegate<NSObject,NSCoding>

@optional
-(void) gotFriendResults:(NSArray*)friends;
-(void) didFinishLogin;
-(void) didFinishLogout;
-(void) dialogDidSucceed:(FBDialog*)dialog;
@end

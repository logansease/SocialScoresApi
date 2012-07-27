//
//  MyFBManager.h
//
//  Created by lsease on 10-06-16.
//  Copyright 2010 iParty Mobile. All rights reserved.
//  This Manager Class is used to manage a facebook connect object.

#import <Foundation/Foundation.h>
#import "Facebook.h"
#import "MyFacebook.h"
#import "MyFBManagerDelegate.h"
#import "SocialScoresConfig.h"

//permissions used by facebook.
#define kFbPermissions [NSArray arrayWithObjects:@"publish_stream",@"email",nil]


@interface MyFBManager : NSObject<FBSessionDelegate,FBDialogDelegate,FBRequestDelegate,UIWebViewDelegate> {
    
    //the main fb connect objects
	Facebook * facebook;
	id<MyFBManagerDelegate> delegate;
    
    //used to track state
	int dialogState;
    
	FBLoginDialog * loginDialog;
    
    //info about the current logged in user
    NSString * email;
    NSString * name;
    int facebookId;

}

//singleton methods
+ (id)sharedManager;

//public methods
-(void)getFriendList;
-(void) showLogin;
-(void) postStoryWithAttachment:(NSMutableDictionary*)params toFriend:(NSString*)friendId;
-(void) autoPostStoryWithAttachment:(NSMutableDictionary*)params toFriend:(NSString*)friendId;
-(void) getPermission;

@property(nonatomic,retain) NSString * email;
@property(nonatomic,retain) NSString * name;
@property int facebookId;
@property(nonatomic,retain) FBLoginDialog * loginDialog;
@property(nonatomic,retain) id<MyFBManagerDelegate> delegate;
@property(nonatomic,retain) Facebook* facebook;
@end

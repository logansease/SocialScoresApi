//
//  SocialScoresManager.h
//
//  Created by logan sease on 12-05-01.
//  Copyright (c) 2012 Logan Sease. All rights reserved.
//  This is the manager for the social scores.

#import <UIKit/UIKit.h>
#import "ScoresViewController.h"
#import "SocialScoresConfig.h"

//this delegate is used to alert another controller when loads are complete
@protocol SocialScoresManagerDelegate <NSObject>
@optional
-(void)scoreLoadDidFinish:(NSDictionary*)scores;
@end


@interface SocialScoresManager : NSObject
{
    //accessory views
    ScoresViewController * scoresController;
    UIView * loadingView;
    
    //state variables
    BOOL cancelled;
    BOOL disableSave;
}

//access to the singleton object. Call this not init
+(id) sharedManager;

//this must be called if you want to show a loading view to display while the scores are loading. highly recommened.
-(void) setupLoadingViewInView:(UIView*)view;

//show a list of top scores for a particular level. Must pass a view controller for a modal
//view to display. Options include:
//score- a score to save first
//max- a maximum # of scores to display
//delay- a delay to add before showing
//overall- if you do not want to show fb friends scores, only overall
-(void)showTopScoresForLevel:(NSString*)levelId inViewController:(UIViewController*)viewController withOptions:(NSDictionary*)options;

//will return an NSDictionary with the high scores for you to display yourself. showTopScores
//ForLevel for a list of options. See ScoresViewController for an example of parsing and
//showing the dictionary
-(void)loadTopScoresForLevel:(NSString*)levelId withOptions:(NSDictionary*)options;

//save a users scores for a particular level
-(BOOL)saveScore:(int)score forLevel:(NSString*)levelId;

//enable social scores
-(void) setEnabled:(BOOL)isEnabled;

//determine if it is enabled
-(BOOL) isEnabled;

//make a call to prepare for a given FB user. If the user has not been loaded into the social
//scores system, calling this will ensure the fastest possible time to load and save their
//scores. Should be called after FB Log in.
-(void)prepareForFbUser;


//helper methods
-(void)stopLoading;
+ (BOOL)connected;

//properties
@property(nonatomic,retain)  UIView * loadingView;
@property(nonatomic,retain) ScoresViewController * scoresController;
@property BOOL disableSave;

@end




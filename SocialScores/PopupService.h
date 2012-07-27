//
//  PopupService.h
//
//  Created by logan sease on 12-03-06.
//  Copyright (c) 2012 iParty Mobile. All rights reserved.
//  This service helps to show a popup window with a message while something is loading.

#import <Foundation/Foundation.h>

#define kIndicatorTag   3012
#define kPopupPadding   50
#define kLoadingText    @"Loading..."


@protocol PopupServiceDelegate <NSObject>
@optional
-(void)closePressed;
@end

@interface PopupService : NSObject
{
    UIWindow* window;
    UIView * loadingView;
    UILabel * loadingLabel;
    BOOL allowClose;
    NSObject<PopupServiceDelegate> * delegate;
}
+ (id)sharedService;
-(void) setupWithWindow:(UIWindow*)window;
-(void)startLoading;
-(void)stopLoading;
-(void)setLoadingMessage:(NSString*)message;
@property(nonatomic,retain) UILabel * loadingLabel;
@property(nonatomic,assign) NSObject<PopupServiceDelegate> * delegate;
@property BOOL allowClose;
@end

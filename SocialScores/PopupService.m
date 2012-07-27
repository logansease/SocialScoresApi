//
//  PopupService.m
//  webdeals
//
//  Created by logan sease on 12-03-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PopupService.h"
#import <QuartzCore/QuartzCore.h>

@implementation PopupService

@synthesize loadingLabel;
@synthesize allowClose;
@synthesize delegate;

static PopupService *sharedService = nil;


#pragma mark Init methods

-(id) init {
    self = [super init];
	
    if ( self ) {
    }
	
    return self;
}


+ (id)sharedService {
    @synchronized(self) {
        if (sharedService == nil)
            sharedService = [[self alloc] init];
    }
    return sharedService;
}


-(void) setupWithWindow:(UIWindow*)pWindow
{
    if(window != nil)
    {
        return;
    }
    
    window = pWindow;
    
    int y = kPopupPadding * 2;
    int x = kPopupPadding;
    int size = 20;
    
    int width = window.frame.size.width - 2 * kPopupPadding;
    int height = window.frame.size.height - 2 * kPopupPadding * 2;
    
    UIView * button = [[UIView alloc] init];
    button.backgroundColor = [UIColor blackColor];
    button.layer.cornerRadius = 10.0f;
    [button setFrame:CGRectMake(x, y, width, height)];
    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((width - size) / 2, (height - size) / 2, size, size)];
    activityIndicator.hidesWhenStopped = YES;
    activityIndicator.transform = CGAffineTransformMakeScale(2, 2);
    
    if(allowClose)
    {
        UIButton * close = [UIButton buttonWithType:UIButtonTypeCustom];
        [close setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [close addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    [button addSubview:activityIndicator];
    [button bringSubviewToFront:activityIndicator];
    
    activityIndicator.tag = kIndicatorTag;
    
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, activityIndicator.frame.origin.y + 40, width - 20, 60)];
    self.loadingLabel.text = kLoadingText;
    self.loadingLabel.font = [UIFont fontWithName:@"Arial" size:24];
    self.loadingLabel.textAlignment = UITextAlignmentCenter;
    self.loadingLabel.textColor = [UIColor whiteColor];
    self.loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.numberOfLines = 3;
    [button addSubview:loadingLabel];
    [activityIndicator release];
    
    [window addSubview:button];
    loadingView = button;
    button.hidden = YES;
    
}

#pragma mark action methods

//when the X is pressed
-(void)closePressed
{
    [self stopLoading];
    if(delegate != nil && [delegate respondsToSelector:(@selector(closePressed))])
    {
        [delegate closePressed];
    }
    
}

//set the loading message label
-(void)setLoadingMessage:(NSString*)message
{
    loadingLabel.text = message;
}

//start showing the loading pop up
-(void)startLoading
{
    loadingView.hidden = NO;
    UIActivityIndicatorView * act = (UIActivityIndicatorView*)[loadingView viewWithTag:kIndicatorTag];
    [act startAnimating];
}

//hide the loading popup
-(void)stopLoading
{
    loadingView.hidden = YES;
    UIActivityIndicatorView * act =  (UIActivityIndicatorView*)[loadingView viewWithTag:kIndicatorTag];
    [act stopAnimating];
}

#pragma mark releasing methods

-(void) dealloc
{
    [loadingView release];
    [loadingLabel release];
    [super dealloc];
}

@end

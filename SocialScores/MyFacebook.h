
//
//  Facebook
//
//  Created by logan sease on 12-03-06.
//  Copyright (c) 2012 iParty Mobile. All rights reserved.
//  This is a category for the facebook class that adds a few helper methods
//  to perform a few special functions that we need. 


#import "Facebook.h"


@interface Facebook (socialscores)

- (void)authorizeInApp:(NSArray *)permissions;
- (void)authorizeWithFBAppAuth:(BOOL)tryFBAppAuth
                    safariAuth:(BOOL)trySafariAuth ;
- (NSString *)getOwnBaseUrl;
@end

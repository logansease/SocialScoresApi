//
//  NSStringData+AES.h
//
//  Created by logan sease on 12-03-06.
//  Copyright (c) 2012 iParty Mobile. All rights reserved.
//  These category classes are used for encryptiong


#import <UIKit/UIKit.h>

@interface NSData (AES)

-(NSData *) aesEncryptedDataWithKey:(NSData *) key;
@end

@interface NSString (AES)

- (NSData *) sha256;
@end

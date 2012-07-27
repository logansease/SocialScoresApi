//
//  ScoresViewController.h
//
//  Created by logan sease on 5/3/12.
//  Copyright (c) 2012 Logan Sease. All rights reserved.
//  This view controller displays the scores.

#import <UIKit/UIKit.h>

@interface ScoresViewController : UITableViewController
{
    NSArray * overallScores;
    NSArray * scores;
    NSArray * fbScores;
    int playerScore;
    BOOL noFb;
    UISegmentedControl * typeSegment;
    NSString *levelId;
    UIViewController * delegate;
}
@property BOOL noFb;
@property(nonatomic,retain) UIViewController * delegate;
@property(nonatomic,retain) NSString * levelId;
@property(nonatomic,retain)  UISegmentedControl * typeSegment;
@property(nonatomic,retain) NSArray * fbScores;
@property(nonatomic,retain) NSArray * overallScores;
@property int playerScore;

@end

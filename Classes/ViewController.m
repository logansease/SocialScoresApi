//
//  ViewController.m
//  apiexample
//
//  Created by logan sease on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "SettingsController.h"
#import "SocialScoresManager.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    srand(time(nil));
    [super viewDidLoad];
    self.title = @"Social Scores API example";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(IBAction)settingsPressed{
    SettingsController * settings = [[[SettingsController alloc]initWithStyle:UITableViewStylePlain] autorelease];
    [self.navigationController pushViewController:settings animated:YES];
}
-(IBAction)showScoresPressed
{
    int score = rand() %1000;
    SocialScoresManager * scoreManager = [SocialScoresManager sharedManager];
    NSDictionary * options = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: [NSNumber numberWithInt:score], nil] forKeys:[NSArray arrayWithObjects:@"score", nil]];
    
    [scoreManager showTopScoresForLevel:@"Level 1" inViewController:self withOptions:options];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

//
//  ScoresViewController.m
//  Feedin Zombies
//
//  Created by logan sease on 5/3/12.
//  Copyright (c) 2012 Jeremie Weldin. All rights reserved.
//

#import "ScoresViewController.h"
#import "SocialScoresManager.h"
#import <objc/runtime.h>
#import "MyFBManager.h"

@implementation ScoresViewController
@synthesize playerScore;
@synthesize fbScores;
@synthesize levelId;
@synthesize delegate;
@synthesize overallScores;
@synthesize noFb;
@synthesize typeSegment;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.7f];

    typeSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Friends",@"Overall", nil]];
    typeSegment.selectedSegmentIndex = 0;
	typeSegment.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	typeSegment.segmentedControlStyle = UISegmentedControlStyleBar;
	typeSegment.frame = CGRectMake(55, 5, 211, 25);
	[typeSegment addTarget:self action:@selector(segmentPress:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //if noFb is set, only show overall scores
    if(noFb)
    {
        typeSegment.selectedSegmentIndex = 1;
        [typeSegment setEnabled:NO forSegmentAtIndex:0];
        scores = overallScores;
    }
    
    //default to the fb scores segment
    else
    {
        scores=fbScores;
        typeSegment.selectedSegmentIndex = 0;
        [typeSegment setEnabled:YES forSegmentAtIndex:0];
    }
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [scores count];
}

//clear out the background from the cells and labels
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    [[cell detailTextLabel] setBackgroundColor:[UIColor clearColor]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = nil;
        cell.contentView.backgroundColor = [UIColor clearColor];
        
    }
    
    //get the score
    NSDictionary * scoreDict = [scores objectAtIndex:indexPath.row];
    
    //set the labels
    cell.textLabel.text = [NSString stringWithFormat:@"%i.  %@",indexPath.row + 1, [scoreDict objectForKey:@"name"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[scoreDict objectForKey:@"score"]];
    
    return cell;
}

#pragma mark headers and footers


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //init the header
    UIView * header = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)]autorelease];
    
    //init a close button
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(5, 5, 25, 25);
    [closeButton setImage:[UIImage imageNamed:@"closebutton.png"] forState: UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:closeButton];
    
    //set up the score board label
    UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(35, 5, 280, 30)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Arial" size:10.0f];
    label.textColor = [UIColor blackColor];
    label.text = @"Social Leader Boards powered by SocialScoresApi.com";
    label.numberOfLines = 1;
    [header addSubview:label];
    
    //show the player's score
    UILabel * scoreLabel = [[[UILabel alloc] initWithFrame:CGRectMake(5, 35, 310, 30)] autorelease];
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize] + 5];
    scoreLabel.textColor = [UIColor blackColor];
    scoreLabel.textAlignment= UITextAlignmentCenter;
    scoreLabel.text = [NSString stringWithFormat:@"Your Score:  %i",playerScore];
    scoreLabel.numberOfLines = 1;
    [header addSubview:scoreLabel];
    if(playerScore <= 0)
    {
        scoreLabel.text = @"";
    }
    
    return header;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footer = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)]autorelease];
    
    //make the facebook share button
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(90, 35, 150, 25);
    [shareButton setImage:[UIImage imageNamed:@"fb_share.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(sharePressed) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:shareButton];
    
    //add the type segment 
    [footer addSubview:typeSegment];

    return footer;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma action methods

//when a user presses a segment, load the scores for that segment type
-(IBAction)segmentPress:(id)sender
{
    UISegmentedControl * seg = (UISegmentedControl*)sender;
    if(seg.selectedSegmentIndex == 1)
    {
        scores  = overallScores;
    }
    else
    {
        scores = fbScores;
    }
    [self.tableView reloadData];
}

//when the fb share is pressed
-(void)sharePressed
{
    //create the facebook attachement
    NSMutableDictionary * attachment = [NSMutableDictionary dictionary];
    [attachment setValue:[NSString stringWithFormat: @"Check out this social scoreboard for: %@", kAppName] forKey:@"name"];
    [attachment setValue:[NSString stringWithFormat:@"Level: %@",levelId] forKey:@"caption"];
    [attachment setValue:kPostLink forKey:@"link"];
    [attachment setValue:kPostImage forKey:@"picture"];
    
    //add a list of scores
    int i = 1;
    NSMutableString * scoresStr = [NSMutableString string];
    for(NSDictionary * scoreDict in scores)
    {
        [scoresStr appendFormat:@"<center> %i.  %@  --  %i</center>",i,[scoreDict objectForKey:@"name"],[[scoreDict objectForKey:@"score"] intValue]];
        i++;
        if(i >10)
            break;
    }
    [attachment setValue:scoresStr forKey:@"description"];

    //call fb to make the post
    MyFBManager *fb= [MyFBManager sharedManager];
    [fb postStoryWithAttachment:attachment toFriend:nil];
    
}

//close the window
-(void)closePressed
{
    [delegate dismissModalViewControllerAnimated:YES];
}

#pragma mark releasing methods

-(void)dealloc
{
    [super dealloc];
    [scores release];
    [delegate release];
    [levelId release];
    [fbScores release];
    [typeSegment release];
    [overallScores release];
}

@end

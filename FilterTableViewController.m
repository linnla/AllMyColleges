//
//  FilterTableViewController.m
//  AllMyColleges
//
//  Created by Laure Linn on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FilterTableViewController.h"
#import "SearchTableViewController.h"
#import "CollegeTableViewController.h"

@implementation FilterTableViewController

@synthesize studentTotalCostSlider, studentTuitionCostSlider, privateCollegeSwitch, religiousCollegeSwitch, liberalArtsCollegeSwitch,publicCollegeSwitch, rankedCollegeSwitch, unrankedCollegeSwitch, matchSwitch, reachSwitch, highProbabilitySwitch, lowProbabilitySwitch, safetySwitch;

@synthesize privateCollege, publicCollege, liberalsArts, ranked, unranked, religious, studentTotalCostS, studentTuitionCostS;
@synthesize reach, match, highProbability, lowProbability, safety, search, parentView;


- (id)initWithStyle:(UITableViewStyle)style fromViewController:(NSString *)viewControllerName
{
    parentView = viewControllerName;
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.tableView.rowHeight = 30;
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    }
    
    //self.navigationItem.titleView = [self mySegmentedControl];
    
    //search = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:nil action:@selector(doneAction)];
    
    //self.navigationItem.rightBarButtonItem = search;
    //self.navigationItem.rightBarButtonItem.enabled=YES;
    //search.enabled = YES;
    //[search release];
    
    return self;
}

static NSArray *segmentChoices = nil;
#define Search @"Search"

- (UISegmentedControl *) mySegmentedControl
{
    if (!segmentChoices) segmentChoices = [[NSArray arrayWithObjects:Search, nil] retain];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentChoices];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setEnabled:YES forSegmentAtIndex:0];
    //[segmentedControl setEnabled:YES forSegmentAtIndex:1];
    
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.momentary = YES;
    segmentedControl.tintColor = [UIColor colorWithRed:.9 green:.1 blue:.1 alpha:1]; 
    [self.view addSubview:segmentedControl];
    [segmentedControl release];
    
    return segmentedControl;
}

- (void)segmentAction:(id)sender {
    
	// the segmented control was clicked, handle it here 
    UISegmentedControl* segCtl = sender;
    
    //[self.navigationController popViewControllerAnimated:NO];
    
    if ([parentView isEqualToString:@"Search"]){
        SearchTableViewController *stvc = [[SearchTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController: stvc animated:YES];
        [stvc release];
    } else {
        CollegeTableViewController *ctvc = [[CollegeTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController: ctvc animated:YES];
        [ctvc release];
    }

    //SearchTableViewController *stvc = [[SearchTableViewController alloc] initWithStyle:UITableViewStylePlain];
    //[self.navigationController pushViewController: stvc animated:YES];
        
        //[UIView beginAnimations:@"filter" context:nil];
        //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //[UIView setAnimationDuration: 0.5];
        //[UIView setAnimationDelay:0.3];
        //[self.navigationController pushViewController: ftvc animated:NO]; 
        //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO]; 
        //[UIView commitAnimations];
        
        //[stvc release];
        
        [segCtl setEnabled:YES forSegmentAtIndex:0];
        //[segCtl setEnabled:YES forSegmentAtIndex:1];
}


- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;


    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ((interfaceOrientation == UIInterfaceOrientationPortrait)|| 
        (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)|| 
        (interfaceOrientation == UIInterfaceOrientationLandscapeRight)|| 
        (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown))
    {
        return YES;    
    }
    
    return NO;    
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
   // [self.navigationController setToolbarHidden:YES animated:NO];  
   // [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.titleView = [self mySegmentedControl];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    /*
    [UIView beginAnimations:@"Back" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationDelay:0.3];
    [UIView setAnimationTransition:UIViewAnimationOptionTransitionNone forView:self.navigationController.view cache:NO]; 
    [UIView commitAnimations]; 
     */
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Table view data source
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case(0): // type
            return 4;
            break;
        case(1): // % chance
            return 5;
            break;
    }
}
    
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        if(section == 0)
            return @"";
        if(section == 1)
            return @"Admissions Chances";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 5.0f;
    
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 45.0f;
    }
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    //static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
   
    if (cell == nil) {
        if (indexPath.section == 0){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        } else if (indexPath.section == 1){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        }
    }
    
    // Set up the cell...
    //cell.textLabel.font = [UIFont systemFontOfSize:16];
    //cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    
    cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    cell.detailTextLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:14];

    UIColor *altCellColor = [UIColor colorWithRed:.612 green:.675 blue:.753 alpha:1];
    cell.backgroundColor = altCellColor;
       
    if (indexPath.section == 0){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch(indexPath.row) {
            case(0): {
                cell.textLabel.text = @"Ranked Colleges";
                
                rankedCollegeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [rankedCollegeSwitch addTarget:self action:@selector(switchChanged:)forControlEvents:UIControlEventValueChanged];
                BOOL showRanked = [defaults boolForKey:@"showRankedColleges"];
                [rankedCollegeSwitch setOn:showRanked];
                
                [cell addSubview:rankedCollegeSwitch];
                cell.accessoryView = rankedCollegeSwitch;
                break;
            }
            case(1): {
                cell.textLabel.text = @"Unranked Colleges";
                
                unrankedCollegeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [unrankedCollegeSwitch addTarget:self action:@selector(switchChanged:)forControlEvents:UIControlEventValueChanged];
                BOOL showUnranked = [defaults boolForKey:@"showUnrankedColleges"];
                [unrankedCollegeSwitch setOn:showUnranked];
                
                [cell addSubview:unrankedCollegeSwitch];
                cell.accessoryView = unrankedCollegeSwitch;
                break;
                }
            case(2): {
                cell.textLabel.text = @"Private Colleges";
                
                privateCollegeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [privateCollegeSwitch addTarget:self action:@selector(switchChanged:)forControlEvents:UIControlEventValueChanged];
                BOOL showPrivate = [defaults boolForKey:@"showPrivateColleges"];
                [privateCollegeSwitch setOn:showPrivate];

                [cell addSubview:privateCollegeSwitch];
                cell.accessoryView = privateCollegeSwitch;
                break;
                }
            case(3): {
                cell.textLabel.text = @"Public Colleges";
                
                publicCollegeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [publicCollegeSwitch addTarget:self action:@selector(switchChanged:)forControlEvents:UIControlEventValueChanged];
                BOOL showPublic = [defaults boolForKey:@"showPublicColleges"];
                [publicCollegeSwitch setOn:showPublic];

                
                [cell addSubview:publicCollegeSwitch];
                cell.accessoryView = publicCollegeSwitch;
                break;
                }
        }
    }
         return cell;
}
     /*           
            case(4): {
                cell.textLabel.text = @"Liberal Arts Colleges";
                
                liberalArtsCollegeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [liberalArtsCollegeSwitch addTarget:self action:@selector(switchChanged:)forControlEvents:UIControlEventValueChanged];
                BOOL showLiberalArts = [defaults boolForKey:@"showLiberalArtsColleges"];
                [liberalArtsCollegeSwitch setOn:showLiberalArts];
                
                [cell addSubview:liberalArtsCollegeSwitch];
                cell.accessoryView = liberalArtsCollegeSwitch;
                break;
                }
            case(5): {
                cell.textLabel.text = @"Religious Colleges";
                
                religiousCollegeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [religiousCollegeSwitch addTarget:self action:@selector(switchChanged:)forControlEvents:UIControlEventValueChanged];
                BOOL showReligious = [defaults boolForKey:@"showReligiousColleges"];
                [religiousCollegeSwitch setOn:showReligious];

                [cell addSubview:religiousCollegeSwitch];
                cell.accessoryView = religiousCollegeSwitch;
                break;
                }
                 
            }
    } else if (indexPath.section == 1){
        if (indexPath.row == 0){
                cell.textLabel.text = @"High Probability Match";
                cell.detailTextLabel.text = @"60% - 74% chance";
                highProbabilitySwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [cell addSubview:highProbabilitySwitch];
                cell.accessoryView = highProbabilitySwitch;
            } else if (indexPath.row == 1){
                cell.textLabel.text = @"Match";
                cell.detailTextLabel.text = @"40% - 59% chance";
                matchSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [cell addSubview:matchSwitch];
                cell.accessoryView = matchSwitch;
             } else if (indexPath.row == 2){               
                cell.textLabel.text = @"Low Probability Match";
                cell.detailTextLabel.text = @"25% - 39% chance";
                lowProbabilitySwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [cell addSubview:lowProbabilitySwitch];
                cell.accessoryView = lowProbabilitySwitch;
            } else if (indexPath.row == 3){    
                cell.textLabel.text = @"Reach";
                cell.detailTextLabel.text = @"< 25% chance";
                reachSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [cell addSubview:reachSwitch];
                cell.accessoryView = reachSwitch;
            } else if (indexPath.row == 4){   
                cell.textLabel.text = @"Safety";
                cell.detailTextLabel.text = @">75% chance";
                safetySwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [cell addSubview:safetySwitch];
                cell.accessoryView = safetySwitch;
            }
    }
    */

- (void)switchChanged:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (sender == rankedCollegeSwitch){

        if (rankedCollegeSwitch.on){
            [defaults setObject:@"YES" forKey:@"showRankedColleges"];
        } else if (!rankedCollegeSwitch.on && !unrankedCollegeSwitch.on) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Either ranked or unranked must be set ON" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        } else {
            [defaults setObject:@"NO" forKey:@"showRankedColleges"];
        }
    }
    
    if (sender == unrankedCollegeSwitch){
        if (unrankedCollegeSwitch.on){
            [defaults setObject:@"YES" forKey:@"showUnrankedColleges"];
        } else if (!rankedCollegeSwitch.on && !unrankedCollegeSwitch.on){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Either ranked or unranked must be set ON" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        } else {
            [defaults setObject:@"NO" forKey:@"showUnrankedColleges"];
        }
    }
    
    if (sender == privateCollegeSwitch){
        
        if (privateCollegeSwitch.on){
            [defaults setObject:@"YES" forKey:@"showPrivateColleges"];
        } else if (!privateCollegeSwitch.on && !publicCollegeSwitch.on) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Either private or public must be set ON" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        } else {
            [defaults setObject:@"NO" forKey:@"showPrivateColleges"];
        }
    }
    
    if (sender == publicCollegeSwitch){
        if (publicCollegeSwitch.on){
            [defaults setObject:@"YES" forKey:@"showPublicColleges"];
        } else if (!publicCollegeSwitch.on && !privateCollegeSwitch.on){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Either private or public must be set ON" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        } else {
            [defaults setObject:@"NO" forKey:@"showPublicColleges"];
        }
    }

    /*
    if (privateCollegeSwitch.on){
        [defaults setObject:@"YES" forKey:@"showPrivateColleges"];
    } else if (!privateCollegeSwitch.on){
        [defaults setObject:@"NO" forKey:@"showPrivateColleges"];
        [defaults setObject:@"YES" forKey:@"showPublicColleges"];
    }

    if (publicCollegeSwitch.on){
        [defaults setObject:@"YES" forKey:@"showPublicColleges"];
    } else if (!publicCollegeSwitch.on){
        [defaults setObject:@"NO" forKey:@"showPublicColleges"];
        [defaults setObject:@"YES" forKey:@"showPrivateColleges"];
    }
     */
    
    if (liberalArtsCollegeSwitch.on){
        [defaults setObject:@"YES" forKey:@"showLiberalArtsColleges"];
    } else if (!liberalArtsCollegeSwitch.on){
        [defaults setObject:@"NO" forKey:@"showLiberalArtsColleges"];
    }
    
    if (religiousCollegeSwitch.on){
        [defaults setObject:@"YES" forKey:@"showReligiousColleges"];
    } else if (!religiousCollegeSwitch.on){
        [defaults setObject:@"NO" forKey:@"showReligiousColleges"];
    }

    [defaults synchronize];
    [self.tableView reloadData];
}
    
@end

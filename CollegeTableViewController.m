//
//  CollegeTableViewController.m
//  AllMyColleges
//
//  Created by Laure Linn on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CollegeTableViewController.h"
#import "AllMyCollegesAppDelegate.h"
#import "College.h"
#import "CollegeDetail.h"
#import "CollegeDetailTableViewController.h"
#import "CoreDataTableViewController.h"
#import "SettingsViewController.h"
#import "FilterTableViewController.h"
#import "EntryViewController.h"


@implementation CollegeTableViewController

@synthesize textDetailString, sortString;
@synthesize predicateString, predicateRankedColleges, predicateUnrankedColleges, predicatePrivateColleges, predicatePublicColleges, predicateLiberalArtsColleges, predicateReligiousColleges;
@synthesize showRankedColleges, showUnrankedColleges, showPrivateColleges, showPublicColleges, showLiberalArtsColleges, showReligiousColleges;
@synthesize savedScrollPosition, backButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    [self readUserDefaults];
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        self.title = @"Back";
        self.tableView.rowHeight = 40;
        self.navigationItem.titleView = [self mySegmentedControl];
    }
    return self;
}

static NSArray *segmentChoices = nil;
#define Sort @"Sort"
#define Filter @"Filter"

- (UISegmentedControl *) mySegmentedControl
{
    if (!segmentChoices) segmentChoices = [[NSArray arrayWithObjects:Sort, Filter, nil] retain];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentChoices];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setEnabled:YES forSegmentAtIndex:0];
    [segmentedControl setEnabled:YES forSegmentAtIndex:1];
    
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.momentary = YES;
    segmentedControl.tintColor = [UIColor colorWithRed:.9 green:.1 blue:.1 alpha:1]; 
    [self.view addSubview:segmentedControl];
    [segmentedControl release];
    
    return segmentedControl;
}

- (void)segmentAction:(id)sender
{
	// the segmented control was clicked, handle it here 
    UISegmentedControl* segCtl = sender;
    NSInteger index = segCtl.selectedSegmentIndex;
    
    if (index == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] 
                                      initWithTitle:@"Sort" 
                                      delegate:self 
                                      cancelButtonTitle:nil 
                                      destructiveButtonTitle:nil 
                                      otherButtonTitles: nil];
        
        [actionSheet addButtonWithTitle:@"Alphabetical"];
        //[actionSheet addButtonWithTitle:@"Cost"];
        //[actionSheet addButtonWithTitle:@"Percent Chance"];
        [actionSheet addButtonWithTitle:@"Rank"];
        [actionSheet addButtonWithTitle:@"State"];
        
        [actionSheet showInView:self.navigationController.view];
        
        [segCtl setEnabled:YES forSegmentAtIndex:0];
        [actionSheet release];
    } else if (index == 1) {
        NSString *parentViewColtroller = @"Calculate";
        FilterTableViewController *ftvc = [[FilterTableViewController alloc] initWithStyle:UITableViewStyleGrouped fromViewController:parentViewColtroller];
        //FilterTableViewController *ftvc = [[FilterTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController: ftvc animated:YES];
        
        //[UIView beginAnimations:@"filter" context:nil];
        //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //[UIView setAnimationDuration: 0.5];
        //[UIView setAnimationDelay:0.3];
        //[self.navigationController pushViewController: ftvc animated:NO]; 
        //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO]; 
        //[UIView commitAnimations];
        
        [ftvc release];
        
        [segCtl setEnabled:YES forSegmentAtIndex:1];
    }
}

- (void)dealloc
{
    // [segmentChoices release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) readUserDefaults {
    
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.sortString = [defaults objectForKey:@"sortField"];
    self.textDetailString = [defaults objectForKey:@"textDetailString"];
    
    if ([self.textDetailString isEqualToString: @"cost"]){
        self.sortString = @"alpha";
        self.textDetailString = @"studentPercent";
        [defaults setObject:@"alpha" forKey:@"sortField"];
        [defaults setObject:@"studentPercent" forKey:@"textDetailString"];
        [defaults synchronize];
    }
    
    showRankedColleges = [defaults objectForKey:@"showRankedColleges"];
    showUnrankedColleges = [defaults objectForKey:@"showUnrankedColleges"];
    showPrivateColleges = [defaults objectForKey:@"showPrivateColleges"];
    showPublicColleges = [defaults objectForKey:@"showPublicColleges"];
    showLiberalArtsColleges = [defaults objectForKey:@"showLiberalArtsColleges"];
    showReligiousColleges = [defaults objectForKey:@"showReligiousColleges"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    backButton = [[UIBarButtonItem alloc] 
                  initWithTitle:@"Back" 
                  style:UIBarButtonItemStylePlain 
                  target:self 
                  action:@selector(backButtonClicked:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    [backButton release];
}

- (void) backButtonClicked:(id)sender {
    SettingsViewController *svc = [[SettingsViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
    [svc release];
}

- (void) fetchColleges
{
    self.fetchedResultsController = nil;
    [NSFetchedResultsController deleteCacheWithName:@"cost"];
    [NSFetchedResultsController deleteCacheWithName:@"alpha"];
    [NSFetchedResultsController deleteCacheWithName:@"rank"];
    [NSFetchedResultsController deleteCacheWithName:@"state"];
    
    [self readUserDefaults];
    
    // Get the managedObjectContext
    NSManagedObjectContext *managedObjectContext = [(AllMyCollegesAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"College" inManagedObjectContext:managedObjectContext];
    
    // Mutually exclusive, return nothing
    if (showPrivateColleges == @"NO" && showPublicColleges == @"NO"){
        predicateString = [NSPredicate predicateWithFormat:
                           @"privateCollege == %@ AND publicCollege == %@", showPrivateColleges, showPublicColleges];
    }
    
    // Mutually exclusive, return nothing
    if (showRankedColleges == @"NO" && showUnrankedColleges == @"NO"){
        predicateString = [NSPredicate predicateWithFormat:
                           @"ranked == %@ AND unranked == %@", showRankedColleges, showUnrankedColleges];
    }
    
    
    // Return everything
    if (showPrivateColleges == @"YES" && showPublicColleges == @"YES"){
        if (showRankedColleges == @"YES" && showUnrankedColleges == @"YES"){
            predicateString = [NSPredicate predicateWithFormat:
                               @"(privateCollege == %@ OR publicCollege == %@) AND (ranked == %@ OR unranked == %@)", showPrivateColleges, showPublicColleges, showRankedColleges, showUnrankedColleges];
        }
    }
    
    // Return subset
    if (showPrivateColleges == @"YES" && showPublicColleges == @"YES"){
        if (showRankedColleges != showUnrankedColleges){
            predicateString = [NSPredicate predicateWithFormat:
                               @"ranked == %@", showRankedColleges];
        }
    }
    
    // Return subset
    if (showRankedColleges == @"YES" && showUnrankedColleges == @"YES"){
        if (showPrivateColleges != showPublicColleges){
            predicateString = [NSPredicate predicateWithFormat:
                               @"privateCollege == %@", showPrivateColleges];
        }
    }
    
    // Return subset
    if (showRankedColleges != showUnrankedColleges){
        if (showPrivateColleges != showPublicColleges){
            predicateString = [NSPredicate predicateWithFormat:
                               @"privateCollege == %@  AND ranked == %@", showPrivateColleges, showRankedColleges];        
        }
    }
    
    if (sortString == @"cost"){  
        NSSortDescriptor *sortDescriptor1 = [[[NSSortDescriptor alloc] initWithKey:@"studentTotalCostCategory" 
                                                                         ascending:YES
                                                                          selector:@selector(compare:)]autorelease];
        
        NSSortDescriptor *sortDescriptor2 = [[[NSSortDescriptor alloc] initWithKey:@"studentTotalCostS" 
                                                                         ascending:YES
                                                                          selector:@selector(compare:)]autorelease];
        
        
        request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil]; 
        
        request.predicate = predicateString;
        //request.predicate = nil;
        request.fetchBatchSize = 50;
        
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:request
                                           managedObjectContext:managedObjectContext
                                           sectionNameKeyPath:@"studentTotalCostCategory"
                                           //sectionNameKeyPath:nil
                                           cacheName:nil];
                                         //cacheName:@"cost"];
        //[sortDescriptor1 release];
        //[sortDescriptor2 release];
        [request release];
        self.fetchedResultsController = frc;
        [frc release];
        
        self.titleKey = @"collegeName";
        self.searchKey = nil;
        self.detailedLabelTextKey = @"studentPercent";
        
    } else if (sortString == @"rank"){ 
        NSSortDescriptor *sortDescriptor1 = [[[NSSortDescriptor alloc] initWithKey:@"usNewsRank" 
                                                                         ascending:YES
                                                                          selector:@selector(compare:)]autorelease];
        
        request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, nil]; 
        request.predicate = predicateString;
        request.fetchBatchSize = 50;
        
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:request
                                           managedObjectContext:managedObjectContext
                                           sectionNameKeyPath:nil
                                           cacheName:nil];
                                         //cacheName:@"rank"];
        //[sortDescriptor1 release];
        //[sortDescriptor2 release];
        [request release];
        self.fetchedResultsController = frc;
        [frc release];

        
        self.titleKey = @"collegeNameWithRank";
        self.searchKey = nil;
        self.detailedLabelTextKey = @"studentPercent";
        
    } else if (sortString == @"state"){
        NSSortDescriptor *sortDescriptor1 = [[[NSSortDescriptor alloc] initWithKey:@"state" 
                                                                         ascending:YES
                                                                          selector:@selector(compare:)]autorelease];
        
        NSSortDescriptor *sortDescriptor2 = [[[NSSortDescriptor alloc] initWithKey:@"collegeName" 
                                                                         ascending:YES
                                                                          selector:@selector(compare:)]autorelease];  
        
        request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil];
        //request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, nil];
        
        request.predicate = predicateString;
        request.fetchBatchSize = 50;
        
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:request
                                           managedObjectContext:managedObjectContext
                                           sectionNameKeyPath:@"state"
                                           //sectionNameKeyPath:nil
                                           cacheName:nil];
                                         //cacheName:@"alpha"];
        //[sortDescriptor1 release];
        //[sortDescriptor2 release];
        [request release];
        self.fetchedResultsController = frc;
        [frc release];
        
        self.titleKey = @"collegeName";
        self.searchKey = nil;
        self.detailedLabelTextKey = @"studentPercent";
        
    } else if (sortString == @"alpha"){
        NSSortDescriptor *sortDescriptor1 = [[[NSSortDescriptor alloc] initWithKey:@"collegeName" 
                                                                         ascending:YES
                                                                          selector:@selector(compare:)]autorelease];
        
        //NSSortDescriptor *sortDescriptor2 = [[[NSSortDescriptor alloc] initWithKey:@"collegeName" 
        //                                                               ascending:YES
        //                                                              selector:@selector(compare:)]autorelease];    
        
        //request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil];
        request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, nil];
        
        request.predicate = predicateString;
        request.fetchBatchSize = 50;
        
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:request
                                           managedObjectContext:managedObjectContext
                                           sectionNameKeyPath:@"firstLetterOfName"
                                           //sectionNameKeyPath:nil
                                           cacheName:nil];
                                         //cacheName:@"alpha"];
        //[sortDescriptor1 release];
        //[sortDescriptor2 release];
        [request release];
        self.fetchedResultsController = frc;
        [frc release];
        
        self.titleKey = @"collegeName";
        self.searchKey = nil;
        self.detailedLabelTextKey = @"studentPercent"; 
    } else if (sortString == @"percent"){
       // NSSortDescriptor *sortDescriptor1 = [[[NSSortDescriptor alloc] initWithKey:@"studentCollegeCategory" 
         //                                                                ascending:YES
           //                                                               selector:@selector(compare:)]autorelease];
        
        NSSortDescriptor *sortDescriptor1 = [[[NSSortDescriptor alloc] initWithKey:@"studentOdds" 
                                                                         ascending:NO] autorelease];
                                                                      //selector:@selector(compare:)]autorelease];    
        
        //request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil];
        request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, nil];
        
        request.predicate = predicateString;
        request.fetchBatchSize = 50;
        
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:request
                                           managedObjectContext:managedObjectContext
                                           //sectionNameKeyPath:@"StudentCollegeCategory"
                                           sectionNameKeyPath:nil
                                           cacheName:nil];
        //cacheName:@"alpha"];
        //[sortDescriptor1 release];
        //[sortDescriptor2 release];
        [request release];
        self.fetchedResultsController = frc;
        [frc release];
        
        self.titleKey = @"collegeName";
        self.searchKey = nil;
        self.detailedLabelTextKey = @"studentPercent"; 
    }

    return;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([sortString isEqualToString: @"alpha"] || [sortString isEqualToString: @"state"]){
        id  sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
        NSString *rawName = [sectionInfo name];
        
        // This splits a name like "1|Medium Box" into an array like:
        //  [ "1", "Medium Box" ]
        NSArray *components = [rawName componentsSeparatedByString:@"|"];
        
        return [components objectAtIndex:0];
    } else if ([sortString isEqualToString:@"cost"]){
        id  sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
        NSString *rawName = [sectionInfo name];
        
        // This splits a name like "1|Medium Box" into an array like:
        //  [ "1", "Medium Box" ]
        NSArray *components = [rawName componentsSeparatedByString:@"|"];
        
        return [components objectAtIndex:1]; 
    } else if ([sortString isEqualToString: @"rank"]){
        return @"Rank / College / Percent Chance";
    } else if ([sortString isEqualToString: @"percent"]){
        return @"College / Percent Chance";
    } else {
        return @"";
    }
}


//Sample code taken from NSFetchedResultsController Class Reference --- this only works on grouped tableviews
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[self fetchedResultsControllerForTableView:tableView] sectionIndexTitles];
}

//Sample code taken from NSFetchedResultsController Class Reference
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	return [[self fetchedResultsControllerForTableView:tableView] sectionForSectionIndexTitle:title atIndex:index];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
    cell.detailTextLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:13];
    
    if (indexPath.row == 0 || indexPath.row% 2 == 0)
    {
        //UIColor *altCellColor = [UIColor clearColor];
        //UIColor *altCellColor = [UIColor lightGrayColor];
        UIColor *altCellColor = [UIColor colorWithRed:.612 green:.675 blue:.753 alpha:1];
        //UIColor *altCellColor = [UIColor colorWithRed:.471 green:.553 blue:.659 alpha:1];
        cell.backgroundColor = altCellColor;
    } else {
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //cell.backgroundColor = [UIColor clearColor];
    }
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
    
    //[self.navigationController setToolbarHidden:YES animated:NO];  
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (buttonIndex == 0) {
        [defaults setObject:@"alpha" forKey:@"sortField"];
        [defaults setObject:@"studentPercent" forKey:@"textDetailString"];
    //} else if (buttonIndex == 1) {
      //  [defaults setObject:@"percent" forKey:@"sortField"];
      //  [defaults setObject:@"studentPercent" forKey:@"textDetailString"];
    } else if (buttonIndex == 1) {
        [defaults setObject:@"rank" forKey:@"sortField"];
        [defaults setObject:@"studentPercent" forKey:@"textDetailString"];
    } else if (buttonIndex == 2) {
        [defaults setObject:@"state" forKey:@"sortField"];
        [defaults setObject:@"studentPercent" forKey:@"textDetailString"];
    } 
    
    [defaults synchronize];
    [self fetchColleges];
} 

- (void) filterButtonClicked
{
    return;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fetchColleges];
    [self.tableView setContentOffset:savedScrollPosition animated:NO];
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

/* Rotates second half of orientation change, not smooth enough for tableview
 - (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation 
 duration:(NSTimeInterval)duration {
 UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
 }
 */

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.tableView reloadData];
    //(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:10]; 
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

#pragma mark - Table view data source

- (void)managedObjectSelected:(NSManagedObject *)managedObject
{
    
    savedScrollPosition = [self.tableView contentOffset];
    
    College *college = (College *)managedObject;
    CollegeDetailTableViewController *cdtvc = [[CollegeDetailTableViewController alloc] initWithCollegeDetail:college];
    [self.navigationController pushViewController: cdtvc animated:YES]; 
    
    //[UIView beginAnimations:@"EntryButtonToCalculate" context:nil];
    //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //[UIView setAnimationDuration: 0.5];
    //[UIView setAnimationDelay:0.3];
    //[self.navigationController pushViewController: cdtvc animated:NO]; 
    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO]; 
    //[UIView commitAnimations];
    
    [cdtvc release];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForManagedObject:(NSManagedObject *)managedObject
{
    static NSString *ReuseIdentifier = @"CollegeTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    
    if (sortString != @"cost"){
        UITableViewCellStyle cellStyle = UITableViewCellStyleValue1;
        cell = [[[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:ReuseIdentifier] autorelease];
    } else {
        UITableViewCellStyle cellStyle = UITableViewCellStyleValue1;
        cell = [[[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:ReuseIdentifier] autorelease];
    }
    
    if (self.titleKey){
        cell.textLabel.text = [managedObject valueForKey:self.titleKey];
    }
    
    if (self.detailedLabelTextKey == @"studentPercent" || self.detailedLabelTextKey == @"city"){
        cell.detailTextLabel.text = [managedObject valueForKey:self.detailedLabelTextKey];
    } else if (self.detailedLabelTextKey == @"totalCostOutOfStateS" || self.detailedLabelTextKey == @"studentTotalCostS"){
        cell.detailTextLabel.text = [self formatStringToCurrency:[managedObject valueForKey:self.detailedLabelTextKey]];
    } else if (self.detailedLabelTextKey == @"usNewsRank"){
        cell.detailTextLabel.text = [[managedObject valueForKey:self.detailedLabelTextKey] stringValue];
    } else {
        cell.detailTextLabel.text = [managedObject valueForKey:self.detailedLabelTextKey];
    }
    
    cell.accessoryType = [self accessoryTypeForManagedObject:managedObject];
	UIImage *thumbnail = [self thumbnailImageForManagedObject:managedObject];
	if (thumbnail) cell.imageView.image = thumbnail;
    
    cell.detailTextLabel.textColor =  [UIColor blackColor];
    cell.textLabel.textColor =  [UIColor blackColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

// Formats a NSString number to a NSString number with currency format. Example 55555 to $55,555
- (NSString *) formatStringToCurrency:(NSString *)sourceString 
{
    int sourceLength = [sourceString length];
    NSString *firstOne = nil;
    NSString *firstTwo = nil;
    NSString *lastThree = nil;
    NSString *sourceFormatted = nil;
    
    switch (sourceLength) 
    {
        case 5:
            firstTwo = [sourceString substringToIndex:2];
            lastThree = [sourceString substringFromIndex:2];
            sourceFormatted = [[[@"$" stringByAppendingString:firstTwo] stringByAppendingString:@","]stringByAppendingString:lastThree]; 
            break;
            
        case 4:
            firstOne = [sourceString substringToIndex:1];
            lastThree = [sourceString substringFromIndex:1];
            sourceFormatted = [[[@"$" stringByAppendingString:firstOne] stringByAppendingString:@","]stringByAppendingString:lastThree]; 
            break;
            
        case 3:
            sourceFormatted = [@"$" stringByAppendingString:sourceString];
            break;
            
        default:
            sourceFormatted = @"Not Reported";
    }
    
    return sourceFormatted;
}


@end

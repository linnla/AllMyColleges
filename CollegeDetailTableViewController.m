//
//  CollegeDetailTableViewController.m
//  AllMyColleges
//
//  Created by Laure Linn on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CollegeDetailTableViewController.h"

@implementation CollegeDetailTableViewController

- (id) initWithCollegeDetail:(College *)college
{
	if (self == [super initWithStyle:UITableViewStyleGrouped])
	{
		NSManagedObjectContext *managedObjectContext = college.managedObjectContext;
        
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		request.entity = [NSEntityDescription entityForName:@"CollegeDetail" inManagedObjectContext:managedObjectContext];
		
        NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"group" ascending:YES];
        NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"fieldSortOrder" ascending:YES];
        
        request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil];
        
        request.predicate = [NSPredicate predicateWithFormat:@"college = %@", college];
		request.fetchBatchSize = 20;
		
		[NSFetchedResultsController deleteCacheWithName:@"MyCollegeDetailCache"];
		NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:request
                                           managedObjectContext:managedObjectContext
                                           //sectionNameKeyPath:nil
                                           sectionNameKeyPath:@"group"
                                           cacheName:@"MyCollegeDetailCache"];
                                           //cacheName:nil];
        
		//[sortDescriptor1 release];
        //[sortDescriptor2 release];
        [request release];
		
		self.fetchedResultsController = frc;
		[frc release];
		
		self.titleKey = @"field";
        self.detailedLabelTextKey = @"value";
    }
	return self;
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
    self.tableView.rowHeight = 35;
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


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /*
    [UIView beginAnimations:@"Back" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationDelay:0.3];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO]; 
    [UIView commitAnimations]; 
     */
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    cell.detailTextLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //cell.detailTextLabel.textColor = [UIColor redColor];
    
    // Creates alterating colors for tableViews
    /*if (indexPath.row == 0 || indexPath.row% 2 == 0)
    {
        //UIColor *altCellColor = [UIColor colorWithWhite:.7 alpha:.1];
        UIColor *altCellColor = [UIColor colorWithRed:.8 green:.8 blue:1 alpha:1];
        cell.backgroundColor = altCellColor;
    } else {
        cell.backgroundColor = [UIColor clearColor];
    }
     */
}

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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForManagedObject:(NSManagedObject *)managedObject
{
    static NSString *ReuseIdentifier = @"CollegeDetailTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (cell == nil) {
		
        //Default code that has been commented out to experiment with changing UITableViewCellStyleValue1
        //UITableViewCellStyle cellStyle = self.subtitleKey ? UITableViewCellStyleSubtitle : UITableViewCellStyleDefault;
        UITableViewCellStyle cellStyle = self.subtitleKey ? UITableViewCellStyleSubtitle : UITableViewCellStyleValue1;
        
        //UITableViewCellStyle cellStyle = self.subtitleKey ? UITableViewCellStyleSubtitle : UITableViewCellStyleDefault;
        
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:ReuseIdentifier] autorelease];
        
        cell = [[[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:ReuseIdentifier] autorelease];
    }
	
	if (self.titleKey) cell.textLabel.text = [managedObject valueForKey:self.titleKey];
	if (self.detailedLabelTextKey) cell.detailTextLabel.text = [managedObject valueForKey:self.detailedLabelTextKey];
    //cell.accessoryType = [self accessoryTypeForManagedObject:managedObject];
	UIImage *thumbnail = [self thumbnailImageForManagedObject:managedObject];
	if (thumbnail) cell.imageView.image = thumbnail;
	
	return cell;
}

 // Allows groups to be sorted in table view 
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
 {
 id  sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
 NSString *rawName = [sectionInfo name];
 
 // This splits a name like "1|Medium Box" into an array like:
 //  [ "1", "Medium Box" ]
 NSArray *components = [rawName componentsSeparatedByString:@"|"];
 
 return [components objectAtIndex:1];
 }
 
#pragma mark - Table view delegate


@end

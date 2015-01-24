//
//  StudentTableViewController.m
//  AllMyColleges
//
//  Created by Laure Linn on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StudentTableViewController.h"
#import "AllMyCollegesAppDelegate.h"

@implementation StudentTableViewController

@synthesize textDetailLabel;

- (id) initInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    if (self == [super initWithStyle:UITableViewStyleGrouped]){
        self.title = @"Settings";
		UIImage* anImage = [UIImage imageNamed:@"122-stats.png"];
        UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:anImage tag:0];
        self.tabBarItem = theItem;
        [theItem release];
    }
    return self;
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
}
      
    
- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self fetch];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void) fetch
{
    
    // Get the managedObjectContext
    NSManagedObjectContext *managedObjectContext = [(AllMyCollegesAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"CollegeDetail" inManagedObjectContext:managedObjectContext];
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"group" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"fieldSortOrder" ascending:YES];
    
    request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil];
    
    request.predicate = nil;
    request.fetchBatchSize = 20;
    
    [NSFetchedResultsController deleteCacheWithName:@"MyCollegeDetailCache"];
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                       initWithFetchRequest:request
                                       managedObjectContext:managedObjectContext
                                       //sectionNameKeyPath:nil
                                       sectionNameKeyPath:@"group"
                                       cacheName:@"MyCollegeDetailCache"];
    
    [sortDescriptor1 release];
    [sortDescriptor2 release];
    [request release];
    
    self.fetchedResultsController = frc;
    [frc release];
    
    self.titleKey = @"field";
    self.detailedLabelTextKey = @"value";
    
    return;
}

#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForManagedObject:(NSManagedObject *)managedObject
{
    static NSString *ReuseIdentifier = @"StudentTableViewCell";
    
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


@end

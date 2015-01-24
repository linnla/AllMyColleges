//
//  AllMyCollegesAppDelegate.m
//  AllMyColleges
//
//  Created by Laure Linn on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AllMyCollegesAppDelegate.h"
#import "CollegeTableViewController.h"
#import "CalculateOverall.h"
#import "Student.h"
#import "SettingsTableViewController.h"
#import "EntryViewController.h"
#import "SearchTableViewController.h"

@implementation AllMyCollegesAppDelegate

@synthesize window=_window;
@synthesize tabBarController;
@synthesize navigationController;

@synthesize managedObjectContext=__managedObjectContext;

@synthesize managedObjectModel=__managedObjectModel;

@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"YES" forKey:@"showRankedColleges"];
    [defaults setObject:@"YES" forKey:@"showUnrankedColleges"];
    [defaults setObject:@"YES" forKey:@"showPrivateColleges"];
    [defaults setObject:@"YES" forKey:@"showPublicColleges"];
    [defaults setObject:@"YES" forKey:@"showLiberalArtsColleges"];
    [defaults setObject:@"YES" forKey:@"showReligiousColleges"];
    
    [defaults setObject:@"rank" forKey:@"sortField"];
    [defaults setObject:@"cityState" forKey:@"textDetailString"];
    [defaults setObject:nil forKey:@"predicateString"];
    
    [defaults synchronize];

    // Override point for customization after application launch.
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    // Load the data
    //[DataLoad loadCSVFileinManagedObjectContext:managedObjectContext];
    
    //tabBarController = [[UITabBarController alloc] init];
    
    UINavigationController *navcon = [[UINavigationController alloc] init];
    navcon.navigationBar.tintColor = [UIColor blackColor];
    EntryViewController *evc = [[EntryViewController alloc] init];
    [navcon pushViewController:evc animated:NO];
    [evc release];
    
    /* Tab Bar controller code
    //CollegeTableViewController *ctvc = [[CollegeTableViewController alloc] initInManagedObjectContext:managedObjectContext];
    //[navcon1 pushViewController:ctvc animated:NO];
    //UINavigationController *navcon2 = [[UINavigationController alloc] init];
    //SettingsTableViewController *stvc = [[SettingsTableViewController alloc] init];
    //[navcon1 pushViewController:stvc animated:NO];
    //NSArray *controllers = [NSArray arrayWithObjects:navcon1, navcon2, nil];
    //tabBarController.viewControllers = controllers;
    // Add the tab bar controller's current view as a subview of the window
     */
    
    [self.window addSubview:navcon.view];
    
    //[self presentModalViewController:evc animated:YES];
    
    //[self.window addSubview:evc.view];
    [self.window makeKeyAndVisible];
     
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)dealloc
{
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [super dealloc];
}

- (void)awakeFromNib
{
    /*
     Typically you should set up the Core Data stack here, usually by passing the managed object context to the first view controller.
     self.<#View controller#>.managedObjectContext = self.managedObjectContext;
    */
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
        NSLog(@"__managedObjectContext Found: %@",__managedObjectContext);
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setUndoManager:nil];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
        NSLog(@"__managedObjectContext NotFound: %@",__managedObjectContext);
    }
    //NSLog(@"__managedObjectContext Returned: %@",__managedObjectContext);
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
         //NSLog(@"__managedObjectModel Found: %@",__managedObjectModel);
        return __managedObjectModel;
    }
    //NSLog(@"__managedObjectModel NotFound: %@",__managedObjectModel);
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AllMyColleges" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
     //NSLog(@"__managedObjectModel Returned: %@",__managedObjectModel);
    //NSLog(@"modelURL: %@",modelURL);
    
    return __managedObjectModel;
}


 // Use this one for mobile device builds
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator ;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"AllMyColleges.sqlite"];
    
    NSString *storePath = [[NSBundle mainBundle] pathForResource:@"AllMyColleges" ofType:@"sqlite"];
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"AllMyColleges.sqlite"]; 
    
    NSLog(@"store URL %@", storeURL);
    
    // Comment for mobile device build --- creates store incompatible errors
    //[[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
    
    // Uncomment for mobile device build
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:writableDBPath]) {
        NSLog(@"proceda aqui");
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"AllMyColleges" ofType:@"sqlite"];
        NSLog(@"no existe todavia");
        NSLog(@"defalultStorePath %@", defaultStorePath);
        
        
        if (defaultStorePath) {
            [fileManager copyItemAtPath:defaultStorePath toPath:writableDBPath error:NULL];
            NSLog(@"storePath= %@", storePath);
        }
    }    
    
    // MOBILE BUILD NOTES
    // Delete DB, NSFilesManager... (below)
    // Perform lightweight migration, [NSDictionary... (below)
    // Should build empty db
    // Recompile for simulator and load the data
    // Comment dataload code
    // Recompile for mobile device
    // if data still doesn't appear in mobile app, delete the sqlite file from the app bundle and the re-add 

    // Uncomment for mobile device build --- for lightweight migration
    //[[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
   
    // Uncomment for mobile device build --- for lightweight migration
    // Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
    [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

/*
// Use this when lightweight migration is required... otherwise use method above
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        //NSLog(@"__persistentStoreCoordinator Found: %@",__persistentStoreCoordinator);
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"AllMyColleges.sqlite"];
    NSLog(@"storeURL: %@",storeURL);
    
    // If you encounter schema incompatibility errors during development, you can reduce their frequency by:
    // Simply deleting the existing store:
   [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
    
    // Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
    [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];

    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSLog(@"__persistentStoreCoordinator Created: %@",__persistentStoreCoordinator);
    
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
         NSLog(@"__persistentStoreCoordinator NotCreated: %@",__persistentStoreCoordinator);
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}
*/

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end

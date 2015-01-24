//
//  Student.m
//  AllMyColleges
//
//  Created by Laure Linn on 10/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Student.h"

@implementation Student
@dynamic group;
@dynamic field;
@dynamic value;
@dynamic fieldSortOrder;

+ (void) loadStudentSettingsInManagedObjectContext:managedObjectContext
{
    // delete all managed objects before data load.
    NSFetchRequest *fetchCollege = [[[NSFetchRequest alloc] init] autorelease];
    [fetchCollege setEntity:[NSEntityDescription entityForName:@"Student" inManagedObjectContext:managedObjectContext]];
    NSArray *resultsCollege = [managedObjectContext executeFetchRequest:fetchCollege error:nil];
    for (id basket in resultsCollege)
        [managedObjectContext deleteObject:basket];
    
    NSMutableArray *detailFieldsToLoad = [NSMutableArray arrayWithObjects:@"GPA",@"Class Rank",@"SAT",@"ACT",@"Home State",nil];
    
    for (NSString *afieldToLoad in detailFieldsToLoad){

        Student *theStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:managedObjectContext];
        
        if (afieldToLoad == @"GPA") {
            theStudent.field = @"GPA";
            theStudent.fieldSortOrder = @"2";
            theStudent.group = @"2| ";
        } else if (afieldToLoad == @"Class Rank"){
            theStudent.field = @"Class Rank";
            theStudent.fieldSortOrder = @"1";
            theStudent.group = @"2| ";
        } else if (afieldToLoad == @"SAT"){
            theStudent.field = @"SAT";
            theStudent.fieldSortOrder = @"1";
            theStudent.group = @"3|Test Scores";
        } else if (afieldToLoad == @"ACT"){
            theStudent.field = @"ACT";
            theStudent.fieldSortOrder = @"2";
            theStudent.group = @"3|Test Scores";    
        } else if (afieldToLoad == @"Home State"){
            theStudent.field = @"Home State";
            theStudent.fieldSortOrder = @"1";
            theStudent.group = @"1| ";
        }

        // Save the data 
        NSError *error = nil;
        if (![managedObjectContext save:&error]){
            NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
            NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
        
            if(detailedErrors != nil && [detailedErrors count] > 0) {
                for(NSError* detailedError in detailedErrors) {
                    NSLog(@"  DetailedError: %@", [detailedError userInfo]);
                }
            }
        } else {
            NSLog(@": %@",theStudent.field);
            NSLog(@": %@",theStudent.fieldSortOrder);
            NSLog(@": %@",theStudent.group);
            
            NSLog(@"Saved");
        } 

    }
}

@end

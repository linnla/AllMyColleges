//
//  CollegeDetailTableViewController.h
//  AllMyColleges
//
//  Created by Laure Linn on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "College.h"


@interface CollegeDetailTableViewController : CoreDataTableViewController{
    
}

- (id) initWithCollegeDetail:(College *)college;

@end

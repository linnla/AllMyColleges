//
//  StudentTableViewController.h
//  AllMyColleges
//
//  Created by Laure Linn on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"


@interface StudentTableViewController : CoreDataTableViewController {
    
}

@property (nonatomic, retain) NSString *textDetailLabel;
- (void) fetch;

@end

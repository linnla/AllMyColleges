//
//  CollegeTableViewController.h
//  AllMyColleges
//
//  Created by Laure Linn on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"


@interface CollegeTableViewController : CoreDataTableViewController {
   
}

@property (nonatomic, retain) NSString *textDetailString;
@property (nonatomic, retain) NSString *sortString;

@property (nonatomic, retain) NSPredicate *predicateString;
@property (nonatomic, retain) NSPredicate *predicateRankedColleges;
@property (nonatomic, retain) NSPredicate *predicateUnrankedColleges;
@property (nonatomic, retain) NSPredicate *predicatePrivateColleges;
@property (nonatomic, retain) NSPredicate *predicatePublicColleges;
@property (nonatomic, retain) NSPredicate *predicateLiberalArtsColleges;
@property (nonatomic, retain) NSPredicate *predicateReligiousColleges;

@property (nonatomic, retain) NSString *showRankedColleges;
@property (nonatomic, retain) NSString *showUnrankedColleges;
@property (nonatomic, retain) NSString *showPrivateColleges;
@property (nonatomic, retain) NSString *showPublicColleges;
@property (nonatomic, retain) NSString *showLiberalArtsColleges;
@property (nonatomic, retain) NSString *showReligiousColleges;

@property (assign) CGPoint savedScrollPosition;
@property (nonatomic, retain) UIBarButtonItem *backButton;

- (UISegmentedControl *) mySegmentedControl;
- (NSString *) formatStringToCurrency:(NSString *)sourceString;
- (void) readUserDefaults;
- (void) fetchColleges;

- (IBAction) segmentAction:(id)sender;
- (IBAction) backButtonClicked:(id)sender;

@end

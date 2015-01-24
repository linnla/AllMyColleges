//
//  FilterTableViewController.h
//  AllMyColleges
//
//  Created by Laure Linn on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FilterTableViewController : UITableViewController {
  
}

//@property (nonatomic, retain) NSArray *states;
//@property (nonatomic, retain) NSArray *regions;

@property (nonatomic, retain) UISlider *studentTotalCostSlider;
@property (nonatomic, retain) UISlider *studentTuitionCostSlider;

@property (nonatomic, retain) UISwitch *privateCollegeSwitch;
@property (nonatomic, retain) UISwitch *religiousCollegeSwitch;
@property (nonatomic, retain) UISwitch *liberalArtsCollegeSwitch;
@property (nonatomic, retain) UISwitch *publicCollegeSwitch;
@property (nonatomic, retain) UISwitch *rankedCollegeSwitch;
@property (nonatomic, retain) UISwitch *unrankedCollegeSwitch;
@property (nonatomic, retain) UISwitch *matchSwitch;
@property (nonatomic, retain) UISwitch *reachSwitch;
@property (nonatomic, retain) UISwitch *highProbabilitySwitch;
@property (nonatomic, retain) UISwitch *lowProbabilitySwitch;
@property (nonatomic, retain) UISwitch *safetySwitch;

@property (nonatomic, retain) NSString *privateCollege;
@property (nonatomic, retain) NSString *publicCollege;
@property (nonatomic, retain) NSString *liberalsArts;
@property (nonatomic, retain) NSString *ranked;
@property (nonatomic, retain) NSString *unranked;
@property (nonatomic, retain) NSString *religious;

@property (nonatomic, retain) NSNumber *studentTotalCostS;
@property (nonatomic, retain) NSNumber *studentTuitionCostS;

@property (nonatomic, retain) NSString *reach;
@property (nonatomic, retain) NSString *match;
@property (nonatomic, retain) NSString *highProbability;
@property (nonatomic, retain) NSString *lowProbability;
@property (nonatomic, retain) NSString *safety;

@property (nonatomic, retain) NSString *CellIdentifier0;
@property (nonatomic, retain) NSString *CellIdentifier1;

@property (nonatomic, retain) UIBarButtonItem *search;
@property (nonatomic, retain) NSString *parentView;


- (void) doneAction;
- (UISegmentedControl *) mySegmentedControl;
- (id)initWithStyle:(UITableViewStyle)style fromViewController:(NSString *)viewControllerName;

@end


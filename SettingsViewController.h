//
//  SettingsViewController.h
//  AdmissionsAdvisor
//
//  Created by Laure Linn on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CA>

@interface SettingsViewController : UIViewController 
{
    IBOutlet UITextField *homeState;
    IBOutlet UITextField *gpa;
    IBOutlet UITextField *classRank;
    IBOutlet UITextField *satReading;
    IBOutlet UITextField *satMath;
    IBOutlet UITextField *satWriting;
    IBOutlet UITextField *actComposite;
    IBOutlet UITextField *actEnglish;
    IBOutlet UITextField *actMath;
    IBOutlet UITextField *actWriting;
    IBOutlet UIButton *findMyColleges;
    
    
    CGFloat     animatedDistance;
}

@property (nonatomic, retain) IBOutlet UITextField *homeState;
@property (nonatomic, retain) IBOutlet UITextField *gpa;
@property (nonatomic, retain) IBOutlet UITextField *classRank;
@property (nonatomic, retain) IBOutlet UITextField *satReading;
@property (nonatomic, retain) IBOutlet UITextField *satMath;
@property (nonatomic, retain) IBOutlet UITextField *satWriting;
@property (nonatomic, retain) IBOutlet UITextField *actComposite;
@property (nonatomic, retain) IBOutlet UITextField *actEnglish;
@property (nonatomic, retain) IBOutlet UITextField *actMath;
@property (nonatomic, retain) IBOutlet UITextField *actWriting;

@property (nonatomic, retain) IBOutlet UIButton *findMyColleges;
@property (nonatomic, retain) IBOutlet UIButton *calculateMyChances;

@property (nonatomic, retain) NSArray *statesArray;
@property (nonatomic, retain) NSArray *statesAbbArray;
@property (nonatomic, retain) NSArray *classRankArray;
@property (nonatomic, retain) NSArray *classRankAbbArray;
@property (nonatomic, retain) NSArray *classRankAbbNumArray;
@property (nonatomic, retain) NSArray *gpaArray;
@property (nonatomic, retain) NSArray *satArray;
@property (nonatomic, retain) NSArray *actArray;

@property (nonatomic, retain) UIPickerView *statesPicker;
@property (nonatomic, retain) UIPickerView *classRankPicker;
@property (nonatomic, retain) UIPickerView *gpaPicker;
@property (nonatomic, retain) UIPickerView *satReadingPicker;
@property (nonatomic, retain) UIPickerView *satMathPicker;
@property (nonatomic, retain) UIPickerView *satWritingPicker;

@property (nonatomic, retain) UIPickerView *actEnglishPicker;
@property (nonatomic, retain) UIPickerView *actMathPicker;
@property (nonatomic, retain) UIPickerView *actWritingPicker;
@property (nonatomic, retain) UIPickerView *actCompositePicker;
@property (nonatomic, retain) UIActivityIndicatorView *loading;

@property (nonatomic, retain) NSString *homeStateLong;
@property (nonatomic, retain) UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIBarButtonItem *backButton;

@property (nonatomic, retain) NSString *activeHomeState;
@property (nonatomic, retain) NSString *activeGPA;
@property (nonatomic, retain) NSString *activeClassRank;
@property (nonatomic, retain) NSString *activeSATReading;
@property (nonatomic, retain) NSString *activeSATMath;
@property (nonatomic, retain) NSString *activeSATWriting;
@property (nonatomic, retain) NSString *activeACTComposite;
@property (nonatomic, retain) NSString *activeACTEnglish;
@property (nonatomic, retain) NSString *activeACTMath;
@property (nonatomic, retain) NSString *activeACTWriting;

- (IBAction) findColleges:(id)sender;
- (IBAction) textFieldReturn:(id)sender;
- (IBAction) dismissKeyboard:(id)sender;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;
- (void) textFieldDidChange:(UITextField *)textField;
- (IBAction) calculateMyChancesAction:(id)sender;
- (void) doneButtonClicked:(id)sender;
- (IBAction) backButtonClicked:(id)sender;

- (void) calculate;
- (void) readUserDefaults;


@end

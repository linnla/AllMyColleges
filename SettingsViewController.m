//
//  SettingsViewController.m
//  AdmissionsAdvisor
//
//  Created by Laure Linn on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "CollegeTableViewController.h"
#import "AllMyCollegesAppDelegate.h"
#import "CalculateSAT.h"
#import "CalculateGPA.h"
#import "CalculateACT.h"
#import "CalculateOverall.h"
#import "SearchTableViewController.h"
#import "EntryViewController.h"


@implementation SettingsViewController

@synthesize satReading, satMath, actComposite, findMyColleges, homeState, gpa, classRank, satWriting, actEnglish, actMath, actWriting, activeACTComposite, activeACTEnglish, activeACTMath, activeACTWriting, activeClassRank, activeGPA, activeHomeState, activeSATMath, activeSATReading, activeSATWriting;

@synthesize statesArray, classRankArray, gpaArray, satArray, actArray, statesAbbArray, classRankAbbArray, classRankAbbNumArray;

@synthesize statesPicker, classRankPicker, gpaPicker, satReadingPicker, satMathPicker, satWritingPicker, actEnglishPicker, actMathPicker, actWritingPicker, actCompositePicker;
@synthesize calculateMyChances, loading, homeStateLong, doneButton, backButton;

// This code is required to handle the scrolling when tabbing through input fields
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
//static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 140;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    //calculateMyChances.hidden = YES;
    
    [satReading addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [satMath addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [satWriting addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [homeState addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [gpa addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [classRank addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
      
        
    self.statesArray = [NSArray arrayWithObjects: @"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California",@"Colorado",@"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"Washington DC", @"West Virginia", @"Wisconsin", @"Wyoming", nil];
    
    self.statesAbbArray = [NSArray arrayWithObjects: @"AL", @"AK", @"AZ", @"AR", @"CA",@"CO",@"CT", @"DE", @"FL", @"GA", @"HI", @"ID", @"IL", @"IN", @"IA", @"KS", @"KY", @"LA", @"ME", @"MD", @"MA", @"MI", @"MN", @"MS", @"MO", @"MT", @"NE", @"NV", @"NH", @"NJ", @"NM", @"NY", @"NC", @"ND", @"OH", @"OK", @"OR", @"PA", @"RI", @"SC", @"SD", @"TN", @"TX", @"UT", @"VT", @"VA", @"WA", @"DC", @"WV", @"WI", @"WY", nil];
    
    self.classRankArray = [NSArray arrayWithObjects: @"Valedictorian", @"Top 10%", @"11% - 25%", @"26% - 50%", @"51% - 100%", nil];
    
    self.classRankAbbArray = [NSArray arrayWithObjects: @"1%", @"10%", @"25%", @"50%", @"100%", nil];
    self.classRankAbbNumArray = [NSArray arrayWithObjects: @"1", @"10", @"25", @"50", @"100", nil];
    
    self.gpaArray = [NSArray arrayWithObjects: @"4.0", @"3.9", @"3.8", @"3.7", @"3.6", @"3.5", @"3.4", @"3.3", @"3.2", @"3.1", @"3.0", @"2.9", @"2.8", @"2.7", @"2.6", @"2.5", @"2.4", @"2.3", @"2.2", @"2.1", @"2.0",nil];
    
    self.satArray = [NSArray arrayWithObjects: @"800", @"790", @"780", @"770", @"760", @"750", @"740", @"730", @"720", @"710", @"700", @"690", @"680", @"670", @"660", @"650", @"640", @"630", @"620", @"610", @"600", @"590", @"580", @"570", @"560", @"550", @"540", @"530", @"520", @"510", @"500", @"490", @"480", @"470", @"460", @"450", @"440", @"430", @"420", @"410", @"400", @"390", @"380", @"370", @"360", @"350", @"340", @"330", @"320", @"310", @"300", @"290", @"280", @"270", @"260", @"250", @"240", @"230", @"220", @"210", @"200", nil];

    self.actArray = [NSArray arrayWithObjects: @"36", @"35", @"34", @"33", @"32", @"31", @"30", @"29", @"28", @"27", @"26", @"25", @"24", @"23", @"22", @"21", @"20", @"19", @"18", @"17", @"16", @"15", @"14", @"13", @"12", @"11", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", @"1", nil];
    
    doneButton = [[UIBarButtonItem alloc] 
                  initWithTitle:@"Done" 
                  style:UIBarButtonItemStylePlain 
                  target:self 
                  action:@selector(doneButtonClicked:)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
    
    backButton = [[UIBarButtonItem alloc] 
                  initWithTitle:@"Back" 
                  style:UIBarButtonItemStylePlain 
                  target:self 
                  action:@selector(backButtonClicked:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
    
    [[self view] setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    
    [[self view] setAutoresizingMask: UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth];
    
    [[self view] setAutoresizesSubviews:TRUE];
}

- (void) readUserDefaults {
    
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    activeHomeState = [defaults objectForKey:@"activeHomeState"];
    activeGPA = [defaults objectForKey:@"activeGPA"];
    activeClassRank = [defaults objectForKey:@"activeClassRank"];
    activeSATReading = [defaults objectForKey:@"activeSATReading"];
    activeSATMath = [defaults objectForKey:@"activeSATMath"];
    activeSATWriting = [defaults objectForKey:@"activeSATWriting"];
    activeACTComposite = [defaults objectForKey:@"activeACTComposite"];
    activeACTEnglish = [defaults objectForKey:@"activeACTEnglish"];
    activeACTMath = [defaults objectForKey:@"activeACTMath"];
    activeACTWriting = [defaults objectForKey:@"activeACTWriting"];
    
    homeState.text = activeHomeState;
    gpa.text = activeGPA;
    classRank.text = activeClassRank;
    satReading.text = activeSATReading;
    satMath.text = activeSATMath;
    satWriting.text = activeSATWriting;
    actMath.text = activeACTMath;
    actEnglish.text = activeACTEnglish;
    actComposite.text = activeACTComposite;
    actWriting.text = activeACTWriting;
}

- (void) backButtonClicked:(id)sender {
    EntryViewController *evc = [[EntryViewController alloc] init];
    [self.navigationController pushViewController:evc animated:YES];
    
    //[UIView beginAnimations:@"EntryButtonToSearch" context:nil];
    //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //[UIView setAnimationDuration: 0.5];
    //[UIView setAnimationDelay:0.3];
    //[self.navigationController pushViewController: evc animated:NO]; 
    //[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.navigationController.view cache:NO]; 
    //[UIView commitAnimations];
    
    [evc release];
}

- (void) doneButtonClicked:(id)sender {
    [homeState becomeFirstResponder];
	[homeState resignFirstResponder];
    [gpa becomeFirstResponder];
	[gpa resignFirstResponder];
    [classRank becomeFirstResponder];
	[classRank resignFirstResponder];
    
    [satReading becomeFirstResponder];
    [satReading resignFirstResponder];
    [satMath becomeFirstResponder];
	[satMath resignFirstResponder];
    [satWriting becomeFirstResponder];
	[satWriting resignFirstResponder];
    
    [actEnglish becomeFirstResponder];
    [actEnglish resignFirstResponder];
    [actMath becomeFirstResponder];
	[actMath resignFirstResponder];
    [actWriting becomeFirstResponder];
	[actWriting resignFirstResponder];
    [actComposite becomeFirstResponder];
	[actComposite resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self readUserDefaults];
    calculateMyChances.enabled = YES;
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

-(void)showActivityIndicator {
	CGRect frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
	self.loading = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    [self.loading startAnimating];
	[self.loading sizeToFit];
	loading.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
								UIViewAutoresizingFlexibleRightMargin |
								UIViewAutoresizingFlexibleTopMargin |
								UIViewAutoresizingFlexibleBottomMargin);
	
	// initing the bar button
	UIBarButtonItem *loadingView = [[UIBarButtonItem alloc] initWithCustomView:loading];
	
	//[loading release];
	loadingView.target = self;
	
	self.navigationItem.rightBarButtonItem = loadingView;
}


- (IBAction)calculateMyChancesAction:(id)sender {
    // Hides keyboard if findColleges is pressed before textFieldDidEndEditing or keyboardDismissed executes
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:homeState.text forKey:@"activeHomeState"];
    [defaults setObject:gpa.text forKey:@"activeGPA"];
    [defaults setObject:classRank.text forKey:@"activeClassRank"];
    [defaults setObject:satReading.text forKey:@"activeSATReading"];
    [defaults setObject:satMath.text forKey:@"activeSATMath"];
    [defaults setObject:satWriting.text forKey:@"activeSATWriting"];
    [defaults setObject:actEnglish.text forKey:@"activeACTEnglish"];
    [defaults setObject:actMath.text forKey:@"activeACTMath"];
    [defaults setObject:actWriting.text forKey:@"activeACTWriting"];
    [defaults setObject:actComposite.text forKey:@"activeACTComposite"];
        
    [defaults synchronize];
   
    calculateMyChances.enabled = NO;
    
    [self dismissKeyboard:sender];
    
    int satReadingAsNumber;
    satReadingAsNumber = [satReading.text intValue];
    int satMathAsNumber;
    satMathAsNumber = [satMath.text intValue];
    int satWritingAsNumber;
    satWritingAsNumber = [satWriting.text intValue];
    
    int actWritingAsNumber;
    actWritingAsNumber = [actWriting.text intValue];
    int actMathAsNumber;
    actMathAsNumber = [actMath.text intValue];
    int actEnglishAsNumber;
    actEnglishAsNumber = [actEnglish.text intValue];
    int actCompositeAsNumber;
    actCompositeAsNumber = [actComposite.text intValue];
    
    if (satReadingAsNumber > 0 && satMathAsNumber > 0 && satWritingAsNumber > 0){
        [self showActivityIndicator];
        [self performSelectorInBackground:@selector(calculate) withObject:nil];
    } else if (actCompositeAsNumber > 0 && actEnglishAsNumber > 0 && actMathAsNumber > 0 && actWritingAsNumber > 0){
        [self showActivityIndicator];
        [self performSelectorInBackground:@selector(calculate) withObject:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Input SAT or ACT scores to calculate" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        calculateMyChances.enabled = YES;
    }
}
    
- (void)calculate {

    // To ensure viewController is not getting loaded twice
    if (self.navigationController.topViewController != self)
    {       
        return;
    }
    
    int satReadingPercentile = 0;
    int satMathPercentile = 0;
    int satWritingPercentile = 0;
    int actEnglishPercentile = 0;
    int actMathPercentile = 0;
    int actWritingPercentile = 0;
    int actCompositePercentile = 0;
    int gpaPercentile = 0;
    int classRankPercentile = 0;
    int overallPercentile = 0;
    
    satReadingPercentile = [CalculateSAT ConvertSatToPercentileForSubject:@"Reading" Score:[satReading.text intValue]];
    NSLog(@"satReadingPercentile is: %i", satReadingPercentile);
    
    satMathPercentile = [CalculateSAT ConvertSatToPercentileForSubject:@"Math" Score:[satMath.text intValue]];
    NSLog(@"satMathPercentile is: %i", satMathPercentile);
    
    satWritingPercentile = [CalculateSAT ConvertSatToPercentileForSubject:@"Writing" Score:[satWriting.text intValue]];
    NSLog(@"satWritingPercentile is: %i", satWritingPercentile);
    
    actEnglishPercentile = [CalculateACT ConvertActToPercentileForSubject:@"English" Score:[actEnglish.text intValue]];
    NSLog(@"actEnglishPercentile is: %i", actEnglishPercentile);
    
    actMathPercentile = [CalculateACT ConvertActToPercentileForSubject:@"Math" Score:[actMath.text intValue]];
    NSLog(@"actMathPercentile is: %i", actMathPercentile);
    
    actWritingPercentile = [CalculateACT ConvertActToPercentileForSubject:@"Writing" Score:[actWriting.text intValue]];
    NSLog(@"actWritingPercentile is: %i", actWritingPercentile);
    
    actCompositePercentile = [CalculateACT ConvertActToPercentileForSubject:@"Composite" Score:[actComposite.text intValue]];
    NSLog(@"actCompositePercentile is: %i", actCompositePercentile);
    
    float gpaAsFloat =  100 * [gpa.text floatValue];
    int gpaAsInt =  (int)roundf(gpaAsFloat); 
    
    gpaPercentile = [CalculateGPA ConvertGpaToPercentile:gpaAsInt]; 
    NSLog(@"gpaPercentile is: %i", gpaPercentile);
    
    NSLog(@"classRank.text: %@", classRank.text);
   
    if ([classRank.text isEqualToString: @"1%"]){
        classRankPercentile = 99;
    } else if ([classRank.text isEqualToString: @"10%"]){
        classRankPercentile = 90;
    } else if ([classRank.text isEqualToString: @"25%"]){
        classRankPercentile = 75;
    } else if ([classRank.text isEqualToString: @"50%"]){
        classRankPercentile = 50;
    } else if ([classRank.text isEqualToString: @"100%"]){
        classRankPercentile = 25;
    } 
    
    NSLog(@"classRankPercentile is: %i", classRankPercentile);
    
    overallPercentile = [CalculateOverall CalculateOverallPercentileUsingSatReadingPercentile:(int)satReadingPercentile
                                                           satMathPercentile:(int)satMathPercentile
                                                        satWritingPercentile:(int)satWritingPercentile
                                                           actMathPercentile:(int)actMathPercentile
                                                        actWritingPercentile:(int)actWritingPercentile
                                                        actEnglishPercentile:(int)actEnglishPercentile
                                                      actCompositePercentile:(int)actCompositePercentile
                                                               gpaPercentile:(int)gpaPercentile 
                                                         classRankPercentile:(int)classRankPercentile];
                         
    NSLog(@"overallPercentile is: %i", overallPercentile);

    NSString *percentCategory = [CalculateOverall ConvertOverallPercentileToPercentCategory:overallPercentile];
    NSLog(@"percentCategory is: %@", percentCategory);
    
    [CalculateOverall UpdatePublicCollegesInHomeState:percentCategory homeState:homeStateLong];
    [CalculateOverall UpdatePublicCollegesNotInHomeState:percentCategory homeState:homeStateLong];
    [CalculateOverall UpdatePrivateColleges:percentCategory];
    
    NSManagedObjectContext *managedObjectContext = [(AllMyCollegesAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    [loading stopAnimating];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"percent" forKey:@"sortString"];
    [defaults synchronize];
    
    CollegeTableViewController *ctvc = [[CollegeTableViewController alloc] init];
    //[self.navigationController pushViewController: ctvc animated:NO]; 
    
    [UIView beginAnimations:@"SettingsButtonToCTVC" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationDelay:0.3];
    [self.navigationController pushViewController: ctvc animated:NO]; 
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO]; 
    [UIView commitAnimations];
}

// Data validation of SAT and ACT scores --- this method executes after every key press
-(void) textFieldDidChange:(UITextField *)textField 
{

}

// Handles "return" key press
- (IBAction) textFieldReturn:(id)sender
{
	[sender resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// Dismiss keyboard if user touchs outside the field -- turn off keyboard 
- (IBAction) dismissKeyboard:(id)sender
{
	[satReadingPicker removeFromSuperview];
    
    [homeState becomeFirstResponder];
	[homeState resignFirstResponder];
    [gpa becomeFirstResponder];
	[gpa resignFirstResponder];
    [classRank becomeFirstResponder];
	[classRank resignFirstResponder];
    
    [satReading becomeFirstResponder];
    [satReading resignFirstResponder];
    [satMath becomeFirstResponder];
	[satMath resignFirstResponder];
    [satWriting becomeFirstResponder];
	[satWriting resignFirstResponder];
    
    [actEnglish becomeFirstResponder];
    [actEnglish resignFirstResponder];
    [actMath becomeFirstResponder];
	[actMath resignFirstResponder];
    [actWriting becomeFirstResponder];
	[actWriting resignFirstResponder];
    [actComposite becomeFirstResponder];
	[actComposite resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField 
{
    // Get the rects (bounds) of the text field being edited and the view that we're going to scroll. Convert everything to window coordinates
	CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
	CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
	
    // Calculate the fraction between the top and bottom of the middle section for the text field's midline:
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
	CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
	CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
	CGFloat heightFraction = numerator / denominator;
	
    // Clamp this fraction so that the top section is all "0.0" and the bottom section is all "1.0".
    if (heightFraction < 0.0)
	{
		heightFraction = 0.0;
	}
	else if (heightFraction > 1.0)
	{
		heightFraction = 1.0;
	}
	
    // Take this fraction and convert it into an amount to scroll by multiplying by the keyboard height for the current screen orientation. Calls to floor so that we only scroll by whole pixel amounts.
    UIInterfaceOrientation orientation =
	[[UIApplication sharedApplication] statusBarOrientation];
	if (orientation == UIInterfaceOrientationPortrait ||
		orientation == UIInterfaceOrientationPortraitUpsideDown)
	{
		animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
	}
	else
	{
		animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
	}
	
    if(textField == homeState){
        
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown) 
            statesPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 216, 320, 216)];
        else statesPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 162, 320, 162)]; 
        
        statesPicker.delegate = self;
        statesPicker.showsSelectionIndicator = YES;
        
        [statesPicker selectRow:5 inComponent:0 animated:NO]; 
        // Moves picker to current value
        [statesPicker selectRow:[self.statesAbbArray indexOfObject:homeState.text] inComponent:0 animated:FALSE];
        
        homeState.inputView = statesPicker;
    } else if(textField == classRank){
        
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown) 
            classRankPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 216, 320, 216)];
        else classRankPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 162, 320, 162)];
        
        classRankPicker.delegate = self;
        classRankPicker.showsSelectionIndicator = YES;
        
        [classRankPicker selectRow:2 inComponent:0 animated:NO];
        // Moves picker to current value
        [classRankPicker selectRow:[self.classRankAbbArray indexOfObject:classRank.text] inComponent:0 animated:FALSE];
        
        classRank.inputView = classRankPicker;
    } else if(textField == gpa){
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown) 
            gpaPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 216, 320, 216)];
        else gpaPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 162, 320, 162)]; 
        
        gpaPicker.delegate = self;
        
        [gpaPicker selectRow:5 inComponent:0 animated:NO];
        // Moves picker to current value
        [gpaPicker selectRow:[self.gpaArray indexOfObject:gpa.text] inComponent:0 animated:FALSE];
        
        gpaPicker.showsSelectionIndicator = YES;
        gpa.inputView = gpaPicker;
    } else if(textField == satReading){
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown) 
            satReadingPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 216, 320, 216)];
        else satReadingPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 162, 320, 162)];
        
        satReadingPicker.delegate = self;
        
        [satReadingPicker selectRow:20 inComponent:0 animated:NO];
        // Moves picker to current value
        [satReadingPicker selectRow:[self.satArray indexOfObject:satReading.text] inComponent:0 animated:FALSE];
        
        satReadingPicker.showsSelectionIndicator = YES;
        satReading.inputView = satReadingPicker;
    } else if(textField == satMath){
        // Comment to bring up keyboard
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown) 
            satMathPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 216, 320, 216)];
        else satMathPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 162, 320, 162)];
       
        satMathPicker.delegate = self;
       
        [satMathPicker selectRow:20 inComponent:0 animated:NO];
        // Moves picker to current value
        [satMathPicker selectRow:[self.satArray indexOfObject:satMath.text] inComponent:0 animated:FALSE];

        satMathPicker.showsSelectionIndicator = YES;
        satMath.inputView = satMathPicker;
    } else if(textField == satWriting){
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown) 
            satWritingPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 216, 320, 216)];
        else satWritingPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 162, 320, 162)];
        
        satWritingPicker.delegate = self;
        
        [satWritingPicker selectRow:20 inComponent:0 animated:NO];
        // Moves picker to current value
        [satWritingPicker selectRow:[self.satArray indexOfObject:satWriting.text] inComponent:0 animated:FALSE];

        
        satWritingPicker.showsSelectionIndicator = YES;
        satWriting.inputView = satWritingPicker;
    
    } else if (textField == actEnglish){
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown) 
            actEnglishPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 216, 320, 216)];
        else actEnglishPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 162, 320, 162)];
        
        actEnglishPicker.delegate = self;
        
        [actEnglishPicker selectRow:10 inComponent:0 animated:NO];
        // Moves picker to current value
        [actEnglishPicker selectRow:[self.actArray indexOfObject:actEnglish.text] inComponent:0 animated:FALSE];
        
        
        actEnglishPicker.showsSelectionIndicator = YES;
        actEnglish.inputView = actEnglishPicker;

    } else if (textField == actMath){
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown) 
            actMathPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 216, 320, 216)];
        else actMathPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 162, 320, 162)];
        
        actMathPicker.delegate = self;
        
        [actMathPicker selectRow:10 inComponent:0 animated:NO];
        // Moves picker to current value
        [actMathPicker selectRow:[self.actArray indexOfObject:actMath.text] inComponent:0 animated:FALSE];
        
        actMathPicker.showsSelectionIndicator = YES;
        actMath.inputView = actMathPicker;
        
    } else if(textField == actWriting){
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown) 
            actWritingPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 216, 320, 216)];
        else actWritingPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 162, 320, 162)];
        
        actWritingPicker.delegate = self;
        
        [actWritingPicker selectRow:10 inComponent:0 animated:NO];
        // Moves picker to current value
        [actWritingPicker selectRow:[self.actArray indexOfObject:actWriting.text] inComponent:0 animated:FALSE];
        
        actWritingPicker.showsSelectionIndicator = YES;
        actWriting.inputView = actWritingPicker;
        
    } else if(textField == actComposite){
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown) 
            actCompositePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 216, 320, 216)];
        else actCompositePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 162, 320, 162)];
        
        actCompositePicker.delegate = self;
        
        [actCompositePicker selectRow:10 inComponent:0 animated:NO];
        // Moves picker to current value
        [actCompositePicker selectRow:[self.actArray indexOfObject:actComposite.text] inComponent:0 animated:FALSE];
        
        actCompositePicker.showsSelectionIndicator = YES;
        actComposite.inputView = actCompositePicker;
    }

    // Apply the animation - setAnimationBeginsFromCurrentState: — this will allow a smooth transition to new text field if the user taps on another.
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}


- (void)textFieldDidEndEditing:(UITextField *)textField 
{
    CGRect viewFrame = self.view.frame;
	viewFrame.origin.y += animatedDistance;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	[self.view setFrame:viewFrame];
 	[UIView commitAnimations];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   
    if (pickerView == self.statesPicker) {
        NSInteger row = [statesPicker selectedRowInComponent:0];
        homeState.text = [statesAbbArray objectAtIndex:row];
        homeStateLong = [statesArray objectAtIndex:row];
    } else if (pickerView == self.classRankPicker) {
        classRank.text = [self.classRankAbbArray objectAtIndex:row];
    } else if (pickerView == self.gpaPicker) {
        gpa.text = [self.gpaArray objectAtIndex:row];
    } else if (pickerView == self.satReadingPicker) {
        satReading.text = [self.satArray objectAtIndex:row];
    } else if (pickerView == self.satMathPicker) {
        satMath.text = [self.satArray objectAtIndex:row];
    } else if (pickerView == self.satWritingPicker) {
        satWriting.text = [self.satArray objectAtIndex:row];
    } else if (pickerView == self.actEnglishPicker) {
        actEnglish.text = [self.actArray objectAtIndex:row];
    } else if (pickerView == self.actMathPicker) {
        actMath.text = [self.actArray objectAtIndex:row];
    } else if (pickerView == self.actWritingPicker) {
        actWriting.text = [self.actArray objectAtIndex:row];
    } else if (pickerView == self.actCompositePicker) {
        actComposite.text = [self.actArray objectAtIndex:row];
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if (thePickerView == self.statesPicker) {
        return [statesArray count];
        
    } else if (thePickerView == self.classRankPicker) {
        return [classRankArray count];
        
    } else if (thePickerView == self.gpaPicker) {
        return [gpaArray count];
    
    } else if ((thePickerView == self.satReadingPicker) || (thePickerView == self.satMathPicker) || (thePickerView == self.satWritingPicker)){
        return [satArray count];
    
    } else if ((thePickerView == self.actEnglishPicker) || (thePickerView == self.actMathPicker) || (thePickerView == self.actWritingPicker) || (thePickerView == self.actCompositePicker)){
        return [actArray count];
    }
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (thePickerView == self.statesPicker) {
        return [statesArray objectAtIndex:row];
        
    } else if (thePickerView == self.classRankPicker) {
        return [classRankArray objectAtIndex:row];
        
    } else if (thePickerView == self.gpaPicker) {
        return [gpaArray objectAtIndex:row];
        
    } else if ((thePickerView == self.satReadingPicker) || (thePickerView == self.satMathPicker) || (thePickerView == self.satWritingPicker)){
        return [satArray objectAtIndex:row];
        
    } else if ((thePickerView == self.actEnglishPicker) || (thePickerView == self.actMathPicker) || (thePickerView == self.actWritingPicker) || (thePickerView == self.actCompositePicker)){
        return [actArray objectAtIndex:row];
    }
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    return sectionWidth;
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


@end


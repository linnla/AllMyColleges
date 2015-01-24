//
//  DataLoad.m
//  AllMyColleges
//
//  Created by Laure Linn on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataLoad.h"
#import "College.h"
#import "CollegeDetail.h"

/*
 @interface DataLoad ()
+ (void) loadCSVFileinManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@end
*/

@implementation DataLoad

/*
-(void)dataRequestCompleted:(id)responseData
{
    NSError* error;
    NSDictionary* res = [NSJSONSerialization JSONObjectWithData:responseData
                                                        options:kNilOptions
                                                          error:&error];
    NSMutableArray *myResults = [[NSMutableArray alloc] init];;
    NSArray *results = (NSArray*)[res objectForKey:@"colleges"];
    
    for (NSDictionary *result in results)self.
    {
        College *collegeData = [[College alloc] init];
        collegeData.title = [result objectForKey:@"title"];
        collegeData.city = [result objectForKey:@"city"];
        
        [myResults addObject:collegeData];
    }
    
    self.colleges = [NSArray arrayWithArray:myResults];
    
    [self.collegeTableListView reloadData];
}
*/


+ (void) loadCSVFileinManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
    
    NSError* error;
    NSString* myFile = [[NSBundle mainBundle]pathForResource:@"MasterData" ofType:@"csv"];
    NSString* stringOfColleges = [NSString stringWithContentsOfFile:myFile encoding:NSUTF8StringEncoding error: &error];
    
    NSLog(@"Start");
    
    // If file <> --- ADD
    // delete all managed objects before data load.
    NSFetchRequest *fetchCollege = [[NSFetchRequest alloc] init];
    [fetchCollege setEntity:[NSEntityDescription entityForName:@"College" inManagedObjectContext:managedObjectContext]];
    NSArray *resultsCollege = [managedObjectContext executeFetchRequest:fetchCollege error:nil];
    for (id basket in resultsCollege)
        [managedObjectContext deleteObject:basket];

    
    // Load csv file.
    
     //NSString *stringOfColleges = [[[NSString alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"MasterData" ofType: @"csv"]];
    
    NSArray *statesArray = [NSArray arrayWithObjects: @"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California",@"Colorado",@"Connecticut", @"Delaware", @"District of Columbia", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"Washington DC", @"West Virginia", @"Wisconsin", @"Wyoming", nil];
    
    NSArray *statesAbbArray = [NSArray arrayWithObjects: @"AL", @"AK", @"AZ", @"AR", @"CA",@"CO",@"CT", @"DE", @"DC", @"FL", @"GA", @"HI", @"ID", @"IL", @"IN", @"IA", @"KS", @"KY", @"LA", @"ME", @"MD", @"MA", @"MI", @"MN", @"MS", @"MO", @"MT", @"NE", @"NV", @"NH", @"NJ", @"NM", @"NY", @"NC", @"ND", @"OH", @"OK", @"OR", @"PA", @"RI", @"SC", @"SD", @"TN", @"TX", @"UT", @"VT", @"VA", @"WA", @"DC", @"WV", @"WI", @"WY", nil];
    
    // Add code here for file not found error
    
    // For debug purposes only -- this shows the contents of the csv file
    //NSLog(@"%@", stringOfColleges);
    
    // csv file columns.
    //NSString *endOfLineMarker;
    NSString *collegeNumber;
    NSString *webAddress;
    NSString *laureRank;
    NSString *usNewsRank;
    NSString *forbesRank;
    NSString *ranked;
    NSString *collegeNameOriginal;
    NSString *collegeName;
    NSString *artDesign;
    NSString *music;
    NSString *liberalArts;
    NSString *military;
    NSString *privateCollege;
    NSString *religious;
    NSString *longitude;
    NSString *latitude;
    NSString *city;
    NSString *zipcode;
    NSString *state;
    NSString *region;
    NSString *openAdmissionPolicy;
    NSString *gpa;
    NSString *classRank;
    NSString *schoolRecords;
    NSString *collegePrep;
    NSString *recommendations;
    NSString *formalDemonstrationOfCompetencies;
    NSString *admissionTestScores;
    NSString *toefl;
    NSString *totalCostInStateOnCampus;
    NSString *totalCostOutOfStateOnCampus;
    NSString *tuitionInStateFullTime;
    NSString *tuitionOutOfStateFullTime;
    NSString *applicantsTotal;
    NSString *admissionsTotal;
    NSString *enrolledTotal;
    NSString *percentAdmitted;
    NSString *admissionsYield;
    NSString *percentAA;
    NSString *percentA;
    NSString *percentB;
    NSString *percentC;
    NSString *percentD;
    NSString *percentE;
    NSString *percentF;
    NSString *percentG;
    NSString *percentH;
    NSString *percentI;
    NSString *percentJ;
    NSString *adjustedSATCategory;
    NSString *satRead25Category;
    NSString *satRead75Category;
    NSString *satMath25Category;
    NSString *satMath75Category;
    NSString *adjustedSAT;
    NSString *totalIqr;
    NSString *totalStdev;
    NSString *satRead25;
    NSString *satRead75;
    NSString *satMath25;
    NSString *satMath75;
    NSString *satWrite25;
    NSString *satWrite75;
    NSString *actComposite25;
    NSString *actComposite75;
    NSString *actEnglish25;
    NSString *actEnglish75;
    NSString *actMath25;
    NSString *actMath75;
    NSString *actWrite25;
    NSString *actWrite75;
    NSString *rank;
    NSString *leadingSpaces;
    
    // setup scanner.
    NSScanner *theScanner = [NSScanner scannerWithString:stringOfColleges];
    
    //[self.stringOfColleges];
    NSString *separatorString = @",";
    NSCharacterSet *newLineSet;
    newLineSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    // For testing purposes only, to load partial data
    int i=0;
    for (i = 0; i < 20; i++)
        
    // start scanner loo
    while ([theScanner isAtEnd] == NO) 
    {
        // Scan cvs file.
        [theScanner scanUpToString:separatorString intoString:&collegeNumber];
        //NSLog(@"collegeNumber: %@",collegeNumber);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&webAddress];
        //NSLog(@"webAddress: %@",webAddress);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&laureRank];
        //NSLog(@"laureRank: %@",laureRank);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&usNewsRank];
        //NSLog(@"usNewsRank: %@",usNewsRank);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&forbesRank];
        //NSLog(@"forbesRank: %@",forbesRank);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&ranked];
        //NSLog(@"ranked: %@",ranked);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&collegeNameOriginal];
        //NSLog(@"collegeNameOriginal: %@",collegeNameOriginal);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&collegeName];
        NSLog(@"collegeName: %@",collegeName);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&artDesign];
        //NSLog(@"artDesign: %@",artDesign);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&music];
        //NSLog(@"music: %@",music);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&liberalArts];
        //NSLog(@"liberalArts: %@",liberalArts);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&military];
        //NSLog(@"military: %@",military);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&privateCollege];
        //NSLog(@"private:%@",privateCollege);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&religious];
        //NSLog(@"religious: %@",religious);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&longitude];
        //NSLog(@"longitude: %@",longitude);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&latitude];
        //NSLog(@"latitude: %@",latitude);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&city];
        //NSLog(@"city: %@",city);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&zipcode];
        //NSLog(@"zipcode: %@",zipcode);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&state];
        //NSLog(@"state: %@",state);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&region];
        //NSLog(@"region: %@",region);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&openAdmissionPolicy];
        //NSLog(@"openAdmissionPolicy: %@",openAdmissionPolicy);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&gpa];
        //NSLog(@"gpa: %@",gpa);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&classRank];
        //NSLog(@"classRank: %@",classRank);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&schoolRecords];
        //NSLog(@"schoolRecords: %@",schoolRecords);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&collegePrep];
        //NSLog(@"collegePrep: %@",collegePrep);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&recommendations];
        //NSLog(@"recommendations: %@",recommendations);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&formalDemonstrationOfCompetencies];
        //NSLog(@"formalDemonstrationOfCompetencies: %@",formalDemonstrationOfCompetencies);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&admissionTestScores];
        //NSLog(@"admissionTestScores: %@",admissionTestScores);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&toefl];
        //NSLog(@"toefl: %@",toefl);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&totalCostInStateOnCampus];
        //NSLog(@"totalCostInStateOnCampus: %@",totalCostInStateOnCampus);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&totalCostOutOfStateOnCampus];
        //NSLog(@"totalCostOutOfStateOnCampus: %@",totalCostOutOfStateOnCampus);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&tuitionInStateFullTime];
        //NSLog(@"tuitionInStateFullTime: %@",tuitionInStateFullTime);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&tuitionOutOfStateFullTime];
        //NSLog(@"tuitionOutOfStateFullTime: %@",tuitionOutOfStateFullTime);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&applicantsTotal];
        //NSLog(@"applicantsTotal: %@",applicantsTotal);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&admissionsTotal];
        //NSLog(@"admissionsTotal: %@",admissionsTotal);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&enrolledTotal];
        //NSLog(@"enrolledTotal: %@",enrolledTotal);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&percentAdmitted];
        //NSLog(@"percentAdmitted: %@",percentAdmitted);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&admissionsYield];
        //NSLog(@"admissionsYield:%@",admissionsYield);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&percentAA];
        //NSLog(@"percentAA: %@",percentAA);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&percentA];
        //NSLog(@"percentA: %@",percentA);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&percentB];
        //NSLog(@"percentB: %@",percentB);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&percentC];
        //NSLog(@"percentC: %@",percentC);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&percentD];
        //NSLog(@"percentD: %@",percentD);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&percentE];
        //NSLog(@"percentE: %@",percentE);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&percentF];
        //NSLog(@"percentF: %@",percentF);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&percentG];
        //NSLog(@"percentG: %@",percentG);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&percentH];
        //NSLog(@"percentH: %@",percentH);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&percentI];
        //NSLog(@"percentI: %@",percentI);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&percentJ];
        //NSLog(@"percentJ: %@",percentJ);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&adjustedSATCategory];
        //NSLog(@"adjustedSATCategory: %@",adjustedSATCategory);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&satRead25Category];
        //NSLog(@"satRead25Category: %@",satRead25Category);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&satRead75Category];
        //NSLog(@"satRead75Category: %@",satRead75Category);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&satMath25Category];
        //NSLog(@"satMath25Category: %@",satMath25Category);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&satMath75Category];
        //NSLog(@"satMath75Category: %@",satMath75Category);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&adjustedSAT];
        //NSLog(@"adjustedSAT: %@",adjustedSAT);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&totalIqr];
        //NSLog(@"totalIqr: %@",totalIqr);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&totalStdev];
        //NSLog(@"totalStdev: %@",totalStdev);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&satRead25];
        //NSLog(@"satRead25: %@",satRead25);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&satRead75];
        //NSLog(@"satRead75: %@",satRead75);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&satMath25];
        //NSLog(@"satMath25: %@",satMath25);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&satMath75];
        //NSLog(@"satMath75: %@",satMath75);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&satWrite25];
        //NSLog(@"satWrite25: %@",satWrite25);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&satWrite75];
        //NSLog(@"satWrite75: %@",satWrite75);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&actComposite25];
        //NSLog(@"actComposite25: %@",actComposite25);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&actComposite75];
        //NSLog(@"actComposite75: %@",actComposite75);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&actEnglish25];
        //NSLog(@"actEnglish25: %@",actEnglish25);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&actEnglish75];
        //NSLog(@"actEnglish75: %@",actEnglish75);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&actMath25];
        //NSLog(@"actMath25: %@",actMath25);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&actMath75];
        //NSLog(@"actMath75: %@",actMath75);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToString:separatorString intoString:&actWrite25];
        //NSLog(@"actWrite25 %@",actWrite25);
        
        [theScanner scanString:separatorString intoString:NULL];
        [theScanner scanUpToCharactersFromSet:newLineSet intoString:&actWrite75];
        
        College *theCollege = [NSEntityDescription insertNewObjectForEntityForName:@"College" inManagedObjectContext:managedObjectContext];
        
        //theCollege.collegeNumber = [NSNumber numberWithInteger:[collegeNumber integerValue]];
        
        theCollege.laureRank = [NSNumber numberWithInteger:[laureRank integerValue]]; 
        
        if([forbesRank integerValue] > 0){
            theCollege.forbesRank = [NSNumber numberWithInteger:[forbesRank integerValue]];
            theCollege.forbesRankS = forbesRank;
            
        } else {
            theCollege.forbesRank =[NSNumber numberWithInteger:[@"999" integerValue]]; 
            theCollege.forbesRankS = @"Not ranked";
            
        }
        
        int usNewsRankAsInt = [usNewsRank intValue];
        if(usNewsRankAsInt > 0 && usNewsRankAsInt != 999){
            theCollege.usNewsRank =[NSNumber numberWithInt:usNewsRankAsInt];
            theCollege.usNewsRankS = usNewsRank;
            theCollege.ranked = @"YES";
            theCollege.unranked = @"NO";
        } else if (usNewsRankAsInt == 999 || usNewsRankAsInt == 0){
            theCollege.usNewsRank =[NSNumber numberWithInt:999]; 
            theCollege.usNewsRankS = @"Not ranked";
            theCollege.ranked = @"NO";
            theCollege.unranked = @"YES";
        }
        
        if (usNewsRankAsInt >= 1 && usNewsRankAsInt <=9){
            leadingSpaces = @"  ";
            rank = [leadingSpaces stringByAppendingString:[usNewsRank stringByAppendingString:@". "]];
        } else if (usNewsRankAsInt >= 10 && usNewsRankAsInt <=99){
            leadingSpaces = @" ";
            rank = [leadingSpaces stringByAppendingString:[usNewsRank stringByAppendingString:@". "]];
        } else if (usNewsRankAsInt >= 100 && usNewsRankAsInt <=998){ 
            leadingSpaces = @"";
            rank = [leadingSpaces stringByAppendingString:[usNewsRank stringByAppendingString:@". "]];
        } else {
            leadingSpaces = @"  ";
            rank = [@"NR" stringByAppendingString:leadingSpaces];
        }

        theCollege.collegeNameWithRank = [rank stringByAppendingString:collegeName];
        
        theCollege.firstLetterOfName = [[collegeNameOriginal substringToIndex:1] uppercaseString];
        
        if ([totalCostOutOfStateOnCampus intValue] > 0){
            NSNumber *total2 = [NSNumber numberWithInt:[totalCostOutOfStateOnCampus intValue]];
            //NSInteger total3 = [totalCostOutOfStateOnCampus integerValue];
                    
            theCollege.totalCostOutOfState = total2;
            theCollege.studentTotalCostN = [NSNumber numberWithInt:[totalCostOutOfStateOnCampus intValue]];
            theCollege.totalCostOutOfStateS = totalCostOutOfStateOnCampus;
            theCollege.studentTotalCostS = totalCostOutOfStateOnCampus;
        } else {
            theCollege.totalCostOutOfState = [NSNumber numberWithInt:0];
            theCollege.studentTotalCostN = [NSNumber numberWithInt:0];
            theCollege.totalCostOutOfStateS = @"Not reported";
            theCollege.studentTotalCostS = @"NA";
        }
        
        if ([totalCostOutOfStateOnCampus isEqualToString:@"0"]){
            theCollege.studentTotalCostCategory = @"7|Total cost not reported";
       
        } else if ([totalCostOutOfStateOnCampus integerValue] <= 10000){
            theCollege.studentTotalCostCategory = @"1|Less than $10,000";
           
        } else if([totalCostOutOfStateOnCampus integerValue] > 10000 && [totalCostInStateOnCampus integerValue] <= 20000){
                 theCollege.studentTotalCostCategory = @"2|$10,000 - $20,000";
        
        } else if([totalCostOutOfStateOnCampus integerValue] > 20000 && [totalCostInStateOnCampus integerValue] <= 30000){
                theCollege.studentTotalCostCategory = @"3|$20,000 - $30,000";
        
        } else if([totalCostOutOfStateOnCampus integerValue] > 30000 && [totalCostInStateOnCampus integerValue] <= 40000){
                    theCollege.studentTotalCostCategory = @"4|$30,000 - $40,000";
        
        } else if([totalCostOutOfStateOnCampus integerValue] > 40000 && [totalCostInStateOnCampus integerValue] <= 50000){
                theCollege.studentTotalCostCategory = @"5|$40,000 - $50,000";
        
        } else if([totalCostOutOfStateOnCampus integerValue] > 50000){
                theCollege.studentTotalCostCategory = @"6|More than $50,000";
        }
        
        theCollege.region = region;
        
        theCollege.state = state;
        int stateArrayRow = [statesArray indexOfObject:state];
        
        NSString *stateAbb = [statesAbbArray objectAtIndex:stateArrayRow];
        theCollege.cityState = [city stringByAppendingString:[@", " stringByAppendingString:stateAbb]];
        
        theCollege.city = city;
        theCollege.collegeNameOriginal = collegeNameOriginal;
        theCollege.collegeName = collegeName;
        theCollege.percentAA = percentAA;
        theCollege.percentA = percentA;
        theCollege.percentB = percentB;
        theCollege.percentC = percentC;
        theCollege.percentD = percentD;
        theCollege.percentE = percentE;
        theCollege.percentF = percentF;
        theCollege.percentG = percentG;   
        theCollege.percentH = percentH;
        theCollege.percentI = percentI; 
        //theCollege.artDesign = artDesign;
        //theCollege.music = music;
        //theCollege.liberalArts = liberalArts;
        //theCollege.military = military;
        //theCollege.religious = religious;
        //theCollege.privateCollege = privateCollege;
        
        
        //PrivateCollege isEqualToString:@"YES"
        
        if ([privateCollege isEqualToString:@"YES"] || [collegeName isEqualToString:@"University of Pennsylvania"]){
            theCollege.publicCollege = @"NO";
            theCollege.privateCollege = @"YES";
            privateCollege = @"YES";
        } else {
            theCollege.publicCollege = @"YES";
            theCollege.privateCollege = @"NO";
        }
        
        if ([liberalArts isEqualToString:@"YES"]){
            theCollege.liberalArts = @"YES";
        } else {
            theCollege.liberalArts = @"NO";
        }
        
        if ([religious isEqualToString:@"YES"]){
            theCollege.religious = @"YES";
        } else {
            theCollege.religious = @"NO";
        }
        
        NSMutableArray *detailFieldsToLoad = [NSMutableArray arrayWithObjects:@"webAddress",@"usNewsRank",@"forbesRank",@"collegeNameOriginal",@"artDesign",@"music",@"liberalArts",@"military",@"privateCollege",@"religious",@"city",@"state",@"region",@"openAdmissionPolicy",@"gpa",@"classRank",@"schoolRecords",@"collegePrep",@"recommendations",@"admissionTestScores",@"toefl",@"totalCostInStateOnCampus",@"totalCostOutOfStateOnCampus",@"tuitionInStateFullTime",@"tuitionOutOfStateFullTime",@"applicantsTotal",@"admissionsTotal",@"enrolledTotal",@"percentAdmitted",@"admissionsYield",@"satRead25",@"satRead75",@"satMath25",@"satMath75",@"satWrite25",@"satWrite75",@"actComposite25",@"actComposite75",@"actEnglish25",@"actEnglish75",@"actMath25",@"actMath75",@"actWrite25",@"actWrite75",nil];
        
        for (NSString *afieldToLoad in detailFieldsToLoad){
            
            CollegeDetail *theCollegeDetail = [NSEntityDescription insertNewObjectForEntityForName:@"CollegeDetail" inManagedObjectContext:managedObjectContext];
            
            if (afieldToLoad == @"usNewsRank"){
                if([usNewsRank integerValue] > 0 && [usNewsRank integerValue] != 999){
                    theCollegeDetail.value = usNewsRank;
                } else {
                    theCollegeDetail.value = @"Not Ranked";
                }
                theCollegeDetail.field = @"US News rank";
                theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:2];
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"forbesRank"){
                if([forbesRank integerValue] > 0 && [forbesRank integerValue] != 999){
                    theCollegeDetail.value = forbesRank;
                } else {
                    theCollegeDetail.value = @"Not Ranked";
                }
                theCollegeDetail.field = @"Forbes rank";
                theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:2];
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"webAddress"){
                theCollegeDetail.field = @"Internet Address";
                theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:8];
                theCollegeDetail.value = webAddress;
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"state"){
                theCollegeDetail.field = @"State";
                theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:6];
                theCollegeDetail.value = state;
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"city"){
                theCollegeDetail.field = @"City";
                theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:5];
                theCollegeDetail.value = city;
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"region"){
                theCollegeDetail.field = @"Region";
                theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:7];
                theCollegeDetail.value = region;
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"totalCostInStateOnCampus"){
                if([totalCostInStateOnCampus integerValue] > 0){
                    theCollegeDetail.field = @"Total Cost In-State";
                    theCollegeDetail.group = @"8|Expenses";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:3];
                    
                    NSString *source = totalCostInStateOnCampus;
                    int sourceLength = [source length];
                    
                    if(sourceLength == 5){
                        NSString *firstTwo = [source substringToIndex:2];
                        NSString *lastThree = [source substringFromIndex:2];
                        NSString *sourceFormatted = [[[@"$" stringByAppendingString:firstTwo] stringByAppendingString:@","]stringByAppendingString:lastThree]; 
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 4){
                        NSString *firstOne = [source substringToIndex:1];
                        NSString *lastThree = [source substringFromIndex:1];
                        NSString *sourceFormatted = [[[@"$" stringByAppendingString:firstOne] stringByAppendingString:@","]stringByAppendingString:lastThree]; 
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 3){
                        NSString *sourceFormatted = [@"$" stringByAppendingString:source];
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } 
                }
            } else if (afieldToLoad == @"totalCostOutOfStateOnCampus"){
                if([totalCostOutOfStateOnCampus integerValue] > 0){
                    theCollegeDetail.field = @"Total Cost Out-of-State";
                    theCollegeDetail.group = @"8|Expenses";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:4];
                    
                    NSString *source = totalCostOutOfStateOnCampus;
                    int sourceLength = [source length];
                    
                    if(sourceLength == 5){
                        NSString *firstTwo = [source substringToIndex:2];
                        NSString *lastThree = [source substringFromIndex:2];
                        NSString *sourceFormatted = [[[@"$" stringByAppendingString:firstTwo] stringByAppendingString:@","]stringByAppendingString:lastThree]; 
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 4){
                        NSString *firstOne = [source substringToIndex:1];
                        NSString *lastThree = [source substringFromIndex:1];
                        NSString *sourceFormatted = [[[@"$" stringByAppendingString:firstOne] stringByAppendingString:@","]stringByAppendingString:lastThree]; 
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 3){
                        NSString *sourceFormatted = [@"$" stringByAppendingString:source];
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } 
                } 
            } else if (afieldToLoad == @"tuitionInStateFullTime"){
                if([tuitionInStateFullTime integerValue] > 0){
                    theCollegeDetail.field = @"Tuition In-State";
                    theCollegeDetail.group = @"8|Expenses";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:1];
                    
                    NSString *source = tuitionInStateFullTime;
                    int sourceLength = [source length];
                    
                    if(sourceLength == 5){
                        NSString *firstTwo = [source substringToIndex:2];
                        NSString *lastThree = [source substringFromIndex:2];
                        NSString *sourceFormatted = [[[@"$" stringByAppendingString:firstTwo] stringByAppendingString:@","]stringByAppendingString:lastThree]; 
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 4){
                        NSString *firstOne = [source substringToIndex:1];
                        NSString *lastThree = [source substringFromIndex:1];
                        NSString *sourceFormatted = [[[@"$" stringByAppendingString:firstOne] stringByAppendingString:@","]stringByAppendingString:lastThree]; 
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 3){
                        NSString *sourceFormatted = [@"$" stringByAppendingString:source];
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } 
                }
            } else if (afieldToLoad == @"tuitionOutOfStateFullTime"){
                if([tuitionOutOfStateFullTime integerValue] > 0){
                    theCollegeDetail.field = @"Tuition Out-of-State";
                    theCollegeDetail.group = @"8|Expenses";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:2];
                    
                    NSString *source = tuitionOutOfStateFullTime;
                    int sourceLength = [source length];
                    
                    if(sourceLength == 5){
                        NSString *firstTwo = [source substringToIndex:2];
                        NSString *lastThree = [source substringFromIndex:2];
                        NSString *sourceFormatted = [[[@"$" stringByAppendingString:firstTwo] stringByAppendingString:@","]stringByAppendingString:lastThree]; 
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 4){
                        NSString *firstOne = [source substringToIndex:1];
                        NSString *lastThree = [source substringFromIndex:1];
                        NSString *sourceFormatted = [[[@"$" stringByAppendingString:firstOne] stringByAppendingString:@","]stringByAppendingString:lastThree]; 
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 3){
                        NSString *sourceFormatted = [@"$" stringByAppendingString:source];
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } 
                }
            } else if (afieldToLoad == @"applicantsTotal"){
                if([applicantsTotal integerValue] > 0){
                    theCollegeDetail.field = @"Applicants";
                    theCollegeDetail.group = @"3|Admission Statistics";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:8];
                    
                    NSString *source = applicantsTotal;
                    int sourceLength = [source length];
                    
                    if(sourceLength == 5){
                        NSString *firstTwo = [source substringToIndex:2];
                        NSString *lastThree = [source substringFromIndex:2];
                        NSString *sourceFormatted = [[firstTwo stringByAppendingString:@","]stringByAppendingString:lastThree]; 
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 4){
                        NSString *firstOne = [source substringToIndex:1];
                        NSString *lastThree = [source substringFromIndex:1];
                        NSString *sourceFormatted = [[firstOne stringByAppendingString:@","]stringByAppendingString:lastThree];
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 3){
                        theCollegeDetail.value = source;
                        theCollegeDetail.college = theCollege;
                    } 
                }
            } else if (afieldToLoad == @"admissionsTotal"){
                if([admissionsTotal integerValue] > 0){
                    theCollegeDetail.field = @"Admissions";
                    theCollegeDetail.group = @"3|Admission Statistics";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:9];
                    
                    NSString *source = admissionsTotal;
                    int sourceLength = [source length];
                    
                    if(sourceLength == 5){
                        NSString *firstTwo = [source substringToIndex:2];
                        NSString *lastThree = [source substringFromIndex:2];
                        NSString *sourceFormatted = [[firstTwo stringByAppendingString:@","]stringByAppendingString:lastThree]; 
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 4){
                        NSString *firstOne = [source substringToIndex:1];
                        NSString *lastThree = [source substringFromIndex:1];
                        NSString *sourceFormatted = [[firstOne stringByAppendingString:@","]stringByAppendingString:lastThree];
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 3){
                        theCollegeDetail.value = source;
                        theCollegeDetail.college = theCollege;
                    } 
                }
            } else if (afieldToLoad == @"enrolledTotal"){
                if([enrolledTotal integerValue] > 0){
                    theCollegeDetail.field = @"Enrolled";
                    theCollegeDetail.group = @"3|Admission Statistics";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:10];
                    
                    NSString *source = enrolledTotal;
                    int sourceLength = [source length];
                    
                    if(sourceLength == 5){
                        NSString *firstTwo = [source substringToIndex:2];
                        NSString *lastThree = [source substringFromIndex:2];
                        NSString *sourceFormatted = [[firstTwo stringByAppendingString:@","]stringByAppendingString:lastThree]; 
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 4){
                        NSString *firstOne = [source substringToIndex:1];
                        NSString *lastThree = [source substringFromIndex:1];
                        NSString *sourceFormatted = [[firstOne stringByAppendingString:@","]stringByAppendingString:lastThree];
                        theCollegeDetail.value = sourceFormatted;
                        theCollegeDetail.college = theCollege;
                    } else if(sourceLength == 3){
                        theCollegeDetail.value = source;
                        theCollegeDetail.college = theCollege;
                    } 
                }
            } else if (afieldToLoad == @"percentAdmitted"){
                if([percentAdmitted integerValue] > 0){
                    theCollegeDetail.field = @"Percent Admitted";
                    theCollegeDetail.group = @"3|Admission Statistics";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:1];
                    theCollegeDetail.value = percentAdmitted;
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"admissionsYield"){
                if([admissionsYield integerValue] > 0){
                    theCollegeDetail.field = @"Admissions Yield";
                    theCollegeDetail.group = @"3|Admission Statistics";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:11];
                    theCollegeDetail.value = admissionsYield;
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"openAdmissionsPolicy"){
                theCollegeDetail.field = @"Open Admissions Policy";
                theCollegeDetail.group = @"9|Admissions Requirements";
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:2];
                theCollegeDetail.value = openAdmissionPolicy;
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"gpa"){
                theCollegeDetail.field = @"GPA";
                theCollegeDetail.group = @"9|Admissions Requirements";
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:1];
                theCollegeDetail.value = gpa;
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"classRank"){
                theCollegeDetail.field = @"Class Rank";
                theCollegeDetail.group = @"9|Admissions Requirements";
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:2];
                theCollegeDetail.value = classRank;
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"schoolRecords"){
                theCollegeDetail.field = @"School Records";
                theCollegeDetail.group = @"9|Admissions Requirements";
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:6];
                theCollegeDetail.value = schoolRecords;
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"collegePrep"){
                theCollegeDetail.field = @"College Prep";
                theCollegeDetail.group = @"9|Admissions Requirements";
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:5];
                theCollegeDetail.value = collegePrep;
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"recommendations"){
                theCollegeDetail.field = @"Recommendations";
                theCollegeDetail.group = @"9|Admissions Requirements";
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:4];
                theCollegeDetail.value = recommendations;
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"admissionTestScores"){
                theCollegeDetail.field = @"Test Scores";
                theCollegeDetail.group = @"9|Admissions Requirements";
                theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:3];
                theCollegeDetail.value = admissionTestScores;
                theCollegeDetail.college = theCollege;
            } else if (afieldToLoad == @"privateCollege"){
                if ([privateCollege isEqualToString:@"YES"]){
                    theCollegeDetail.field = @"Private College";
                    theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:4];
                    theCollegeDetail.college = theCollege;
                } else {
                    theCollegeDetail.field = @"Public College";
                    theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:4];
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"religious"){
                if ([religious isEqualToString:@"YES"]){
                    theCollegeDetail.field = @"Religious College";
                    theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:4];
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"military"){
                if ([military isEqualToString:@"YES"]){
                    theCollegeDetail.field = @"Military College";
                    theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:4];
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"liberalArts"){
                if ([liberalArts isEqualToString:@"YES"]){
                    theCollegeDetail.field = @"Liberal Arts College";
                    theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:4];
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"music"){
                if ([music isEqualToString:@"YES"]){
                    theCollegeDetail.field = @"Music College";
                    theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:4];
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"artDesign"){
                if ([artDesign isEqualToString:@"YES"]){
                    theCollegeDetail.field = @"Art / Design College";
                    theCollegeDetail.group = [@"1|" stringByAppendingString:collegeNameOriginal];
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:4];
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"satRead25"){
                if([satRead25 integerValue] > 0 && [satRead75 integerValue] > 0){
                    theCollegeDetail.field = @"SAT Reading";
                    theCollegeDetail.group = @"2|Test Scores 25th / 75th Percentiles";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:2];
                    theCollegeDetail.value = [[satRead25 stringByAppendingString:@" / "]stringByAppendingString:satRead75];
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"satMath25"){
                if([satMath25 integerValue] > 0 && [satMath75 integerValue] > 0){
                    theCollegeDetail.field = @"SAT Math";
                    theCollegeDetail.group = @"2|Test Scores 25th / 75th Percentiles";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:3];
                    theCollegeDetail.value = [[satMath25 stringByAppendingString:@" / "]stringByAppendingString:satMath75];
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"satWrite25"){
                if([satWrite25 integerValue] > 0 && [satWrite75 integerValue] > 0){
                    theCollegeDetail.field = @"SAT Writing";
                    theCollegeDetail.group = @"2|Test Scores 25th / 75th Percentiles";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:4];
                    theCollegeDetail.value = [[satWrite25 stringByAppendingString:@" / "]stringByAppendingString:satWrite75];
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"actComposite25"){
                if([actComposite25 integerValue] > 0 && [actComposite75 integerValue] > 0){
                    theCollegeDetail.field = @"ACT Composite";
                    theCollegeDetail.group = @"2|Test Scores 25th / 75th Percentiles";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:5];
                    theCollegeDetail.value = [[actComposite25 stringByAppendingString:@" / "]stringByAppendingString:actComposite75];
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"actEnglish25"){
                if([actEnglish25 integerValue] > 0 && [actEnglish75 integerValue] > 0){
                    theCollegeDetail.field = @"ACT English";
                    theCollegeDetail.group = @"2|Test Scores 25th / 75th Percentiles";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:7];
                    theCollegeDetail.value = [[actEnglish25 stringByAppendingString:@" / "]stringByAppendingString:actEnglish75];
                    theCollegeDetail.college = theCollege;
                }
            } else if (afieldToLoad == @"actMath25"){
                if([actMath25 integerValue] > 0 && [actMath75 integerValue] > 0){
                    theCollegeDetail.field = @"ACT Math";
                    theCollegeDetail.group = @"2|Test Scores 25th / 75th Percentiles";
                    theCollegeDetail.fieldSortOrder = [NSNumber numberWithInt:6];
                    theCollegeDetail.value = [[actMath25 stringByAppendingString:@" / "]stringByAppendingString:actMath75];
                    theCollegeDetail.college = theCollege;
                }
            }
            
        } // end of "for" loop  

        
    } // end of "while" loop
 
        
    // Save the data after loading all colleges
    //NSError *error = nil;
    if (![managedObjectContext save:&error]){
        //NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
        NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
        if(detailedErrors != nil && [detailedErrors count] > 0) {
            for(NSError* detailedError in detailedErrors) {
                //NSLog(@"  DetailedError: %@", [detailedError userInfo]);
            }
        }
    } else {
        NSLog(@"Saved");
    } 

} // end of method


//return;



@end

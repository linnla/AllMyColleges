//
//  College.h
//  AllMyColleges
//
//  Created by Laure Linn on 10/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface College : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * privateCollege;
@property (nonatomic, retain) NSString * liberalArts;
@property (nonatomic, retain) NSString * military;
@property (nonatomic, retain) NSString * artDesign;
@property (nonatomic, retain) NSString * music;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSString * firstLetterOfName;
@property (nonatomic, retain) NSString * collegeName;
@property (nonatomic, retain) NSString * collegeNameOriginal;
@property (nonatomic, retain) NSString * religious;
@property (nonatomic, retain) NSString * studentCollegeCategory;
@property (nonatomic, retain) NSString * studentPercent;
@property (nonatomic, retain) NSNumber * studentOdds;
@property (nonatomic, retain) NSString * studentTotalCostS;
@property (nonatomic, retain) NSString * studentTuitionCostS;
@property (nonatomic, retain) NSString * studentTotalCostCategory;
@property (nonatomic, retain) NSString * studentTuitionCostCategory;
@property (nonatomic, retain) NSNumber * studentTotalCostN;
@property (nonatomic, retain) NSNumber * studentTuitionCostN;
@property (nonatomic, retain) NSString * percentAA;
@property (nonatomic, retain) NSString * percentA;
@property (nonatomic, retain) NSString * percentB;
@property (nonatomic, retain) NSString * percentC;
@property (nonatomic, retain) NSString * percentD;
@property (nonatomic, retain) NSString * percentE;
@property (nonatomic, retain) NSString * percentF;
@property (nonatomic, retain) NSString * percentG;
@property (nonatomic, retain) NSString * percentH;
@property (nonatomic, retain) NSString * percentI;
@property (nonatomic, retain) NSNumber * totalCostInState;
@property (nonatomic, retain) NSNumber * totalCostOutOfState;
@property (nonatomic, retain) NSNumber * tuitionCostInState;
@property (nonatomic, retain) NSNumber * tuitionCostOutOfState;
@property (nonatomic, retain) NSNumber * usNewsRank;
@property (nonatomic, retain) NSNumber * forbesRank;
@property (nonatomic, retain) NSNumber * laureRank;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSSet* collegeDetail;

@property (nonatomic, retain) NSString *usNewsRankS;
@property (nonatomic, retain) NSString *forbesRankS;
@property (nonatomic, retain) NSString *totalCostInStateS;
@property (nonatomic, retain) NSString *totalCostOutOfStateS;
@property (nonatomic, retain) NSString *tuitionCostInStateS;
@property (nonatomic, retain) NSString *tuitionCostOutOfStateS;
@property (nonatomic, retain) NSString *collegeNameWithRank;
@property (nonatomic, retain) NSString *cityState;
@property (nonatomic, retain) NSString *ranked;
@property (nonatomic, retain) NSString *unranked;
@property (nonatomic, retain) NSString *publicCollege;


@end

//
//  College.m
//  AllMyColleges
//
//  Created by Laure Linn on 10/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "College.h"


@implementation College
@dynamic privateCollege;
@dynamic liberalArts;
@dynamic military;
@dynamic artDesign;
@dynamic music;
@dynamic city;
@dynamic state;
@dynamic region;
@dynamic firstLetterOfName;
@dynamic collegeName;
@dynamic collegeNameOriginal;
@dynamic religious;
@dynamic studentCollegeCategory;
@dynamic studentPercent;
@dynamic studentOdds;
@dynamic studentTotalCostS;
@dynamic studentTuitionCostS;
@dynamic studentTotalCostCategory;
@dynamic studentTuitionCostCategory;
@dynamic studentTotalCostN;
@dynamic studentTuitionCostN;
@dynamic percentAA;
@dynamic percentA;
@dynamic percentB;
@dynamic percentC;
@dynamic percentD;
@dynamic percentE;
@dynamic percentF;
@dynamic percentG;
@dynamic percentH;
@dynamic percentI;
@dynamic totalCostInState;
@dynamic totalCostOutOfState;
@dynamic tuitionCostInState;
@dynamic tuitionCostOutOfState;
@dynamic usNewsRank;
@dynamic forbesRank;
@dynamic laureRank;
@dynamic latitude;
@dynamic longitude;
@dynamic collegeDetail;

@dynamic usNewsRankS;
@dynamic forbesRankS;
@dynamic totalCostInStateS;
@dynamic totalCostOutOfStateS;
@dynamic tuitionCostInStateS;
@dynamic tuitionCostOutOfStateS;
@dynamic collegeNameWithRank;
@dynamic cityState;
@dynamic ranked;
@dynamic unranked;
@dynamic publicCollege;

- (void)addCollegeDetailObject:(NSManagedObject *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"collegeDetail" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"collegeDetail"] addObject:value];
    [self didChangeValueForKey:@"collegeDetail" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    //[changedObjects release];
}

- (void)removeCollegeDetailObject:(NSManagedObject *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"collegeDetail" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"collegeDetail"] removeObject:value];
    [self didChangeValueForKey:@"collegeDetail" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    //[changedObjects release];
}

- (void)addCollegeDetail:(NSSet *)value {    
    [self willChangeValueForKey:@"collegeDetail" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"collegeDetail"] unionSet:value];
    [self didChangeValueForKey:@"collegeDetail" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeCollegeDetail:(NSSet *)value {
    [self willChangeValueForKey:@"collegeDetail" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"collegeDetail"] minusSet:value];
    [self didChangeValueForKey:@"collegeDetail" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end

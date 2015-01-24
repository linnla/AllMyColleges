//
//  CollegeDetail.h
//  AllMyColleges
//
//  Created by Laure Linn on 10/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class College;

@interface CollegeDetail : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * field;
@property (nonatomic, retain) NSString * group;
@property (nonatomic, retain) NSNumber * fieldSortOrder;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) College * college;

@end

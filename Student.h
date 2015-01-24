//
//  Student.h
//  AllMyColleges
//
//  Created by Laure Linn on 10/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * group;
@property (nonatomic, retain) NSString * field;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSString * fieldSortOrder;

+ (void) loadStudentSettingsInManagedObjectContext:managedObjectContext;

@end

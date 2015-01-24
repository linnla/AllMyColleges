//
//  Settings.h
//  AllMyColleges
//
//  Created by Laure Linn on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Settings : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * homeState;
@property (nonatomic, retain) NSString * classRank;
@property (nonatomic, retain) NSString * gpa;
@property (nonatomic, retain) NSString * satReading;
@property (nonatomic, retain) NSString * satMath;
@property (nonatomic, retain) NSString * satWriting;
@property (nonatomic, retain) NSString * actEnglish;
@property (nonatomic, retain) NSString * actMath;
@property (nonatomic, retain) NSString * actComposite;
@property (nonatomic, retain) NSString * actWriting;

@end

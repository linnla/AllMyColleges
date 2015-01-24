//
//  DataLoad.h
//  AllMyColleges
//
//  Created by Laure Linn on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataLoad : NSObject {
    
}

+ (void) loadCSVFileinManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@end

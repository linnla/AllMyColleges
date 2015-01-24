//
//  CalculateGPA.m
//  AllMyColleges
//
//  Created by Laure Linn on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculateGPA.h"


@implementation CalculateGPA

+ (int) ConvertGpaToPercentile:(int)gpa
{
  
    int score = gpa;
    int percentile = 0;
    
    switch (score) {
        case 400:
            percentile = 95;
            break;
        case 390:
            percentile = 94;
            break;
        case 380:
            percentile = 93;
            break;
        case 370:
            percentile = 92;
            break;
        case 360:
            percentile = 91;
            break;
        case 350:
            percentile = 90;
            break;
        case 340:
            percentile = 89;
            break;
        case 330:
            percentile = 88;
            break;
        case 320:
            percentile = 87;
            break;
        case 310:
            percentile = 86;
            break;
        case 300:
            percentile = 85;
            break;
        case 290:
            percentile = 84;
            break;
        case 280:
            percentile = 83;
            break;
        case 270:
            percentile = 82;
            break;
        case 260:
            percentile = 81;
            break;
        case 250:
            percentile = 80;
            break;
        case 240:
            percentile = 79;
            break;
        case 230:
            percentile = 78;
            break;
        case 220:
            percentile = 77;
            break;
        case 210:
            percentile = 76;
            break;
        case 200:
            percentile = 75;
            break;
        default:
            percentile = 0;
    }
    
    return percentile;

}

@end

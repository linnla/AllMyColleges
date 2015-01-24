//
//  CalculateACT.m
//  AllMyColleges
//
//  Created by Laure Linn on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculateACT.h"


@implementation CalculateACT

+ (int) ConvertActToPercentileForSubject:(NSString *)subject Score:(int)actScore
{
    int score = actScore;
    int percentile = 0;
    
    switch (score) {
        case 36:
            if (subject == @"English"){
                percentile = 99;
            } else if (subject == @"Math"){
                percentile = 99;
            } else if (subject == @"Writing"){
                percentile = 99;
            } else if (subject == @"Composite"){
                percentile = 99;
            }
            break;
        case 35:
            if (subject == @"English"){
                percentile = 99;
            } else if (subject == @"Math"){
                percentile = 99;
            } else if (subject == @"Writing"){
                percentile = 99;
            } else if (subject == @"Composite"){
                percentile = 99;
            }
            break;
        case 34:
            if (subject == @"English"){
                percentile = 99;
            } else if (subject == @"Math"){
                percentile = 99;
            } else if (subject == @"Writing"){
                percentile = 99;
            } else if (subject == @"Composite"){
                percentile = 99;
            }
            break;
        case 33:
            if (subject == @"English"){
                percentile = 97;
            } else if (subject == @"Math"){
                percentile = 98;
            } else if (subject == @"Writing"){
                percentile = 97;
            } else if (subject == @"Composite"){
                percentile = 99;
            }
            break;
        case 32:
            if (subject == @"English"){
                percentile = 96;
            } else if (subject == @"Math"){
                percentile = 97;
            } else if (subject == @"Writing"){
                percentile = 95;
            } else if (subject == @"Composite"){
                percentile = 98;
            }
            break;
        case 31:
            if (subject == @"English"){
                percentile = 94;
            } else if (subject == @"Math"){
                percentile = 96;
            } else if (subject == @"Writing"){
                percentile = 93;
            } else if (subject == @"Composite"){
                percentile = 97;
            }
            break;
        case 30:
            if (subject == @"English"){
                percentile = 93;
            } else if (subject == @"Math"){
                percentile = 94;
            } else if (subject == @"Writing"){
                percentile = 91;
            } else if (subject == @"Composite"){
                percentile = 95;
            }
            break;
        case 29:
            if (subject == @"English"){
                percentile = 91;
            } else if (subject == @"Math"){
                percentile = 93;
            } else if (subject == @"Writing"){
                percentile = 87;
            } else if (subject == @"Composite"){
                percentile = 93;
            }
            break;
        case 28:
            if (subject == @"English"){
                percentile = 88;
            } else if (subject == @"Math"){
                percentile = 91;
            } else if (subject == @"Writing"){
                percentile = 85;
            } else if (subject == @"Composite"){
                percentile = 91;
            }
            break;
        case 27:
            if (subject == @"English"){
                percentile = 85;
            } else if (subject == @"Math"){
                percentile = 88;
            } else if (subject == @"Writing"){
                percentile = 82;
            } else if (subject == @"Composite"){
                percentile = 87;
            }
            break;
        case 26:
            if (subject == @"English"){
                percentile = 82;
            } else if (subject == @"Math"){
                percentile = 84;
            } else if (subject == @"Writing"){
                percentile = 78;
            } else if (subject == @"Composite"){
                percentile = 84;
            }
            break;
        case 25:
            if (subject == @"English"){
                percentile = 78;
            } else if (subject == @"Math"){
                percentile = 79;
            } else if (subject == @"Writing"){
                percentile = 75;
            } else if (subject == @"Composite"){
                percentile = 79;
            }
            break;
        case 24:
            if (subject == @"English"){
                percentile = 73;
            } else if (subject == @"Math"){
                percentile = 74;
            } else if (subject == @"Writing"){
                percentile = 71;
            } else if (subject == @"Composite"){
                percentile = 74;
            }
            break;
        case 23:
            if (subject == @"English"){
                percentile = 68;
            } else if (subject == @"Math"){
                percentile = 67;
            } else if (subject == @"Writing"){
                percentile = 66;
            } else if (subject == @"Composite"){
                percentile = 68;
            }
            break;
        case 22:
            if (subject == @"English"){
                percentile = 63;
            } else if (subject == @"Math"){
                percentile = 61;
            } else if (subject == @"Writing"){
                percentile = 60;
            } else if (subject == @"Composite"){
                percentile = 62;
            }
            break;
        case 21:
            if (subject == @"English"){
                percentile = 57;
            } else if (subject == @"Math"){
                percentile = 57;
            } else if (subject == @"Writing"){
                percentile = 54;
            } else if (subject == @"Composite"){
                percentile = 55;
            }
            break;
        case 20:
            if (subject == @"English"){
                percentile = 50;
            } else if (subject == @"Math"){
                percentile = 52;
            } else if (subject == @"Writing"){
                percentile = 48;
            } else if (subject == @"Composite"){
                percentile = 48;
            }
            break;
        case 19:
            if (subject == @"English"){
                percentile = 43;
            } else if (subject == @"Math"){
                percentile = 47;
            } else if (subject == @"Writing"){
                percentile = 42;
            } else if (subject == @"Composite"){
                percentile = 41;
            }
            break;
        case 18:
            if (subject == @"English"){
                percentile = 38;
            } else if (subject == @"Math"){
                percentile = 41;
            } else if (subject == @"Writing"){
                percentile = 35;
            } else if (subject == @"Composite"){
                percentile = 34;
            }
            break;
        case 17:
            if (subject == @"English"){
                percentile = 33;
            } else if (subject == @"Math"){
                percentile = 34;
            } else if (subject == @"Writing"){
                percentile = 30;
            } else if (subject == @"Composite"){
                percentile = 28;
            }
            break;
        case 16:
            if (subject == @"English"){
                percentile = 29;
            } else if (subject == @"Math"){
                percentile = 26;
            } else if (subject == @"Writing"){
                percentile = 25;
            } else if (subject == @"Composite"){
                percentile = 21;
            }
            break;
        case 15:
            if (subject == @"English"){
                percentile = 24;
            } else if (subject == @"Math"){
                percentile = 14;
            } else if (subject == @"Writing"){
                percentile = 19;
            } else if (subject == @"Composite"){
                percentile = 16;
            }
            break;
        case 14:
            if (subject == @"English"){
                percentile = 18;
            } else if (subject == @"Math"){
                percentile = 6;
            } else if (subject == @"Writing"){
                percentile = 15;
            } else if (subject == @"Composite"){
                percentile = 11;
            }
            break;
        case 13:
            if (subject == @"English"){
                percentile = 14;
            } else if (subject == @"Math"){
                percentile = 2;
            } else if (subject == @"Writing"){
                percentile = 10;
            } else if (subject == @"Composite"){
                percentile = 6;
            }
            break;
        case 12:
            if (subject == @"English"){
                percentile = 11;
            } else if (subject == @"Math"){
                percentile = 1;
            } else if (subject == @"Writing"){
                percentile = 6;
            } else if (subject == @"Composite"){
                percentile = 3;
            }
            break;
        case 11:
            if (subject == @"English"){
                percentile = 9;
            } else if (subject == @"Math"){
                percentile = 1;
            } else if (subject == @"Writing"){
                percentile = 3;
            } else if (subject == @"Composite"){
                percentile = 1;
            }
            break;
        default:
            percentile = 0;
    }
    
    return percentile;
}
    
@end
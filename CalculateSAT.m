//
//  Calculate.m
//  AllMyColleges
//
//  Created by Laure Linn on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculateSAT.h"

@implementation CalculateSAT
        
+ (int) ConvertSatToPercentileForSubject:(NSString *)subject Score:(int)satScore
{
    int score = satScore;
    int percentile = 0;
    
    switch (score) {
        case 800:
            if (subject == @"Reading"){
                percentile = 99;
            } else if (subject == @"Math"){
                percentile = 99;
            } else if (subject == @"Writing"){
                percentile = 99;
            }
            break;
        case 790:
            if (subject == @"Reading"){
                percentile = 99;
            } else if (subject == @"Math"){
                percentile = 99;
            } else if (subject == @"Writing"){
                percentile = 99;
            }
            break;
        case 780:
            if (subject == @"Reading"){
                percentile = 99;
            } else if (subject == @"Math"){
                percentile = 99;
            } else if (subject == @"Writing"){
                percentile = 99;
            }
            break;
        case 770:
            if (subject == @"Reading"){
                percentile = 99;
            } else if (subject == @"Math"){
                percentile = 99;
            } else if (subject == @"Writing"){
                percentile = 99;
            }
            break;
        case 760:
            if (subject == @"Reading"){
                percentile = 99;
            } else if (subject == @"Math"){
                percentile = 98;
            } else if (subject == @"Writing"){
                percentile = 99;
            }
            break;
        case 750:
            if (subject == @"Reading"){
                percentile = 98;
            } else if (subject == @"Math"){
                percentile = 98;
            } else if (subject == @"Writing"){
                percentile = 99;
            }
            break;
        case 740:
            if (subject == @"Reading"){
                percentile = 98;
            } else if (subject == @"Math"){
                percentile = 97;
            } else if (subject == @"Writing"){
                percentile = 98;
            }
            break;
        case 730:
            if (subject == @"Reading"){
                percentile = 97;
            } else if (subject == @"Math"){
                percentile = 97;
            } else if (subject == @"Writing"){
                percentile = 98;
            }
            break;
        case 720:
            if (subject == @"Reading"){
                percentile = 96;
            } else if (subject == @"Math"){
                percentile = 96;
            } else if (subject == @"Writing"){
                percentile = 97;
            }
            break;
        case 710:
            if (subject == @"Reading"){
                percentile = 96;
            } else if (subject == @"Math"){
                percentile = 95;
            } else if (subject == @"Writing"){
                percentile = 97;
            }
            break;
        case 700:
            if (subject == @"Reading"){
                percentile = 95;
            } else if (subject == @"Math"){
                percentile = 93;
            } else if (subject == @"Writing"){
                percentile = 96;
            }
            break;
        case 690:
            if (subject == @"Reading"){
                percentile = 94;
            } else if (subject == @"Math"){
                percentile = 92;
            } else if (subject == @"Writing"){
                percentile = 95;
            }
            break;
        case 680:
            if (subject == @"Reading"){
                percentile = 93;
            } else if (subject == @"Math"){
                percentile = 91;
            } else if (subject == @"Writing"){
                percentile = 94;
            }
            break;
        case 670:
            if (subject == @"Reading"){
                percentile = 92;
            } else if (subject == @"Math"){
                percentile = 89;
            } else if (subject == @"Writing"){
                percentile = 93;
            }
            break;
        case 660:
            if (subject == @"Reading"){
                percentile = 92;
            } else if (subject == @"Math"){
                percentile = 88;
            } else if (subject == @"Writing"){
                percentile = 92;
            }
            break;
        case 650:
            if (subject == @"Reading"){
                percentile = 89;
            } else if (subject == @"Math"){
                percentile = 86;
            } else if (subject == @"Writing"){
                percentile = 90;
            }
            break;
        case 640:
            if (subject == @"Reading"){
                percentile = 87;
            } else if (subject == @"Math"){
                percentile = 83;
            } else if (subject == @"Writing"){
                percentile = 89;
            }
            break;
        case 630:
            if (subject == @"Reading"){
                percentile = 85;
            } else if (subject == @"Math"){
                percentile = 81;
            } else if (subject == @"Writing"){
                percentile = 87;
            }
            break;
        case 620:
            if (subject == @"Reading"){
                percentile = 83;
            } else if (subject == @"Math"){
                percentile = 79;
            } else if (subject == @"Writing"){
                percentile = 85;
            }
            break;
        case 610:
            if (subject == @"Reading"){
                percentile = 82;
            } else if (subject == @"Math"){
                percentile = 76;
            } else if (subject == @"Writing"){
                percentile = 83;
            }
            break;
        case 600:
            if (subject == @"Reading"){
                percentile = 79;
            } else if (subject == @"Math"){
                percentile = 74;
            } else if (subject == @"Writing"){
                percentile = 81;
            }
            break;
        case 590:
            if (subject == @"Reading"){
                percentile = 77;
            } else if (subject == @"Math"){
                percentile = 71;
            } else if (subject == @"Writing"){
                percentile = 79;
            }
            break;
        case 580:
            if (subject == @"Reading"){
                percentile = 74;
            } else if (subject == @"Math"){
                percentile = 68;
            } else if (subject == @"Writing"){
                percentile = 76;
            }
            break;
        case 570:
            if (subject == @"Reading"){
                percentile = 71;
            } else if (subject == @"Math"){
                percentile = 66;
            } else if (subject == @"Writing"){
                percentile = 73;
            }
            break;
        case 560:
            if (subject == @"Reading"){
                percentile = 68;
            } else if (subject == @"Math"){
                percentile = 63;
            } else if (subject == @"Writing"){
                percentile = 71;
            }
            break;
        case 550:
            if (subject == @"Reading"){
                percentile = 65;
            } else if (subject == @"Math"){
                percentile = 60;
            } else if (subject == @"Writing"){
                percentile = 68;
            }
            break;
        case 540:
            if (subject == @"Reading"){
                percentile = 62;
            } else if (subject == @"Math"){
                percentile = 56;
            } else if (subject == @"Writing"){
                percentile = 64;
            }
            break;
        case 530:
            if (subject == @"Reading"){
                percentile = 58;
            } else if (subject == @"Math"){
                percentile = 53;
            } else if (subject == @"Writing"){
                percentile = 62;
            }
            break;
        case 520:
            if (subject == @"Reading"){
                percentile = 55;
            } else if (subject == @"Math"){
                percentile = 50;
            } else if (subject == @"Writing"){
                percentile = 58;
            }
            break;
        case 510:
            if (subject == @"Reading"){
                percentile = 51;
            } else if (subject == @"Math"){
                percentile = 47;
            } else if (subject == @"Writing"){
                percentile = 54;
            }
            break;
        case 500:
            if (subject == @"Reading"){
                percentile = 48;
            } else if (subject == @"Math"){
                percentile = 43;
            } else if (subject == @"Writing"){
                percentile = 51;
            }
            break;
        case 490:
            if (subject == @"Reading"){
                percentile = 44;
            } else if (subject == @"Math"){
                percentile = 40;
            } else if (subject == @"Writing"){
                percentile = 47;
            }
            break;
        case 480:
            if (subject == @"Reading"){
                percentile = 41;
            } else if (subject == @"Math"){
                percentile = 36;
            } else if (subject == @"Writing"){
                percentile = 44;
            }
            break;
        case 470:
            if (subject == @"Reading"){
                percentile = 37;
            } else if (subject == @"Math"){
                percentile = 33;
            } else if (subject == @"Writing"){
                percentile = 40;
            }
            break;
        case 460:
            if (subject == @"Reading"){
                percentile = 34;
            } else if (subject == @"Math"){
                percentile = 30;
            } else if (subject == @"Writing"){
                percentile = 37;
            }
            break;
        case 450:
            if (subject == @"Reading"){
                percentile = 31;
            } else if (subject == @"Math"){
                percentile = 27;
            } else if (subject == @"Writing"){
                percentile = 33;
            }
            break;
        case 440:
            if (subject == @"Reading"){
                percentile = 27;
            } else if (subject == @"Math"){
                percentile = 25;
            } else if (subject == @"Writing"){
                percentile = 30;
            }
            break;
        case 430:
            if (subject == @"Reading"){
                percentile = 25;
            } else if (subject == @"Math"){
                percentile = 22;
            } else if (subject == @"Writing"){
                percentile = 27;
            }
            break;
        case 420:
            if (subject == @"Reading"){
                percentile = 22;
            } else if (subject == @"Math"){
                percentile = 19;
            } else if (subject == @"Writing"){
                percentile = 23;
            }
            break;
        case 410:
            if (subject == @"Reading"){
                percentile = 19;
            } else if (subject == @"Math"){
                percentile = 16;
            } else if (subject == @"Writing"){
                percentile = 20;
            }
            break;
        case 400:
            if (subject == @"Reading"){
                percentile = 17;
            } else if (subject == @"Math"){
                percentile = 14;
            } else if (subject == @"Writing"){
                percentile = 18;
            }
            break;
        case 390:
            if (subject == @"Reading"){
                percentile = 15;
            } else if (subject == @"Math"){
                percentile = 12;
            } else if (subject == @"Writing"){
                percentile = 15;
            }
            break;
        case 380:
            if (subject == @"Reading"){
                percentile = 12;
            } else if (subject == @"Math"){
                percentile = 11;
            } else if (subject == @"Writing"){
                percentile = 13;
            }
            break;
        case 370:
            if (subject == @"Reading"){
                percentile = 10;
            } else if (subject == @"Math"){
                percentile = 9;
            } else if (subject == @"Writing"){
                percentile = 11;
            }
            break;
        case 360:
            if (subject == @"Reading"){
                percentile = 9;
            } else if (subject == @"Math"){
                percentile = 7;
            } else if (subject == @"Writing"){
                percentile = 9;
            }
            break;
        case 350:
            if (subject == @"Reading"){
                percentile = 7;
            } else if (subject == @"Math"){
                percentile = 6;
            } else if (subject == @"Writing"){
                percentile = 7;
            }
            break;
        case 340:
            if (subject == @"Reading"){
                percentile = 6;
            } else if (subject == @"Math"){
                percentile = 5;
            } else if (subject == @"Writing"){
                percentile = 6;
            }
            break;
        case 330:
            if (subject == @"Reading"){
                percentile = 5;
            } else if (subject == @"Math"){
                percentile = 4;
            } else if (subject == @"Writing"){
                percentile = 5;
            }
            break;
        case 320:
            if (subject == @"Reading"){
                percentile = 4;
            } else if (subject == @"Math"){
                percentile = 4;
            } else if (subject == @"Writing"){
                percentile = 4;
            }
            break;
        case 310:
            if (subject == @"Reading"){
                percentile = 4;
            } else if (subject == @"Math"){
                percentile = 3;
            } else if (subject == @"Writing"){
                percentile = 3;
            }
            break;
        default:
            percentile = 0;
    }
    
    return percentile;
}

@end

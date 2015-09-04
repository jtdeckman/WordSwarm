//
//  Space.h
//  Droozle
//
//  Created by Jason Deckman on 9/4/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import <UIKit/UIKit.h>

@interface Space : NSObject {
    
    int value;
    int iind;
    int jind;
    
    BOOL isOccupied;
    
    NSMutableSet *nearestNbrs;
    NSMutableSet *neighbors;
    
    CGRect spaceFrame;
    
    UILabel *piece;
    UIImage *p1Img;
    UIImage *p2Img;
    
    JDColor color;
}

@property (nonatomic) int value;
@property (nonatomic) int iind;
@property (nonatomic) int jind;

@property (nonatomic) CGRect spaceFrame;

@end

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

@property (nonatomic) BOOL isOccupied;

@property (nonatomic) int value;
@property (nonatomic) int iind;
@property (nonatomic) int jind;

@property (nonatomic) CGRect spaceFrame;

@property (nonatomic, strong) UILabel *piece;
@property (nonatomic, strong) NSMutableSet *neighbors;
@property (nonatomic, strong) NSMutableSet *nearestNbrs;

- (void)initSpace: (int)ival : (int)jval : (CGRect)spaceFrm : (CGRect)labelframe;
- (void)setColor: (CGFloat)red : (CGFloat)green : (CGFloat)blue : (CGFloat)alpha;
- (void)configurePiece: (bool)isRefPiece;
- (bool)isNearestNearestNbrOf: (Space*)space;

- (void)deconstruct;

@end

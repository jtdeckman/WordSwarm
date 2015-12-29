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
    
    NSString *value;
    
    int iind;
    int jind;
    
    uint pointValue;
    uint backPieceVal;
    
    BOOL isOccupied;
    BOOL refPiece;
    
    NSMutableSet *nearestNbrs;
    NSMutableSet *neighbors;
    
    CGRect spaceFrame;
    
    UILabel *piece;
    UILabel *backPiece;
    
    UIImage *p1Img;
    UIImage *p2Img;
    UIImage *p3Img;
    
    JDColor color;
}

@property (nonatomic) BOOL isOccupied;
@property (nonatomic) BOOL refPiece;

@property (nonatomic, strong)  NSString *value;

@property (nonatomic) int iind;
@property (nonatomic) int jind;

@property (nonatomic) uint pointValue;
@property (nonatomic) uint backPieceVal;

@property (nonatomic) CGRect spaceFrame;

@property (nonatomic, strong) UILabel *piece;
@property (nonatomic, strong) UILabel *backPiece;

@property (nonatomic, strong) NSMutableSet *neighbors;
@property (nonatomic, strong) NSMutableSet *nearestNbrs;

- (void)initSpace: (int)ival : (int)jval : (CGRect)spaceFrm : (CGRect)labelframe;
- (void)setColor: (CGFloat)red : (CGFloat)green : (CGFloat)blue : (CGFloat)alpha;
- (void)configurePiece: (bool)isRefPiece :(UIColor*)bckImg;

- (bool)isNearestNearestNbrOf: (Space*)space;

- (void)deconstruct;

@end

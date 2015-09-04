//
//  Board.h
//  Droozle
//
//  Created by Jason Deckman on 9/4/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UiKit.h>
#import "Space.h"

@interface Board : NSObject {
    
    NSMutableArray *spaces;
    NSMutableArray *rows;
    
    int dimx;
    int dimy;
    int numSpaces;
    
    CGFloat spaceWidth;
    CGFloat spaceHeight;
    CGFloat pieceHeight, ph2;
    CGFloat pieceWidth, pw2;
}

@property (nonatomic, strong) Space* selectedSpace;

@property (nonatomic, strong) NSMutableArray *spaces;
@property (nonatomic, strong) NSMutableArray *rows;

@property (nonatomic) int dimx;
@property (nonatomic) int dimy;

@property (nonatomic) uint cFlagPos1;
@property (nonatomic) uint cFlagPos2;

- (void)initBoard: (CGRect)bvFrame : (int)dimx : (int)dimy : (CGFloat)offset;
- (void)addPiece: (int)ival : (int)jval : (int)val : (JDColor)clr;

- (Space*)getSpaceForIndices: (int)ival : (int)jval;
- (Space*)getSpaceFromPoint: (CGPoint)loc;

- (int)nbrNearestOccupied: (Space*)space;
- (int)nbrOccupied: (Space*)space;

- (void)removePiece: (Space*)space;
- (void)clearBoard;

- (void)deconstruct;

@end

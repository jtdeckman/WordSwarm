//
//  GamePlay.h
//  Droozle
//
//  Created by Jason Deckman on 9/26/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"

@interface GamePlay : NSObject {
    
    int dimx;
    int dimy;
    
    int maxVal;
    
    Board *board;
}

@property (nonatomic) int dimx;
@property (nonatomic) int dimy;

- (void) setUp:(Board*)brd :(CGRect)frm;
- (void) rowOfValues;

@end

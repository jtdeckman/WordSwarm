//
//  GamePlay.m
//  Droozle
//
//  Created by Jason Deckman on 9/26/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay

@synthesize dimx, dimy;

- (void)setUp:(Board*)brd {
    
    board = brd;
    
    dimx = 10;
    dimy = 7;
    
    maxVal = 100;
}

- (void)rowOfValues {

    NSMutableArray *vals = [[NSMutableArray alloc] initWithCapacity:dimx];
    
    NSNumber *value;
    
    for(int i=0; i<dimy; i++) {
        value = [NSNumber numberWithInt:rand() % maxVal];
        [vals addObject:value];
    }
    
    value = [NSNumber numberWithInt:maxVal];
    [vals addObject:value];
    
    [board addBottomRow:vals];
}

@end

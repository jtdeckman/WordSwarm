//
//  AnimationPieces.m
//  Droozle
//
//  Created by Jason Deckman on 12/28/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "AnimationPieces.h"
#import <UIKIt/UIKit.h>

@implementation AnimationPieces

@synthesize pieces;

- (void)setUpPieces {
    
    pieces = [[NSMutableArray alloc] initWithCapacity:500];
 
    UILabel *piece;
    
    for(int i=0; i<500; i++) {
        
        piece = [[UILabel alloc] init];
        [pieces addObject:piece];
    }
}

- (void)deconstruct {

    UILabel *piece;
    
    for(int i=0; i<500; i++) {
        
        piece = [pieces objectAtIndex:i];
        piece = nil;
    }
    
    [pieces removeAllObjects];
    
    pieces = nil;
}

@end

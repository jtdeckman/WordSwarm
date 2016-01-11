//
//  AnimationPieces.m
//  Droozle
//
//  Created by Jason Deckman on 12/28/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "AnimationPieces.h"
#import <UIKIt/UIKit.h>
#import "Constants.h"

@implementation AnimationPieces

@synthesize pieces;

- (void)setUpPieces {
    
    pieces = [[NSMutableArray alloc] initWithCapacity:500];
 
    UILabel *piece;
    
    for(int i=0; i<500; i++) {
        
        piece = [[UILabel alloc] init];
        [pieces addObject:piece];
        
        piece.layer.cornerRadius = 10.0;
        piece.clipsToBounds = YES;
        piece.opaque = NO;
        piece.layer.borderWidth = 0.0;
        piece.alpha = 1.0;
        piece.layer.borderColor = [[UIColor clearColor] CGColor];
        piece.text = @"";
        
        [piece setTextAlignment:NSTextAlignmentCenter];
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

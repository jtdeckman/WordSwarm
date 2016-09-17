//
//  LetterBar.m
//  WordSwarm
//
//  Created by Jason Deckman on 9/10/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import "LetterBar.h"

@implementation LetterBar

- (void)setUp:(CGRect)frm :(NSArray*)letterArry :(CGFloat)maxDim :(CGFloat)offset :(WordLogic*)wl {
    
    self.frame = frm;
    
    uint nlett = (uint)letterArry.count;
    
    CGFloat spcing = 0.00075*self.frame.size.width;
    
    self.backgroundColor = [UIColor clearColor];
    
    if(nlett <= 9) {
        
        maxDim *= 0.8;
        
        frm.size.width = maxDim;
        frm.size.height = frm.size.width;
        frm.origin.x = ((self.frame.size.width - 2.0*offset) - (nlett*maxDim + (nlett-1)*spcing))/2.0 + offset;
        frm.origin.y = (self.frame.size.height - 2.0*offset - maxDim)/2.0 + 2.0*offset;
        
        UILabel *lettBox;
        
        letters = [[NSMutableArray alloc] initWithCapacity:1];
        letters[0] = [[NSMutableArray alloc] initWithCapacity:letterArry.count];
        
        for(int i=0; i<nlett; i++) {
            
            lettBox = [[UILabel alloc] initWithFrame:frm];
            [self setUpPiece:lettBox :letterArry[i] :wl];
            [letters[0] addObject:lettBox];
            
            frm.origin.x += maxDim + spcing;
        }
    }
    
    else if(nlett <= 20) {
        
        maxDim *= 0.65;
        
        frm.size.width = maxDim;
        frm.size.height = frm.size.width;
        frm.origin.x = ((self.frame.size.width - 2.0*offset) - (10*maxDim + 9*spcing))/2.0 + offset;
        frm.origin.y = (self.frame.size.height - 2.0*offset - maxDim)/2.0 + 2.65*offset;
        
        UILabel *lettBox;
        
        letters = [[NSMutableArray alloc] initWithCapacity:2];
        letters[0] = [[NSMutableArray alloc] initWithCapacity:letterArry.count];
        
        for(int i=0; i<10; i++) {
            
            lettBox = [[UILabel alloc] initWithFrame:frm];
            [self setUpPiece:lettBox :letterArry[i] :wl];
            [letters[0] addObject:lettBox];
            
            frm.origin.x += maxDim + spcing;
        }
        
        uint remLett = nlett-10;
        
        letters[1] = [[NSMutableArray alloc] initWithCapacity:remLett];
        
        frm.size.width = maxDim;
        frm.size.height = frm.size.width;
        frm.origin.x = ((self.frame.size.width - 2.0*offset) - (remLett*maxDim + (remLett-1)*spcing))/2.0 + offset;
        frm.origin.y -= (frm.size.height + spcing);

        for(int i=10; i<nlett; i++) {
            
            lettBox = [[UILabel alloc] initWithFrame:frm];
            [self setUpPiece:lettBox :letterArry[i] :wl];
            [letters[1] addObject:lettBox];
            
            frm.origin.x += maxDim + spcing;
        }
    }
}

- (void)setUpPiece:(UILabel*)piece :(NSString*)letter :(WordLogic*)wordLogic {

    TileImages *tileImages = [[TileImages alloc] init];
    [tileImages setUp:piece.frame.size];
    
    int pVal = [wordLogic pointValueForLetter:letter];
    
    piece.layer.cornerRadius = 10.0;
    piece.clipsToBounds = YES;
    piece.opaque = NO;
    piece.text = letter;
    piece.textColor = [UIColor whiteColor];
    
    [piece setTextAlignment:NSTextAlignmentCenter];
    [piece setFont:[UIFont fontWithName:@"Arial" size:1.0*FONT_FACT*piece.frame.size.width]];
    
    piece.backgroundColor = [tileImages backgroundImageForIndex:pVal];
    
    [self addSubview:piece];
}

@end

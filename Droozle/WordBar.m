//
//  WordBar.m
//  Droozle
//
//  Created by Jason Deckman on 12/31/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "WordBar.h"
#import <UIKit/UIKit.h>
#import "Constants.h"

@implementation WordBar

@synthesize letters, barBackground;

- (void)setUp:(uint)nLetters :(CGRect)frame {
 
    CGRect frm = frame;
    
    frm.size.height *= WORD_BAR_FACT;
    frm.origin.y = frame.size.height;//*1.0011;
    
    barBackground = [[UILabel alloc] initWithFrame:frm];
    
    barBackground.hidden = NO;
    barBackground.layer.borderColor = [[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.8] CGColor];
    
    barBackground.layer.cornerRadius = 0.0;
    barBackground.clipsToBounds = YES;
    barBackground.opaque = NO;
}

- (void)deconstruct {
    
    UILabel *letter;
    
    for(int i=0; i<[letters count]; i++) {
        
        letter = letters[i];
        [letter removeFromSuperview];
        letter = nil;
    }
    
    [letters removeAllObjects];
    
    letters = nil;
    
    [barBackground removeFromSuperview];
    
    barBackground = nil;
}

@end

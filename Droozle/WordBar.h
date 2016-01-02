//
//  WordBar.h
//  Droozle
//
//  Created by Jason Deckman on 12/31/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WordBar : NSObject {
    
    NSMutableArray *letters;
    
    UILabel *barBackground;
    UILabel *animatePiece;
    
    CGFloat xOffset;
    
    UIColor *letterBackColor;
    
    NSString *wordCategory;
    
    uint letterPosition;
    uint numLetters;
    
    uint lettersInLevel;
    
    UIView *rootView;
    
    BOOL boxesFilled;
}

@property (nonatomic,strong) NSMutableArray *letters;
@property (nonatomic,strong) NSString *wordCategory;

@property (nonatomic,strong) UILabel *barBackground;
@property (nonatomic) BOOL boxesFilled;

- (void)setUp:(uint)nLetters :(CGRect)frame :(CGFloat)offset :(UIView*)rView;
- (void)addLetterToBox:(NSString*)letter;
- (void)clearLetters;
- (void)setUpForLevel:(int)level;

- (uint)getNumWordBarLettersForLevel:(int)level;

- (NSString*)makeWordFromLetters;

- (BOOL)animatePieceToEmptySpace:(UILabel*)origin :(CGFloat)duration :(CGFloat)delay;

- (void)deconstruct;

@end

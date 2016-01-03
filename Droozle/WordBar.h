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
    
    CGFloat xOffset;
    
    NSString *wordCategory;
    
    uint letterPosition;
    uint numLetters;
    uint lettersInLevel;
    
    UIView *rootView;
    
    BOOL boxesFilled;
    
    UIColor *letterBackColor;
    UIColor *borderColor;
    
    UIFont *letterFont;
}

@property (nonatomic,strong) NSMutableArray *letters;
@property (nonatomic,strong) NSString *wordCategory;

@property (nonatomic,strong) UILabel *barBackground;

@property (nonatomic) BOOL boxesFilled;

@property (nonatomic) uint lettersInLevel;

- (void)setUp:(uint)nLetters :(CGRect)frame :(CGFloat)offset :(UIView*)rView;
- (void)addLetterToBox:(NSString*)letter;
- (void)addLetterToBox:(NSString*)letter withDelay:(CGFloat)delay;
- (void)clearLetters;
- (void)setUpForLevel:(int)level;
- (void)makePiecesFlash:(CGFloat)duration :(CGFloat)delay;
- (void)makeBarPiecesFlash:(CGFloat)duration;

- (uint)getNumWordBarLettersForLevel:(int)level;
- (uint)numOccupied;

- (NSString*)makeWordFromLetters;

- (BOOL)animatePieceToSpace:(UILabel*)origin :(CGFloat)duration :(CGFloat)delay :(uint)ind;

- (void)deconstruct;

@end

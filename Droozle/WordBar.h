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
    UILabel *catLabel;
    
    CGFloat xOffset;
    
    UIColor *letterBackColor;
    
    uint letterPosition;
    uint numLetters;
    
    uint lettersInLevel;
}

@property (nonatomic,strong) NSMutableArray *letters;

@property (nonatomic,strong) UILabel *barBackground;
@property (nonatomic,strong) UILabel *catLabel;

- (void)setUp:(uint)nLetters :(CGRect)frame :(CGFloat)offset :(UIView*)rootView;
- (void)addLetterToBox:(NSString*)letter;
- (void)clearLetters;
- (void)setUpForLevel:(int)level;

- (uint)getNumWordBarLettersForLevel:(int)level;

- (NSString*)makeWordFromLetters;

- (void)deconstruct;

@end

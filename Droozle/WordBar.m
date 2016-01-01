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

#define BOX_SPACING_FACT 0.15

@implementation WordBar

@synthesize letters, barBackground, catLabel;

- (void)setUp:(uint)nLetters :(CGRect)frame :(CGFloat)offset :(UIView*)rootView {
 
    CGRect frm = frame;
    
    xOffset = offset;
    
    numLetters = nLetters;
    letterPosition = 0;
    
    frm.size.height *= WORD_BAR_FACT;
    frm.origin.y = frame.size.height;
    
    barBackground = [[UILabel alloc] initWithFrame:frm];
    
    barBackground.hidden = NO;
    barBackground.layer.borderColor = [[UIColor clearColor] CGColor];//[[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.8] CGColor];
    
    barBackground.layer.cornerRadius = 0.0;
    barBackground.clipsToBounds = YES;
    barBackground.opaque = NO;
    
    [rootView addSubview:barBackground];
    
    letters = [[NSMutableArray alloc] initWithCapacity:nLetters];
    
    UILabel *letterLabel;
    
    frm = barBackground.frame;

    frm.size.height *= 0.9;
    frm.size.width = frm.size.height;
    frm.origin.x = xOffset;// + 0.15*offset;
    frm.origin.y += 0.2*frm.size.height;// -= 0.1*frm.size.height;
    
    UIGraphicsBeginImageContext(frm.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"p1.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, frm.size.width, frm.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();

    letterBackColor = [UIColor colorWithPatternImage:tmpImage];
    
    for(int i=0; i<nLetters; i++) {
        
        letterLabel = [[UILabel alloc] initWithFrame:frm];
        
        [rootView addSubview:letterLabel];
        [letters addObject:letterLabel];

        letterLabel.hidden = NO;
        letterLabel.layer.cornerRadius = 7.0;
        letterLabel.clipsToBounds = YES;
        letterLabel.opaque = NO;
        
        [letterLabel setTextAlignment:NSTextAlignmentCenter];
        [letterLabel setFont:[UIFont fontWithName:@"Arial" size:1.35*FONT_FACT*frm.size.width]];
        letterLabel.textColor = [UIColor blackColor];
        
        [self makeLetterSquareUnOccupied:i];
        
        letterLabel.layer.borderWidth = 0.0f;
        
       //letterBackColor;

        frm.origin.x += frm.size.width + BOX_SPACING_FACT*xOffset;
        
        letterLabel.text = @"";
    }
    
    letterLabel = [letters objectAtIndex:0];
    
    frm.origin.x = letterLabel.frame.origin.x;
    frm.origin.x += nLetters*letterLabel.frame.size.width + (nLetters+4)*BOX_SPACING_FACT*xOffset;
    frm.size.width = barBackground.frame.size.width - letterLabel.frame.origin.x - frm.origin.x;
    frm.size.height = letterLabel.frame.size.height;
    
    catLabel = [[UILabel alloc] initWithFrame:frm];
    
    catLabel.hidden = NO;
    catLabel.layer.cornerRadius = 7.0;
    catLabel.clipsToBounds = YES;
    catLabel.opaque = NO;
    
    [catLabel setTextAlignment:NSTextAlignmentCenter];
    [catLabel setFont:[UIFont fontWithName:@"Arial" size:0.75*FONT_FACT*frm.size.width]];
    catLabel.textColor = [UIColor whiteColor];//[UIColor colorWithRed:0.9 green:0.7 blue:0.1 alpha:0.75];
    
    catLabel.layer.borderColor = [[UIColor clearColor] CGColor];//[[UIColor colorWithRed:0.7f green: 0.7f blue:0.7f alpha:0.8f] CGColor];
    
    [rootView addSubview:catLabel];
    
    catLabel.backgroundColor = [UIColor clearColor];
    
    UIGraphicsBeginImageContext(catLabel.frame.size);
    
    tmpImage = [UIImage imageNamed:@"p4.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, catLabel.frame.size.width, catLabel.frame.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    
    catLabel.backgroundColor = [UIColor colorWithPatternImage:tmpImage];
    
    catLabel.text = @"Verb";
    
   // [self addLetterToBox:@"E"];
   // [self addLetterToBox:@"A"];
   // [self addLetterToBox:@"T"];
    [self addLetterToBox:@"N"];
    [self addLetterToBox:@"C"];
    [self addLetterToBox:@"Z"];
    [self addLetterToBox:@"A"];
    
    NSLog(@"%@",[self makeWordFromLetters]);
}

- (void)addLetterToBox:(NSString*)letter {

    UILabel *square = letters[letterPosition++];
    
    if(letterPosition >= numLetters)
        letterPosition = 0;
    
    square.backgroundColor = letterBackColor;
  //  square.layer.borderColor = [[UIColor clearColor] CGColor];
    
    square.text = letter;
}

- (void)makeLetterSquareUnOccupied:(uint)squareNum {
    
    UILabel *square = letters[squareNum];
    
    square.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.35];//[UIColor clearColor];
 //   square.layer.borderColor = [[UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:0.8] CGColor];
    
    square.text = @"";
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
    
    [catLabel removeFromSuperview];
    catLabel = nil;
    
    letterBackColor = nil;
}

- (void)clearLetters {
    
    for(uint i=0; i<numLetters; i++)
        [self makeLetterSquareUnOccupied:i];
}

- (NSString*)makeWordFromLetters {

    NSMutableString *word = [[NSMutableString alloc] initWithString:@""];
    
    UILabel *letter;
    
    for(uint i=0; i<[letters count]; i++) {
        
        letter = letters[i];
        
        [word appendString:letter.text];
    }
    
    return word;
}

@end


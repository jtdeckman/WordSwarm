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

#define BOX_SPACING_FACT 0.1

@implementation WordBar

@synthesize letters, barBackground, catLabel;

- (void)setUp:(uint)nLetters :(CGRect)frame :(CGFloat)offset :(UIView*)rootView {
 
    CGRect frm = frame;
    
    xOffset = offset;
    
    frm.size.height *= WORD_BAR_FACT;
    frm.origin.y = frame.size.height;//*1.0011;
    
    barBackground = [[UILabel alloc] initWithFrame:frm];
    
    barBackground.hidden = NO;
    barBackground.layer.borderColor = [[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.8] CGColor];
    
    barBackground.layer.cornerRadius = 0.0;
    barBackground.clipsToBounds = YES;
    barBackground.opaque = NO;
    
    [rootView addSubview:barBackground];
    
    letters = [[NSMutableArray alloc] initWithCapacity:nLetters];
    
    UILabel *letterLabel;
    
    frm = barBackground.frame;

    frm.size.height *= 0.9;
    frm.size.width = frm.size.height;
    frm.origin.x = xOffset + 0.25*offset;
    frm.origin.y -= 0.1*frm.size.height;
    
   // frm.origin.y = barBackground.frame.origin.y + (barBackground.frame.size.height - frm.size.height)/2.0;
    
    for(int i=0; i<nLetters; i++) {
        
        letterLabel = [[UILabel alloc] initWithFrame:frm];
        
        letterLabel.hidden = NO;
        letterLabel.layer.cornerRadius = 4.0;
        letterLabel.clipsToBounds = YES;
        letterLabel.opaque = NO;
        
        [letterLabel setTextAlignment:NSTextAlignmentCenter];
        [letterLabel setFont:[UIFont fontWithName:@"Arial" size:1.0*FONT_FACT*frm.size.width]];
        
        letterLabel.layer.borderWidth = 2.f;
     //   letterLabel.layer.borderColor = [[UIColor colorWithRed:0.75f green: 0.75f blue:0.75f alpha:0.5f] CGColor];
        letterLabel.backgroundColor = [UIColor whiteColor];
        
        [rootView addSubview:letterLabel];
    //    [rootView bringSubviewToFront:letterLabel];
        
     //   letterLabel.backgroundColor = [UIColor colorWithRed:0.9 green:0.7 blue:0.1 alpha:0.5];
        
        [letters addObject:letterLabel];
        
        frm.origin.x += frm.size.width + BOX_SPACING_FACT*xOffset;
    }
    
    letterLabel = [letters objectAtIndex:0];
    
    frm.origin.x = letterLabel.frame.origin.x;
    frm.origin.x += nLetters*letterLabel.frame.size.width + (nLetters+4)*BOX_SPACING_FACT*xOffset;
    frm.size.width = barBackground.frame.size.width - letterLabel.frame.origin.x - frm.origin.x;
    frm.size.height = letterLabel.frame.size.height;
    
    catLabel = [[UILabel alloc] initWithFrame:frm];
    
    catLabel.hidden = NO;
    catLabel.layer.cornerRadius = 4.0;
    catLabel.clipsToBounds = YES;
    catLabel.opaque = NO;
    
    [catLabel setTextAlignment:NSTextAlignmentCenter];
    [catLabel setFont:[UIFont fontWithName:@"Arial" size:0.75*FONT_FACT*frm.size.width]];
    catLabel.textColor = [UIColor colorWithRed:0.9 green:0.7 blue:0.1 alpha:0.75];
    
    catLabel.layer.borderWidth = 2.0f;
    catLabel.layer.borderColor = [[UIColor colorWithRed:0.75f green: 0.75f blue:0.75f alpha:0.5f] CGColor];
    
    [rootView addSubview:catLabel];
    
    catLabel.backgroundColor = [UIColor clearColor];
    
    UIGraphicsBeginImageContext(catLabel.frame.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"redSquare.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, catLabel.frame.size.width, catLabel.frame.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    
    catLabel.backgroundColor = [UIColor colorWithPatternImage:tmpImage];
    
    catLabel.text = @"Word";
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
}

@end

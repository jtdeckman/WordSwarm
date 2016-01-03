//
//  Animations.m
//  Droozle
//
//  Created by Jason Deckman on 12/30/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "Animations.h"

@implementation Animations

@synthesize textBox1, textBox2;

- (void)setUp:(CGRect)frame :(CGFloat)origy :(UIView*)rview {

    CGRect frm;
    
    rootView = rview;
    
    frm = frame;
    
    frm.size.width *= 0.75;
    frm.size.height *= 0.20;
    frm.origin.x = (frame.size.width - frm.size.width)/2.0;
    frm.origin.y = origy;
    
    baseLocBox1 = frm;
    
    textBox1 = [[UILabel alloc] initWithFrame: frm];
    
    textBox1.layer.cornerRadius = 5.0;
    textBox1.clipsToBounds = YES;
    textBox1.opaque = NO;
    
    [textBox1 setTextAlignment:NSTextAlignmentCenter];
    [textBox1 setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:0.55*FONT_FACT*textBox1.frame.size.height]];
    
    textBox1.textColor = [UIColor yellowColor];
    textBox1.backgroundColor = [UIColor clearColor];
    
    textBox1.hidden = YES;
    
 // Text Box 2 (larger box)
    
    frm = frame;
    
    frm.size.width *= 0.85;
    frm.size.height *= 0.40;
    frm.origin.x = (frame.size.width - frm.size.width)/2.0;
    frm.origin.y = 2.0*origy;
    
    baseLocBox2 = frm;
    
    textBox2 = [[UILabel alloc] initWithFrame: frm];
    
    textBox2.layer.cornerRadius = 5.0;
    textBox2.clipsToBounds = YES;
    textBox2.opaque = NO;
    
    [textBox2 setTextAlignment:NSTextAlignmentCenter];
    [textBox2 setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:0.65*FONT_FACT*textBox2.frame.size.height]];
    
    textBox2.textColor = [UIColor colorWithRed:0.9 green:0.2 blue:0.2 alpha:1.0];
    textBox2.backgroundColor = [UIColor clearColor];
    
    textBox2.hidden = YES;
}

- (void)deconstruct {

    [textBox1 removeFromSuperview];
    textBox1 = nil;
    
    [textBox2 removeFromSuperview];
    textBox2 = nil;
}

- (void)animateTextBox1:(CGFloat)duration :(CGFloat)startLoc :(CGFloat)delay :(NSString*)text {
    
    CGRect frm = textBox1.frame;
    
    frm.origin.x = baseLocBox1.origin.x;
    frm.origin.y = startLoc;
    
    textBox1.frame = frm;
    textBox1.text = text;
    
    textBox1.hidden = NO;
    
    [rootView addSubview:textBox1];
    
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        textBox1.frame = baseLocBox1;
        
    } completion:^(BOOL finished) {
    
        textBox1.hidden = YES;
        [textBox1 removeFromSuperview];
      
    }];
}

- (void)animateTextBox2:(CGFloat)duration :(CGFloat)startLoc :(CGFloat)endLoc :(CGFloat)delay :(NSString*)text {
    
    CGRect frm = textBox2.frame;
    CGRect endFrm = textBox2.frame;
    
    endFrm.origin.y = endLoc;
    
    frm.origin.x = baseLocBox2.origin.x;
    frm.origin.y = startLoc;
    
    textBox2.frame = frm;
    textBox2.text = text;
    textBox2.alpha = 0.2f;
    
    textBox2.hidden = NO;
    
    [rootView addSubview:textBox2];
    
    [UIView animateWithDuration:duration delay:delay options:NO animations:^{
        
        textBox2.frame = endFrm;
        textBox2.alpha = 1.0f;
        
    } completion:^(BOOL finished) {
        
       // textBox2.hidden = YES;
       // [textBox2 removeFromSuperview];
        
    }];
}

@end

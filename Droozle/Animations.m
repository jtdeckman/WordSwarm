//
//  Animations.m
//  Droozle
//
//  Created by Jason Deckman on 12/30/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "Animations.h"

@implementation Animations

@synthesize textBox1;

- (void)setUp:(CGRect)frame :(CGFloat)origy {

    CGRect frm;
    
    frm = frame;
    
    frm.size.width *= 0.65;
    frm.size.height *= 0.20;
    frm.origin.x = (frame.size.width - frm.size.width)/2.0;
    frm.origin.y = origy;
    
    baseLocBox1 = frm;
    
    textBox1 = [[UILabel alloc] initWithFrame: frm];
    
    textBox1.layer.cornerRadius = 5.0;
    textBox1.clipsToBounds = YES;
    textBox1.opaque = NO;
    
    [textBox1 setTextAlignment:NSTextAlignmentCenter];
    [textBox1 setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:0.45*FONT_FACT*textBox1.frame.size.height]];
    
    textBox1.textColor = [UIColor yellowColor];
    textBox1.backgroundColor = [UIColor clearColor];
    
    textBox1.hidden = YES;
}

- (void)deconstruct {

    [textBox1 removeFromSuperview];
    textBox1 = nil;
}

- (void)animateTextBox1:(CGFloat)duration :(CGFloat)startLoc :(CGFloat)delay :(NSString*)text {
    
    CGRect frm = textBox1.frame;
    
    frm.origin.y = 0.35*startLoc;
    frm.origin.x = baseLocBox1.origin.x;
    
    textBox1.frame = frm;
    textBox1.text = text;
    
    textBox1.hidden = NO;
    
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        textBox1.frame = baseLocBox1;
        
    } completion:^(BOOL finished) {
    
        textBox1.hidden = YES;
      
    }];
}

@end

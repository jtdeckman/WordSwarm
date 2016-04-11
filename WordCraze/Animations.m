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
    textBox1.numberOfLines = 2;
    textBox1.lineBreakMode = NSLineBreakByWordWrapping;
    
    [textBox1 setTextAlignment:NSTextAlignmentCenter];
    [textBox1 setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:0.65*FONT_FACT*textBox1.frame.size.height]];
    
    textBox1.textColor = [UIColor yellowColor];
    textBox1.backgroundColor = [UIColor clearColor];
    
    textBox1.hidden = YES;
    
 // Text Box 2 (larger box)
    
    frm = frame;
    
    frm.size.width *= 0.85;
    frm.size.height *= 0.40;
    frm.origin.x = (rootView.frame.size.width - frm.size.width)/2.0;
    frm.origin.y = 2.0*origy;
    
    baseLocBox2 = frm;
    
    textBox2 = [[UILabel alloc] initWithFrame: frm];
    
    textBox2.layer.cornerRadius = 5.0;
    textBox2.clipsToBounds = YES;
    textBox2.opaque = NO;
    //textBox2.numberOfLines = 0;
    
    [textBox2 setTextAlignment:NSTextAlignmentCenter];
    [textBox2 setFont:[UIFont fontWithName:@"Copperplate" size:0.45*FONT_FACT*textBox2.frame.size.height]];
    
    textBox2.textColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:1.0];
    textBox2.backgroundColor = [UIColor clearColor];
    
    textBox2.hidden = YES;
    
    frm = textBox1.frame;
    
    frm.size.width *= 1.25;
    frm.size.height *= 1.25;
    frm.origin.x = (rootView.frame.size.width - frm.size.width)/2.0;
    frm.origin.y = 3.0*origy;
    
    baseLocBox3 = frm;
    
    textBox3 = [[UILabel alloc] initWithFrame: frm];
    
    textBox3.layer.cornerRadius = 5.0;
    textBox3.clipsToBounds = YES;
    textBox3.opaque = NO;
    
    [textBox3 setTextAlignment:NSTextAlignmentCenter];
    [textBox3 setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:0.5*FONT_FACT*textBox3.frame.size.height]];
    
    textBox3.textColor = [UIColor yellowColor];//[UIColor colorWithRed:0.9 green:0.2 blue:0.2 alpha:1.0];
    textBox3.backgroundColor = [UIColor clearColor];
    
    textBox3.hidden = YES;
    
    textBox4 = [[UILabel alloc] initWithFrame: frm];
    
    textBox4.layer.cornerRadius = 5.0;
    textBox4.clipsToBounds = YES;
    textBox4.opaque = NO;
    
    [textBox4 setTextAlignment:NSTextAlignmentCenter];
    [textBox4 setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:0.55*FONT_FACT*textBox3.frame.size.height]];
    
    textBox4.textColor = [UIColor colorWithRed:0.9 green:0.2 blue:0.2 alpha:1.0];
    textBox4.backgroundColor = [UIColor clearColor];
    
    textBox4.hidden = YES;

}

- (void)deconstruct {

    [textBox1 removeFromSuperview];
    textBox1 = nil;
    
    [textBox2 removeFromSuperview];
    textBox2 = nil;
    
    [textBox3 removeFromSuperview];
    textBox3 = nil;
    
    [textBox4 removeFromSuperview];
    textBox4 = nil;
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

- (void)animateTextBox3:(CGFloat)duration :(CGFloat)startLoc :(CGFloat)endLoc :(CGFloat)delay :(NSString*)text {
    
    CGRect frm = textBox3.frame;
    CGRect endFrm = textBox3.frame;
    
    endFrm.origin.y = endLoc;
    
    frm.origin.x = baseLocBox3.origin.x;
    frm.origin.y = startLoc;
    
    textBox3.frame = frm;
    textBox3.text = text;
 //   textBox3.alpha = 0.2f;
    
    textBox3.hidden = NO;
    
    [rootView addSubview:textBox3];
    
    [UIView animateWithDuration:duration delay:delay options:NO animations:^{
        
        textBox3.frame = endFrm;
   //     textBox3.alpha = 1.0f;
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(hideTextBox3) withObject:nil afterDelay:0.4f];
    }];
}

- (void)animateTextBox4:(CGFloat)duration :(CGFloat)startLoc :(CGFloat)endLoc :(CGFloat)delay :(NSString*)text {
    
    CGRect frm = textBox4.frame;
    CGRect endFrm = textBox4.frame;
    
    endFrm.origin.y = endLoc;
    
    frm.origin.x = baseLocBox3.origin.x;
    frm.origin.y = startLoc;
    
    textBox4.frame = frm;
    textBox4.text = text;
    
    textBox4.hidden = NO;
    
    [rootView addSubview:textBox4];
    
    [UIView animateWithDuration:duration delay:delay options:NO animations:^{
        
        textBox4.frame = endFrm;
        //     textBox3.alpha = 1.0f;
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(hideTextBox4) withObject:nil afterDelay:0.4f];
    }];
}

- (void)hideTextBox3 {
    
     textBox3.hidden = YES;
     [textBox3 removeFromSuperview];
}

- (void)hideTextBox4 {
    
    textBox4.hidden = YES;
    [textBox4 removeFromSuperview];
}


@end

//
//  HowToPage.m
//  WordSwarm
//
//  Created by Jason Deckman on 9/26/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import "HowToPage.h"
#import "Constants.h"

@implementation HowToPage

@synthesize checkBox;

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
    
    if(CGRectContainsPoint(checkBox.frame, location)) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if([checkBox.text isEqualToString:@""]) {
            
            [defaults setBool:YES forKey:@"howToScreenSeen"];
            checkBox.text = @"x";
        }
        
        else {
            
            [defaults setBool:NO forKey:@"howToScreenSeen"];
            checkBox.text = @"";
        }
    }
}

- (void)setUp {
    
    CGRect frm = self.frame;
    
    self.layer.cornerRadius = 5.0;
    self.clipsToBounds = YES;
    
    if(self.frame.size.width/self.frame.size.height > 0.74) {
        
        frm.size.width = 0.5625*frm.size.height;
        frm.origin.x = (self.frame.size.width - frm.size.width)/2.0;
    }
    
    screen = [[UIImageView alloc] initWithFrame:frm];
    screen.image = [UIImage imageNamed:@"HowToScreen-1.png"];
    
    [self addSubview:screen];
    
    frm.size.width = 0.061*self.frame.size.width;
    frm.size.height = frm.size.width;
    
    frm.origin.x = 0.35*self.frame.size.width;
    frm.origin.y = 0.895*self.frame.size.height;
    
    checkBox = [[UILabel alloc] initWithFrame:frm];
    
    checkBox.layer.cornerRadius = 2.50;
    checkBox.clipsToBounds = YES;
    
    checkBox.textColor = [UIColor redColor];
    checkBox.layer.borderColor = [[UIColor whiteColor] CGColor];
    checkBox.layer.borderWidth = 0.85;
    checkBox.backgroundColor = [UIColor whiteColor];
    checkBox.hidden = NO;
    checkBox.text = @"";
    [checkBox setTextAlignment:NSTextAlignmentCenter];
    [checkBox setFont:[UIFont fontWithName:@"Copperplate" size:3.0*FONT_FACT*frm.size.width]];
    
    [self addSubview:checkBox];
    [self bringSubviewToFront:checkBox];
    
    frm.size.width = 0.15*self.frame.size.width;
    frm.size.height = 0.5*frm.size.width;
    frm.origin.x = self.frame.size.width - 1.25*frm.size.width; //(self.frame.size.width - frame.size.width)/2.0;
    frm.origin.y = self.frame.size.height - 1.5*frm.size.height;
    
    _doneLabel = [[UILabel alloc] initWithFrame:frm];
    
    _doneLabel.layer.cornerRadius = 2.50;
    _doneLabel.clipsToBounds = YES;
    _doneLabel.opaque = NO;
    
    _doneLabel.textColor = [UIColor redColor];
    _doneLabel.layer.borderColor = [[UIColor redColor] CGColor];
    _doneLabel.layer.borderWidth = 0.85;
    _doneLabel.hidden = NO;
    _doneLabel.text = @"Done";
    
    [_doneLabel setTextAlignment:NSTextAlignmentCenter];
    [_doneLabel setFont:[UIFont fontWithName:@"Copperplate" size:0.7*FONT_FACT*frm.size.width]];
    
    [self addSubview:_doneLabel];
    [self bringSubviewToFront:_doneLabel];
}

@end

//
//  MenuView.m
//  Droozle
//
//  Created by Jason Deckman on 12/25/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "MenuView.h"
#import "Constants.h"

@implementation MenuView

@synthesize nwGameLabel, settingsLabel, howToLabel, statsLabel;

- (void)setUpView {
    
    // New game Label
    
    CGRect viewFrame;
    
    JDColor clr;
    
    clr.red = 0.8;
    clr.green = 0.8;
    clr.blue = 0.8;
    
    viewFrame.size.width = 0.4*self.frame.size.width;
    viewFrame.size.height = 0.14*self.frame.size.height;
    viewFrame.origin.x = (self.frame.size.width - viewFrame.size.width)/2.0;
    viewFrame.origin.y = 0.075*self.frame.size.height;
    
    settingsLabel = [[UILabel alloc] initWithFrame:viewFrame];
    
    settingsLabel.hidden = NO;
    settingsLabel.layer.cornerRadius = 3.0;
    settingsLabel.clipsToBounds = YES;
    settingsLabel.backgroundColor = [UIColor clearColor];
    //   settingsLabel.layer.borderColor = [[UIColor redColor] CGColor];
    
    settingsLabel.layer.borderColor = [[UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0] CGColor];
    
    settingsLabel.layer.borderWidth = 1.0f;
    //  settingsLabel.textColor = [UIColor redColor];
    settingsLabel.textColor = [UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0];
    
    settingsLabel.text = @"Settings";
    
    [settingsLabel setTextAlignment:NSTextAlignmentCenter];
    [settingsLabel setFont:[UIFont fontWithName:@"Arial" size:0.4*FONT_FACT*viewFrame.size.width]];
    
    [self addSubview:settingsLabel];
    
    viewFrame.origin.y = 2.0*settingsLabel.frame.origin.y + 0.75*viewFrame.size.height;
    
    nwGameLabel = [[UILabel alloc] initWithFrame:viewFrame];
    
    nwGameLabel.hidden = NO;
    nwGameLabel.layer.cornerRadius = 3.0;
    nwGameLabel.clipsToBounds = YES;
    nwGameLabel.backgroundColor = [UIColor clearColor];
    //   nwGameLabel.layer.borderColor = [[UIColor redColor] CGColor];
    
    nwGameLabel.layer.borderColor = [[UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0] CGColor];
    
    nwGameLabel.layer.borderWidth = 1.0f;
    //  nwGameLabel.textColor = [UIColor redColor];
    nwGameLabel.textColor = [UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0];
    
    nwGameLabel.text = @"New Game";
    
    [nwGameLabel setTextAlignment:NSTextAlignmentCenter];
    [nwGameLabel setFont:[UIFont fontWithName:@"Arial" size:0.4*FONT_FACT*viewFrame.size.width]];
    
    [self addSubview:nwGameLabel];
    
    viewFrame.origin.y = viewFrame.origin.y + settingsLabel.frame.origin.y + 0.75*viewFrame.size.height;
    
    howToLabel = [[UILabel alloc] initWithFrame:viewFrame];
    
    howToLabel.hidden = NO;
    howToLabel.layer.cornerRadius = 3.0;
    howToLabel.clipsToBounds = YES;
    howToLabel.backgroundColor = [UIColor clearColor];
    //   howToLabel.layer.borderColor = [[UIColor redColor] CGColor];
    
    howToLabel.layer.borderColor = [[UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0] CGColor];
    
    howToLabel.layer.borderWidth = 1.0f;
    //  howToLabel.textColor = [UIColor redColor];
    howToLabel.textColor = [UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0];
    
    howToLabel.text = @"How to Play";
    
    [howToLabel setTextAlignment:NSTextAlignmentCenter];
    [howToLabel setFont:[UIFont fontWithName:@"Arial" size:0.4*FONT_FACT*viewFrame.size.width]];
    
    [self addSubview:howToLabel];
    
    
    // Stats label
    
    viewFrame.origin.y = viewFrame.origin.y + settingsLabel.frame.origin.y + 0.75*viewFrame.size.height;
    
    statsLabel = [[UILabel alloc] initWithFrame:viewFrame];
    
    statsLabel.hidden = NO;
    statsLabel.layer.cornerRadius = 3.0;
    statsLabel.clipsToBounds = YES;
    statsLabel.backgroundColor = [UIColor clearColor];
    //   statsLabel.layer.borderColor = [[UIColor redColor] CGColor];
    
    statsLabel.layer.borderColor = [[UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0] CGColor];
    
    statsLabel.layer.borderWidth = 1.0f;
    //  statsLabel.textColor = [UIColor redColor];
    statsLabel.textColor = [UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0];
    
    statsLabel.text = @"Game Stats";
    
    [statsLabel setTextAlignment:NSTextAlignmentCenter];
    [statsLabel setFont:[UIFont fontWithName:@"Arial" size:0.4*FONT_FACT*viewFrame.size.width]];
    
    [self addSubview:statsLabel];
    
}

@end

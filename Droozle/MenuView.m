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
    
    viewFrame.size.width = 0.3*self.frame.size.width;
    viewFrame.size.height = 0.12*self.frame.size.height;
    viewFrame.origin.x = (self.frame.size.width - viewFrame.size.width)/2.0;
    viewFrame.origin.y = 0.075*self.frame.size.height;
    
    settingsLabel = [[UILabel alloc] initWithFrame:viewFrame];
    
    UIGraphicsBeginImageContext(viewFrame.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"redSquare.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();

    settingsLabel.hidden = NO;
    settingsLabel.layer.cornerRadius = 3.0;
    settingsLabel.clipsToBounds = YES;
    settingsLabel.backgroundColor = [UIColor colorWithPatternImage:tmpImage];//[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.15];[UIColor clearColor];
    //   settingsLabel.layer.borderColor = [[UIColor redColor] CGColor];
    
    settingsLabel.layer.borderColor = [[UIColor clearColor] CGColor];//[[UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0] CGColor];
    
    settingsLabel.layer.borderWidth = 1.0f;
    //  settingsLabel.textColor = [UIColor redColor];
    settingsLabel.textColor = [UIColor colorWithRed:0.9f green:0.6f blue:0.3f alpha:1.0];//[UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0];
    settingsLabel.text = @"Settings";
    
    [settingsLabel setTextAlignment:NSTextAlignmentCenter];
    [settingsLabel setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:0.4*FONT_FACT*viewFrame.size.width]];
    
    [self addSubview:settingsLabel];
    
    viewFrame.origin.y = 2.0*settingsLabel.frame.origin.y + 0.75*viewFrame.size.height;
    
    nwGameLabel = [[UILabel alloc] initWithFrame:viewFrame];
    
    nwGameLabel.hidden = NO;
    nwGameLabel.layer.cornerRadius = 3.0;
    nwGameLabel.clipsToBounds = YES;
    nwGameLabel.backgroundColor = settingsLabel.backgroundColor; //[UIColor clearColor];
   
    
    nwGameLabel.layer.borderColor = [[UIColor clearColor] CGColor]; //[[UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0] CGColor];
    
    nwGameLabel.layer.borderWidth = 1.0f;
    nwGameLabel.textColor = settingsLabel.textColor;//[UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0];
   
    nwGameLabel.text = @"New Game";
    
    [nwGameLabel setTextAlignment:NSTextAlignmentCenter];
  //  [nwGameLabel setFont:[UIFont fontWithName:@"Arial" size:0.4*FONT_FACT*viewFrame.size.width]];
    nwGameLabel.font = settingsLabel.font;
    
    [self addSubview:nwGameLabel];
    
    viewFrame.origin.y = viewFrame.origin.y + settingsLabel.frame.origin.y + 0.75*viewFrame.size.height;
    
    howToLabel = [[UILabel alloc] initWithFrame:viewFrame];
    
    howToLabel.hidden = NO;
    howToLabel.layer.cornerRadius = 3.0;
    howToLabel.clipsToBounds = YES;
    howToLabel.backgroundColor = settingsLabel.backgroundColor;// [UIColor clearColor];
    howToLabel.layer.borderColor = [[UIColor clearColor] CGColor]; //[[UIColor redColor] CGColor];
    
  //  howToLabel.layer.borderColor = [[UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0] CGColor];
    
    howToLabel.layer.borderWidth = 1.0f;
  //  howToLabel.textColor = [UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0];
    
    howToLabel.text = @"How to Play";
    
    [howToLabel setTextAlignment:NSTextAlignmentCenter];
   // [howToLabel setFont:[UIFont fontWithName:@"Arial" size:0.4*FONT_FACT*viewFrame.size.width]];
    howToLabel.font = settingsLabel.font;
    howToLabel.textColor = settingsLabel.textColor;
    
    [self addSubview:howToLabel];
    
    
    // Stats label
    
    viewFrame.origin.y = viewFrame.origin.y + settingsLabel.frame.origin.y + 0.75*viewFrame.size.height;
    
    statsLabel = [[UILabel alloc] initWithFrame:viewFrame];
    
    statsLabel.hidden = NO;
    statsLabel.layer.cornerRadius = 3.0;
    statsLabel.clipsToBounds = YES;
    statsLabel.backgroundColor = settingsLabel.backgroundColor;//[UIColor clearColor];
    statsLabel.layer.borderColor = [[UIColor clearColor] CGColor];
    
  //  statsLabel.layer.borderColor = [[UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0] CGColor];
    
    statsLabel.layer.borderWidth = 1.0f;
   // statsLabel.textColor = [UIColor colorWithRed:clr.red green:clr.green blue:clr.blue alpha:1.0];
    statsLabel.textColor = howToLabel.textColor;
    
    statsLabel.text = @"Game Stats";
    
    [statsLabel setTextAlignment:NSTextAlignmentCenter];
   // [statsLabel setFont:[UIFont fontWithName:@"Arial" size:0.4*FONT_FACT*viewFrame.size.width]];
    statsLabel.font = howToLabel.font;
    
    [self addSubview:statsLabel];
    
}

@end

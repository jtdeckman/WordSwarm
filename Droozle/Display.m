//
//  Display.m
//  Droozle
//
//  Created by Jason Deckman on 9/21/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import "Display.h"

@implementation Display

@synthesize topBar, boardView;

- (void)initDisplay:(CGRect)viewFrame : (UIViewController*)rootViewCont {

    CGRect frm;
    
    frm = viewFrame;
    frm.size.height *= 0.25;
    
    topBar = [[UIView alloc] initWithFrame:frm];
    
    [rootViewCont.view addSubview:topBar];
    
    frm.size.height = viewFrame.size.height - topBar.frame.size.height;
    frm.origin.y = topBar.frame.size.height;
    
    boardView = [[UIView alloc] initWithFrame:frm];
    
    [rootViewCont.view addSubview:boardView];
    
    topBar.hidden = NO;
    
    [self setUpColors];
}

- (void)setUpColors {

    Colors *colors = [[Colors alloc] init];
    
    [colors setUpColors];
    
    topBar.backgroundColor = [UIColor colorWithRed:colors.topBarBackgroundColor.red green:colors.topBarBackgroundColor.green blue:colors.topBarBackgroundColor.blue alpha:1.0f];
    
    boardView.backgroundColor = [UIColor colorWithRed:colors.boardViewBackgroundColor.red green:colors.boardViewBackgroundColor.green blue:colors.boardViewBackgroundColor.blue alpha:1.0f];

}

@end

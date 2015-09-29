//
//  Display.m
//  Droozle
//
//  Created by Jason Deckman on 9/21/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import "Display.h"

@implementation Display

@synthesize topBar, bottomBar, boardView;

- (void)initDisplay:(CGRect)viewFrame : (UIViewController*)rootViewCont {

    CGRect frm;
    
    frm = viewFrame;
    frm.size.height *= 0.20;
    
    topBar = [[UIView alloc] initWithFrame:frm];
    
    [rootViewCont.view addSubview:topBar];
    
    frm = topBar.frame;
    frm.size.height *= 0.75;
    frm.origin.y = viewFrame.size.height - frm.size.height;
    
    bottomBar = [[UIView alloc] initWithFrame:frm];
    
    [rootViewCont.view addSubview:bottomBar];
    
    frm.size.height = viewFrame.size.height - topBar.frame.size.height- bottomBar.frame.size.height;
    frm.origin.y = topBar.frame.size.height;
    
    boardView = [[UIView alloc] initWithFrame:frm];
    
    [rootViewCont.view addSubview:boardView];
    
    topBar.hidden = NO;
    bottomBar.hidden = NO;
    boardView.hidden = NO;
    
    [self setUpColors];
}

- (void)setUpColors {

    Colors *colors = [[Colors alloc] init];
    
    [colors setUpColors];
    
    topBar.backgroundColor = [UIColor colorWithRed:colors.topBarBackgroundColor.red green:colors.topBarBackgroundColor.green blue:colors.topBarBackgroundColor.blue alpha:1.0f];
    
    bottomBar.backgroundColor = [UIColor colorWithRed:colors.bottomBarBackgroundColor.red green:colors.bottomBarBackgroundColor.green blue:colors.bottomBarBackgroundColor.blue alpha:1.0f];
    
    boardView.backgroundColor = [UIColor colorWithRed:colors.boardViewBackgroundColor.red green:colors.boardViewBackgroundColor.green blue:colors.boardViewBackgroundColor.blue alpha:1.0f];

}

- (CGRect)initBoardView: (CGRect)viewFrame{

    CGRect boardFrm;
    
    boardFrm.origin.x = 0.05*viewFrame.size.width;
    boardFrm.origin.y = boardView.frame.origin.y + 0.1*boardView.frame.size.height;
    boardFrm.size.height = 0.95*boardView.frame.size.height;
    boardFrm.size.width = 0.7*viewFrame.size.width;

    return boardFrm;
}

@end

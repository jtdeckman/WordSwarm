//
//  ViewController.h
//  Droozle
//
//  Created by Jason Deckman on 9/4/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Display.h"
#import "Constants.h"
#import "Board.h"
#import "GamePlay.h"
#import "StatsView.h"
#import "SettingsViewController.h"

@interface ViewController : UIViewController {

    Display *display;
    Board *board;
    GamePlay *gamePlay;
    Space *touchedSpace;
    
    NSTimer *gameTimer;
    NSTimer *alertTimer;
    
    int rowOrig, rowNew;
    
    UIColor *tmpColor;
    
    BOOL animating;
    BOOL prevViewSettings;
}

- (void)saveDefaults;

@end


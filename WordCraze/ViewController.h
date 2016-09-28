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
#import "HowToScreen.h"
#import "HowToPage.h"
#import "LetterBar.h"

@interface ViewController : UIViewController {

    Display *display;
    Board *board;
    GamePlay *gamePlay;
    
    Space *touchedSpace;
    Space *highlightedSpace1;
    Space *highlightedSpace2;
    
    NSTimer *gameTimer;
    NSTimer *alertTimer;
    
    int rowOrig, rowNew;
    
    uint bottomRow;
    
    UIColor *tmpColor;
    
    BOOL animating;
    BOOL prevViewSettings;
    BOOL swiping;
    BOOL howToSeen;
    BOOL initView;
    
    NSMutableString *currentWord;
    
    NSMutableArray *highlightedPieces;
    NSMutableArray *highlightLabels;
    
    NSMutableArray *topSpaces;
    NSMutableArray *newLetters;
    
    UIActivityIndicatorView *spinner;
    
    LetterBar *letterBox;
    
    HowToPage *howToPage;
}

- (void)saveDefaults;

@end


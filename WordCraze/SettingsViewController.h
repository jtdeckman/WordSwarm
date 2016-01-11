//
//  SettingsViewController.h
//  Droozle
//
//  Created by Jason Deckman on 12/29/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface SettingsViewController : UIViewController {
    
    UILabel *acceptButton;
    
  //  UILabel *playModeBox;
    UILabel *difficultyBox;
    
  //  UILabel *playModeLabel;
    UILabel *difficultyLabel;
    
 //   UISegmentedControl *playModeControl;
    UISegmentedControl *difficultyControl;
}

- (void)setUp;
- (void)deconstruct;

@end

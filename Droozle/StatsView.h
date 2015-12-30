//
//  StatsView.h
//  Droozle
//
//  Created by Jason Deckman on 12/29/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface StatsView : UIViewController {
    
    UILabel *highScoreBox;
    UILabel *highScoreLabel;
    UILabel *highScore;
    
    UILabel *highestLevelBox;
    UILabel *highestLevelLabel;
    UILabel *highestLevel;
    
    UILabel *highestWordScoreBox;
    UILabel *highestWordScoreLabel;
    UILabel *highestWordScore;
}

- (void)setUp;

@end

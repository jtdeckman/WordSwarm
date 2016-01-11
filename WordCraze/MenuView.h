//
//  MenuView.h
//  Droozle
//
//  Created by Jason Deckman on 12/25/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface MenuView : UIView {
    
    UILabel *nwGameLabel;
    UILabel *settingsLabel;
    UILabel *howToLabel;
    UILabel *statsLabel;
}

@property (nonatomic, strong) UILabel *nwGameLabel;
@property (nonatomic, strong) UILabel *settingsLabel;
@property (nonatomic, strong) UILabel *howToLabel;
@property (nonatomic, strong) UILabel *statsLabel;

- (void)setUpView;

@end

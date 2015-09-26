//
//  Display.h
//  Droozle
//
//  Created by Jason Deckman on 9/21/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Colors.h"

@interface Display : NSObject {
    
    UIView *topBar;
    UIView *boardView;

}

@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIView *boardView;

- (void)initDisplay:(CGRect)viewFrame :(UIViewController*)rootViewCont;
- (void)setUpColors;

@end

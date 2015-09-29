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
    UIView *bottomBar;
    UIView *boardView;
}

@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIView *boardView;
@property (nonatomic, strong) UIView *bottomBar;

- (void)initDisplay:(CGRect)viewFrame :(UIViewController*)rootViewCont;
- (void)setUpColors;

- (CGRect)initBoardView:(CGRect)viewFrame;

@end

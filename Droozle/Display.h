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
#import "Space.h"

@interface Display : NSObject {
    
    UIView *topBar;
    UIView *bottomBar;
    UIView *boardView;
    
    UILabel *floatPiece;
    UILabel *addPiece;
    
    UIImage *floatBackImage;
}

@property(nonatomic, strong) UIView *topBar;
@property(nonatomic, strong) UIView *boardView;
@property(nonatomic, strong) UIView *bottomBar;

@property (nonatomic, strong) UILabel *floatPiece;
@property (nonatomic, strong) UILabel *addPiece;

- (void)initDisplay:(CGRect)viewFrame :(UIViewController*)rootViewCont;
- (void)setUpColors;
- (void)setUpFloatPieces:(CGRect)pcFrm :(UIView*)rootView;
- (void)changeFloatPieceLoc: (CGPoint)newLoc;
- (void)configureFloatPiece: (Space*)space :(UIView*)rootView;

- (CGRect)initBoardView:(CGRect)viewFrame;

@end

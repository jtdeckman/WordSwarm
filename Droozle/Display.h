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
#import "MenuView.h"

@interface Display : NSObject {
    
    UIView *topBar;
    UIView *bottomBar;
    UIView *boardView;
    
    MenuView *menuView;
    
    UILabel *floatPiece;
    UILabel *addPiece;
    UILabel *scoreLabel;
    UILabel *score;
    
    UIImage *floatBackImage;
    
    UIImageView *menuBar;
    
    CGSize floatPieceOffSet;
    CGSize addPieceOffSet;
    
    CGRect baseAddPiece;
}

@property(nonatomic, strong) UIView *topBar;
@property(nonatomic, strong) UIView *boardView;
@property(nonatomic, strong) UIView *bottomBar;

@property(nonatomic, strong) MenuView *menuView;

@property(nonatomic, strong) UILabel *floatPiece;
@property(nonatomic, strong) UILabel *addPiece;

@property(nonatomic, strong) UIImageView *menuBar;

- (void)initDisplay:(CGRect)viewFrame :(UIViewController*)rootViewCont;
- (void)setUpColors:(UIView*)rootView;
- (void)setUpFloatPieces:(CGRect)pcFrm :(UIView*)rootView;
- (void)changeFloatPieceLoc: (CGPoint)newLoc;
- (void)configureFloatPiece: (Space*)space :(UIView*)rootView;
- (void)changeAddPieceLoc: (CGPoint)newLoc;
- (void)resetAddPiece;
- (void)deconstruct;
- (void)updateScore:(int)newScore;

- (CGRect)initBoardView:(CGRect)viewFrame;

@end

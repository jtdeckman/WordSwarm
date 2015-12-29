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
#import "GamePlay.h"
#import "AnimationPieces.h"

@interface Display : NSObject {
    
    UIView *topBar;
    UIView *bottomBar;
    UIView *boardView;
    UIView *rootView;
    UIView *alertView;
    
    MenuView *menuView;
    
    UILabel *floatPiece;
    UILabel *addPiece;
    
    UILabel *scoreBox;
    UILabel *levelBox;
    UILabel *nextBox;
    
    UILabel *score;
    UILabel *level;
    UILabel *nextScore;
    
    UILabel *scoreLabel;
    UILabel *levelLabel;
    UILabel *nextScoreLabel;
    
    UILabel *floatScore;
    UILabel *bombPiece;
    UILabel *strikePiece;
    
    UIImage *floatBackImage;
    
    UIImageView *menuBar;
    
    CGSize floatPieceOffSet;
    CGSize addPieceOffSet;
    
    CGRect baseAddPiece;
    
    GamePlay *gamePlay;
    
    NSMutableArray *piecesToAnimate;
    
    AnimationPieces *animationPieces;
}

@property(nonatomic, strong) UIView *topBar;
@property(nonatomic, strong) UIView *boardView;
@property(nonatomic, strong) UIView *bottomBar;

@property(nonatomic, strong) MenuView *menuView;
@property(nonatomic, strong) GamePlay *gamePlay;

@property(nonatomic, strong) UILabel *floatPiece;
@property(nonatomic, strong) UILabel *addPiece;

@property(nonatomic, strong) UILabel *bombPiece;
@property(nonatomic, strong) UILabel *strikePiece;

@property(nonatomic, strong) UIImageView *menuBar;

@property(nonatomic, strong) NSMutableArray *piecesToAnimate;

- (void)initDisplay:(CGRect)viewFrame :(UIViewController*)rootViewCont;
- (void)setUpColors;
- (void)setUpFloatPieces:(CGRect)pcFrm;
- (void)changeFloatPieceLoc: (CGPoint)newLoc;
- (void)configureFloatPiece: (Space*)space;
- (void)changeAddPieceLoc: (CGPoint)newLoc;
- (void)resetAddPiece;
- (void)deconstruct;
- (void)updateScore;
- (void)hideAlertView;
- (void)updateLevelValues;

- (void)makePiecesFlash;
- (void)resetAnimatedPieces;
- (void)animateAlertView;

- (void)animatePlusScore:(int)addedPoints;
- (void)animateMinusScore:(int)subtractedPoints;

- (CGRect)initBoardView:(CGRect)viewFrame;

@end

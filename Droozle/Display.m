//
//  Display.m
//  Droozle
//
//  Created by Jason Deckman on 9/21/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import "Display.h"

@implementation Display

@synthesize topBar, bottomBar, boardView;
@synthesize floatPiece, addPiece;
@synthesize menuBar, menuView;

- (void)initDisplay:(CGRect)viewFrame : (UIViewController*)rootViewCont {

    CGRect frm;
    
    rootView = rootViewCont.view;
    
    frm = viewFrame;
    frm.size.height *= 0.125;
    
    topBar = [[UIView alloc] initWithFrame:frm];
    
    [rootView addSubview:topBar];
    
    frm = topBar.frame;
    frm.size.height *= 1.1;
    frm.origin.y = viewFrame.size.height - frm.size.height;
    
    bottomBar = [[UIView alloc] initWithFrame:frm];
    
    [rootView addSubview:bottomBar];
    
    frm.size.height = viewFrame.size.height - topBar.frame.size.height - bottomBar.frame.size.height;
    frm.origin.y = topBar.frame.size.height;
    
    boardView = [[UIView alloc] initWithFrame:frm];
    
    [rootView addSubview:boardView];
    
    frm.size.height = 0.7*rootViewCont.view.frame.size.height;
    frm.origin.y = rootViewCont.view.frame.size.height - frm.size.height;
    
    menuView = [[MenuView alloc] initWithFrame:frm];
    
    [menuView setUpView];
    
    [rootView addSubview:menuView];
    [rootView bringSubviewToFront:menuView];
    
    alertView = [[UIView alloc] initWithFrame:rootView.frame];
    alertView.backgroundColor = [UIColor colorWithRed:0.6 green:0.2 blue:0.2 alpha:0.75];
    
    [rootView addSubview:alertView];
    
    topBar.hidden = NO;
    bottomBar.hidden = NO;
    boardView.hidden = NO;
    
    menuView.hidden = YES;
    alertView.hidden = YES;
    
    frm.size.height = 0.35*topBar.frame.size.height;
    frm.size.width = 0.35*topBar.frame.size.width;
    frm.origin.x = 0.05*topBar.frame.size.width;
    frm.origin.y = topBar.frame.origin.y + (topBar.frame.size.height - frm.size.height)/2.0;
    
    scoreLabel = [[UILabel alloc] initWithFrame:frm];
    scoreLabel.hidden = NO;
    scoreLabel.layer.cornerRadius = 10.0;
    scoreLabel.clipsToBounds = YES;
    scoreLabel.opaque = NO;
    
    [scoreLabel setTextAlignment:NSTextAlignmentLeft];
    [scoreLabel setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:1.5*FONT_FACT*frm.size.height]];
    
    [rootView addSubview:scoreLabel];
    
    scoreLabel.text = @"Score:";
    
    frm.origin.x += 0.65*scoreLabel.frame.size.width;
    frm.origin.y += 0.01*frm.origin.y;
    
    score = [[UILabel alloc] initWithFrame:frm];
    score.hidden = NO;
    score.layer.cornerRadius = 10.0;
    score.clipsToBounds = YES;
    score.opaque = NO;
    
    [score setTextAlignment:NSTextAlignmentLeft];
    [score setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:1.35*FONT_FACT*frm.size.height]];
    
    [rootView addSubview:score];
    
    score.text = @"34678";
    
    [self setUpColors] ;
}

- (void)setUpColors {

    Colors *colors = [[Colors alloc] init];
    
    [colors setUpColors];
    
  //  topBar.backgroundColor = [UIColor colorWithRed:colors.topBarBackgroundColor.red green:colors.topBarBackgroundColor.green blue:colors.topBarBackgroundColor.blue alpha:0.2f];
    
 //   bottomBar.backgroundColor = [UIColor colorWithRed:colors.bottomBarBackgroundColor.red green:colors.bottomBarBackgroundColor.green blue:colors.bottomBarBackgroundColor.blue alpha:0.2f];
    
  //  boardView.backgroundColor = [UIColor colorWithRed:colors.boardViewBackgroundColor.red green:colors.boardViewBackgroundColor.green blue:colors.boardViewBackgroundColor.blue alpha:1.0f];
    
   //   menuView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.99];
    
    topBar.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.4];//[UIColor clearColor];
    bottomBar.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.4];//[UIColor clearColor];
    boardView.backgroundColor = [UIColor clearColor];
    
  //  menuView.backgroundColor = [UIColor colorWithRed:colors.bottomBarBackgroundColor.red green:colors.bottomBarBackgroundColor.green blue:colors.bottomBarBackgroundColor.blue alpha:1.0f];
    
    menuView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.7];
    
    UIGraphicsBeginImageContext(rootView.frame.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"stars1.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, rootView.frame.size.width, rootView.frame.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    
    rootView.backgroundColor = [UIColor colorWithPatternImage:tmpImage];
    
  /*  UIGraphicsBeginImageContext(boardView.frame.size);
   
    tmpImage = [UIImage imageNamed:@"topBar.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, boardView.frame.size.width, boardView.frame.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    
    boardView.backgroundColor = [UIColor colorWithPatternImage:tmpImage]; */
    
    
   // scoreLabel.textColor = [UIColor colorWithRed:colors.bottomBarBackgroundColor.red green:colors.bottomBarBackgroundColor.green blue:colors.bottomBarBackgroundColor.blue alpha:1.0f];

    scoreLabel.textColor = [UIColor orangeColor];
    scoreLabel.backgroundColor = [UIColor clearColor];
                                  
    score.textColor = [UIColor whiteColor];
    score.backgroundColor = [UIColor clearColor];

}

- (CGRect)initBoardView: (CGRect)viewFrame{

    CGRect boardFrm;
    
    boardFrm.origin.x = 0.04*viewFrame.size.width;
    boardFrm.origin.y = boardView.frame.origin.y + 0.04*viewFrame.size.width;
    boardFrm.size.height = 0.95*boardView.frame.size.height;
    boardFrm.size.width = viewFrame.size.width - 2.0*boardFrm.origin.x;

    return boardFrm;
}

- (void)setUpFloatPieces:(CGRect)pcFrm {

    UIGraphicsBeginImageContext(pcFrm.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"redSquare.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, pcFrm.size.width, pcFrm.size.height)];
    floatBackImage = UIGraphicsGetImageFromCurrentImageContext();

    floatPiece = [[UILabel alloc] initWithFrame:pcFrm];
   // [floatPiece setBackgroundColor:[UIColor colorWithPatternImage:floatBackImage]];
    floatPiece.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.4];//[UIColor lightGrayColor];
    
    floatPiece.layer.cornerRadius = 10.0f;
    floatPiece.clipsToBounds = YES;
    floatPiece.hidden = YES;
    
    [floatPiece setTextAlignment:NSTextAlignmentCenter];
    [floatPiece setFont:[UIFont fontWithName:@"Arial" size:1.0*FONT_FACT*pcFrm.size.width]];
    floatPiece.textColor = [UIColor whiteColor];
    
    [rootView addSubview:floatPiece];
    
    floatPieceOffSet.width = pcFrm.size.width/2.0;
    floatPieceOffSet.height = pcFrm.size.height/2.0;
    
    pcFrm.size.width *= 1.05;
    pcFrm.size.height *= 1.05;
    pcFrm.origin.x = 0.75*bottomBar.frame.size.width;
    pcFrm.origin.y = bottomBar.frame.origin.y + (bottomBar.frame.size.height - pcFrm.size.height)/2.0;
    
    baseAddPiece = pcFrm;
    
    UIGraphicsBeginImageContext(pcFrm.size);
    tmpImage = [UIImage imageNamed:@"redSquare.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, pcFrm.size.width, pcFrm.size.height)];
    
    floatBackImage = UIGraphicsGetImageFromCurrentImageContext();

    addPiece = [[UILabel alloc] initWithFrame:pcFrm];
   // [addPiece setBackgroundColor:[UIColor colorWithPatternImage:floatBackImage]];
    addPiece.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.4];

    addPiece.layer.cornerRadius = 10.0f;
    addPiece.clipsToBounds = YES;
    addPiece.hidden = NO;
    
    [addPiece setTextAlignment:NSTextAlignmentCenter];
    [addPiece setFont:[UIFont fontWithName:@"Arial" size:1.0*FONT_FACT*pcFrm.size.width]];
    addPiece.textColor = [UIColor whiteColor];
    
    [rootView addSubview:addPiece];
    
    addPieceOffSet.width = pcFrm.size.width/2.0;
    addPieceOffSet.height = pcFrm.size.height/2.0;
    
    pcFrm.size.width *= 0.80;
    pcFrm.size.height = pcFrm.size.width;
    pcFrm.origin.y = bottomBar.frame.origin.y + (bottomBar.frame.size.height - pcFrm.size.height)/2.0;
    pcFrm.origin.x = bottomBar.frame.size.width - addPiece.frame.size.width - addPiece.frame.origin.x;
    
    UIGraphicsBeginImageContext(pcFrm.size);
   
    tmpImage = [UIImage imageNamed:@"menuBars2.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, pcFrm.size.width, pcFrm.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    
    menuBar = [[UIImageView alloc] initWithImage:tmpImage];
    
    [menuBar setFrame:pcFrm];
    
    [rootView addSubview:menuBar];
}

- (void)changeFloatPieceLoc: (CGPoint)newLoc {

    CGRect frm;
    
    frm.origin.x = newLoc.x - floatPieceOffSet.width;
    frm.origin.y = newLoc.y - floatPieceOffSet.height;
    
    frm.size = floatPiece.frame.size;
    
    [floatPiece setFrame:frm];
}

- (void)updateScore: (int)newScore {
    
    score.text = [NSString stringWithFormat:@"%d",newScore];
}

- (void)changeAddPieceLoc: (CGPoint)newLoc {

    CGRect frm;
    
    frm.origin.x = newLoc.x - addPieceOffSet.width;
    frm.origin.y = newLoc.y - addPieceOffSet.height;

    frm.size = addPiece.frame.size;
    
    [addPiece setFrame:frm];
}

- (void)configureFloatPiece: (Space*)space {
    
    CGRect frm;
    
    frm.origin.x = space.piece.frame.origin.x;
    frm.origin.y = space.piece.frame.origin.y;
    
    frm.size = space.piece.frame.size;
    
    floatPiece.hidden = NO;
    
    floatPiece.text = space.value;
    floatPiece.layer.borderColor = [[UIColor clearColor] CGColor];
    floatPiece.backgroundColor = space.piece.backgroundColor;
    
    [floatPiece setFrame:frm];
    
    [rootView bringSubviewToFront:floatPiece];
}

- (void)resetAddPiece {

    [addPiece setFrame:baseAddPiece];
}

- (void)animateAlertView {
    
    alertView.hidden = NO;
    alertView.alpha = 0.90;
    
    [rootView sendSubviewToBack:alertView];
    
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        alertView.alpha = 0.25;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            alertView.alpha = 0.90;
        } completion:nil];
    }];
}

- (void)hideAlertView {

    alertView.hidden = YES;
}

- (void)deconstruct {

    topBar = nil;
    floatPiece = nil;
    bottomBar = nil;
    menuView = nil;
    addPiece = nil;
    
    alertView = nil;
    scoreLabel = nil;
    score = nil;
}

@end

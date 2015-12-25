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
    
    frm = viewFrame;
    frm.size.height *= 0.15;
    
    topBar = [[UIView alloc] initWithFrame:frm];
    
    [rootViewCont.view addSubview:topBar];
    
    frm = topBar.frame;
    frm.size.height *= 1.25;
    frm.origin.y = viewFrame.size.height - frm.size.height;
    
    bottomBar = [[UIView alloc] initWithFrame:frm];
    
    [rootViewCont.view addSubview:bottomBar];
    
    frm.size.height = viewFrame.size.height - topBar.frame.size.height - bottomBar.frame.size.height;
    frm.origin.y = topBar.frame.size.height;
    
    boardView = [[UIView alloc] initWithFrame:frm];
    
    [rootViewCont.view addSubview:boardView];
    
    frm.size.height = 0.7*rootViewCont.view.frame.size.height;
    frm.origin.y = rootViewCont.view.frame.size.height - frm.size.height;
    
    menuView = [[MenuView alloc] initWithFrame:frm];
    
    [menuView setUpView];
    
    [rootViewCont.view addSubview:menuView];
    [rootViewCont.view bringSubviewToFront:menuView];
    
    topBar.hidden = NO;
    bottomBar.hidden = NO;
    boardView.hidden = NO;
    menuView.hidden = YES;
    
    [self setUpColors];
}

- (void)setUpColors {

    Colors *colors = [[Colors alloc] init];
    
    [colors setUpColors];
    
    topBar.backgroundColor = [UIColor colorWithRed:colors.topBarBackgroundColor.red green:colors.topBarBackgroundColor.green blue:colors.topBarBackgroundColor.blue alpha:1.0f];
    
    bottomBar.backgroundColor = [UIColor colorWithRed:colors.bottomBarBackgroundColor.red green:colors.bottomBarBackgroundColor.green blue:colors.bottomBarBackgroundColor.blue alpha:1.0f];
    
    boardView.backgroundColor = [UIColor colorWithRed:colors.boardViewBackgroundColor.red green:colors.boardViewBackgroundColor.green blue:colors.boardViewBackgroundColor.blue alpha:1.0f];
    
    menuView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.99];
}

- (CGRect)initBoardView: (CGRect)viewFrame{

    CGRect boardFrm;
    
    boardFrm.origin.x = 0.04*viewFrame.size.width;
    boardFrm.origin.y = boardView.frame.origin.y + 0.04*viewFrame.size.width;
    boardFrm.size.height = 0.95*boardView.frame.size.height;
    boardFrm.size.width = viewFrame.size.width - 2.0*boardFrm.origin.x;

    return boardFrm;
}

- (void)setUpFloatPieces:(CGRect)pcFrm :(UIView*)rootView {

    UIGraphicsBeginImageContext(pcFrm.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"orangeSquare.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, pcFrm.size.width, pcFrm.size.height)];
    floatBackImage = UIGraphicsGetImageFromCurrentImageContext();

    floatPiece = [[UILabel alloc] initWithFrame:pcFrm];
    [floatPiece setBackgroundColor:[UIColor colorWithPatternImage:floatBackImage]];
    
    floatPiece.layer.cornerRadius = 10.0f;
    floatPiece.clipsToBounds = YES;
    floatPiece.hidden = YES;
    
    [floatPiece setTextAlignment:NSTextAlignmentCenter];
    [floatPiece setFont:[UIFont fontWithName:@"Arial" size:1.0*FONT_FACT*pcFrm.size.width]];
    floatPiece.textColor = [UIColor whiteColor];
    
    [rootView addSubview:floatPiece];
    
    floatPieceOffSet.width = pcFrm.size.width/2.0;
    floatPieceOffSet.height = pcFrm.size.height/2.0;
    
    pcFrm.size.width *= 1.25;
    pcFrm.size.height *= 1.25;
    pcFrm.origin.x = 0.75*bottomBar.frame.size.width;
    pcFrm.origin.y = bottomBar.frame.origin.y + (bottomBar.frame.size.height - pcFrm.size.height)/2.0;
    
    baseAddPiece = pcFrm;
    
    UIGraphicsBeginImageContext(pcFrm.size);
    tmpImage = [UIImage imageNamed:@"orangeSquare.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, pcFrm.size.width, pcFrm.size.height)];
    
    floatBackImage = UIGraphicsGetImageFromCurrentImageContext();

    addPiece = [[UILabel alloc] initWithFrame:pcFrm];
    [addPiece setBackgroundColor:[UIColor colorWithPatternImage:floatBackImage]];
    
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

- (void)changeAddPieceLoc: (CGPoint)newLoc {

    CGRect frm;
    
    frm.origin.x = newLoc.x - addPieceOffSet.width;
    frm.origin.y = newLoc.y - addPieceOffSet.height;

    frm.size = addPiece.frame.size;
    
    [addPiece setFrame:frm];
}

- (void)configureFloatPiece: (Space*)space :(UIView*)rootView {
    
    CGRect frm;
    
    frm.origin.x = space.piece.frame.origin.x;
    frm.origin.y = space.piece.frame.origin.y;
    
    frm.size = space.piece.frame.size;
    
    floatPiece.hidden = NO;
    
    floatPiece.text = space.value;
    floatPiece.layer.borderColor = [[UIColor clearColor] CGColor];
    
    [floatPiece setFrame:frm];
    
    [rootView bringSubviewToFront:floatPiece];
}

- (void)resetAddPiece {

    [addPiece setFrame:baseAddPiece];
}

- (void)deconstruct {

    topBar = nil;
    floatPiece = nil;
    bottomBar = nil;
    menuView = nil;
}

@end

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

- (void)initDisplay:(CGRect)viewFrame : (UIViewController*)rootViewCont {

    CGRect frm;
    
    frm = viewFrame;
    frm.size.height *= 0.20;
    
    topBar = [[UIView alloc] initWithFrame:frm];
    
    [rootViewCont.view addSubview:topBar];
    
    frm = topBar.frame;
    frm.size.height *= 0.75;
    frm.origin.y = viewFrame.size.height - frm.size.height;
    
    bottomBar = [[UIView alloc] initWithFrame:frm];
    
    [rootViewCont.view addSubview:bottomBar];
    
    frm.size.height = viewFrame.size.height - topBar.frame.size.height- bottomBar.frame.size.height;
    frm.origin.y = topBar.frame.size.height;
    
    boardView = [[UIView alloc] initWithFrame:frm];
    
    [rootViewCont.view addSubview:boardView];
    
    topBar.hidden = NO;
    bottomBar.hidden = NO;
    boardView.hidden = NO;
    
    [self setUpColors];
}

- (void)setUpColors {

    Colors *colors = [[Colors alloc] init];
    
    [colors setUpColors];
    
    topBar.backgroundColor = [UIColor colorWithRed:colors.topBarBackgroundColor.red green:colors.topBarBackgroundColor.green blue:colors.topBarBackgroundColor.blue alpha:1.0f];
    
    bottomBar.backgroundColor = [UIColor colorWithRed:colors.bottomBarBackgroundColor.red green:colors.bottomBarBackgroundColor.green blue:colors.bottomBarBackgroundColor.blue alpha:1.0f];
    
    boardView.backgroundColor = [UIColor colorWithRed:colors.boardViewBackgroundColor.red green:colors.boardViewBackgroundColor.green blue:colors.boardViewBackgroundColor.blue alpha:1.0f];

}

- (CGRect)initBoardView: (CGRect)viewFrame{

    CGRect boardFrm;
    
    boardFrm.origin.x = 0.05*viewFrame.size.width;
    boardFrm.origin.y = boardView.frame.origin.y + 0.05*viewFrame.size.width;
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
   // floatPiece.opaque = NO;
    floatPiece.hidden = YES;
    
    [floatPiece setTextAlignment:NSTextAlignmentCenter];
    [floatPiece setFont:[UIFont fontWithName:@"Arial" size:1.0*FONT_FACT*pcFrm.size.width]];
    floatPiece.textColor = [UIColor whiteColor];
    
    [rootView addSubview:floatPiece];
    
    floatPieceOffSet.width = pcFrm.size.width/2.0;
    floatPieceOffSet.height = pcFrm.size.height/2.0;
}

- (void)changeFloatPieceLoc: (CGPoint)newLoc {

    CGRect frm;
    
    frm.origin.x = newLoc.x - floatPieceOffSet.width;
    frm.origin.y = newLoc.y - floatPieceOffSet.height;
    
    frm.size = floatPiece.frame.size;
    
    [floatPiece setFrame:frm];
}

- (void)configureFloatPiece: (Space*)space :(UIView*)rootView {
    
    CGRect frm;
    
    frm.origin.x = space.piece.frame.origin.x;
    frm.origin.y = space.piece.frame.origin.y;
    
    frm.size = space.piece.frame.size;
    
    floatPiece.hidden = NO;
    
    floatPiece.text = [NSString stringWithFormat:@"%d", space.value];
    floatPiece.layer.borderColor = [[UIColor clearColor] CGColor];
    
    [floatPiece setFrame:frm];
    
    [rootView bringSubviewToFront:floatPiece];
}

@end

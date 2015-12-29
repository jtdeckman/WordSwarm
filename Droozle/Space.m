//
//  Space.m
//  Droozle
//
//  Created by Jason Deckman on 9/4/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import "Space.h"

@implementation Space

@synthesize isOccupied, refPiece;
@synthesize value, piece, pointValue;
@synthesize spaceFrame, iind, jind;
@synthesize neighbors, nearestNbrs;
@synthesize backPiece, backPieceVal;

- (void)initSpace : (int)ival : (int)jval : (CGRect)spaceFrm : (CGRect)labelframe {
    
    value = @"";
    
    iind = ival;
    jind = jval;

    refPiece = NO;
    
    spaceFrame = spaceFrm;
    
    piece = [[UILabel alloc] initWithFrame:labelframe];
    piece.hidden = YES;
    piece.layer.cornerRadius = 10.0;
    piece.clipsToBounds = YES;
    piece.opaque = NO;
    
    [piece setTextAlignment:NSTextAlignmentCenter];
    [piece setFont:[UIFont fontWithName:@"Arial" size:1.0*FONT_FACT*spaceFrame.size.width]];
    
    piece.backgroundColor = [UIColor clearColor];
    
    backPiece = [[UILabel alloc] initWithFrame:labelframe];
    backPiece.hidden = YES;
    backPiece.layer.cornerRadius = 10.0;
    backPiece.clipsToBounds = YES;
    backPiece.opaque = NO;
    backPiece.layer.borderWidth = 3.0;
    backPiece.alpha = 1.0;
    
    backPiece.layer.borderColor = [[UIColor colorWithRed:1.0 green:0.1 blue:0.1 alpha:0.8] CGColor];
    backPiece.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];;
    
    [backPiece setTextAlignment:NSTextAlignmentCenter];
    [backPiece setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:1.0*FONT_FACT*spaceFrame.size.width]];
    
    backPiece.backgroundColor = [UIColor clearColor];
    backPieceVal = 1;
    
    nearestNbrs = [[NSMutableSet alloc] initWithCapacity:4];
    neighbors = [[NSMutableSet alloc] initWithCapacity:10];
   
    UIGraphicsBeginImageContext(piece.frame.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"blueSquare.png"];

    [tmpImage drawInRect:CGRectMake(0, 0, piece.frame.size.width, piece.frame.size.height)];
    p1Img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsBeginImageContext(piece.frame.size);
    
    tmpImage = [UIImage imageNamed:@"times2.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, piece.frame.size.width, backPiece.frame.size.height)];
    p2Img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsBeginImageContext(piece.frame.size);

    tmpImage = [UIImage imageNamed:@"times3.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, piece.frame.size.width, backPiece.frame.size.height)];
    p3Img = UIGraphicsGetImageFromCurrentImageContext();
}

- (void)setColor: (CGFloat)red : (CGFloat)green : (CGFloat)blue : (CGFloat)alpha {
    
    color.red = red;
    color.green = green;
    color.blue = blue;
}

- (void)configurePiece: (bool)isRefPiece :(UIColor*)bckImg {

    refPiece = isRefPiece;
    
    if(isRefPiece) {
        
        [piece setFont:[UIFont fontWithName:@"Arial" size:0.6*FONT_FACT*spaceFrame.size.width]];
        piece.backgroundColor = [UIColor colorWithPatternImage:p1Img];
        
        backPiece = nil;
    }
    else {
        piece.backgroundColor = bckImg;
        
        if(backPieceVal == 2) {
         
            backPiece.hidden = NO;
            backPiece.layer.borderColor = [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8] CGColor];
            backPiece.textColor = [UIColor clearColor];
            backPiece.backgroundColor = [UIColor colorWithPatternImage:p2Img];
        
        }
        
        else if(backPieceVal == 3) {
        
            backPiece.hidden = NO;
            backPiece.layer.borderColor = [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8] CGColor];
            backPiece.textColor = [UIColor clearColor];
            backPiece.backgroundColor = [UIColor colorWithPatternImage:p3Img];
        }
        
        else {
            
            backPiece.hidden = YES;
            backPieceVal = 1;
        }
    }
    
    piece.text = [self value];
    piece.textColor = [UIColor whiteColor];
    piece.layer.borderColor = [[UIColor clearColor] CGColor];
}

- (void)highlightPiece {
    
    piece.layer.borderColor = [[UIColor whiteColor] CGColor];
    
}

- (void)unHighlightPiece {
    
    piece.layer.borderColor = [[UIColor colorWithRed:color.red green:color.green blue:color.blue alpha:1.0] CGColor];
}

- (bool)isNearestNearestNbrOf: (Space*)space {
    
    if([nearestNbrs containsObject:space]) return YES;
    
    return NO;
}

- (void)deconstruct {
    
    [piece removeFromSuperview];
    piece = nil;
    
    [backPiece removeFromSuperview];
    backPiece = nil;
    
    [nearestNbrs removeAllObjects];
    [neighbors removeAllObjects];
    
    nearestNbrs = nil;
    neighbors = nil;
    
    p1Img = nil;
    p2Img = nil;
    p3Img = nil;
}

@end

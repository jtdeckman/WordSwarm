//
//  Space.m
//  Droozle
//
//  Created by Jason Deckman on 9/4/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import "Space.h"

@implementation Space

@synthesize isOccupied, value, piece;
@synthesize spaceFrame, iind, jind;
@synthesize neighbors, nearestNbrs;

- (void)initSpace : (int)ival : (int)jval : (CGRect)spaceFrm : (CGRect)labelframe {
    
    value = @"";
    
    iind = ival;
    jind = jval;

    spaceFrame = spaceFrm;
    
    piece = [[UILabel alloc] initWithFrame:labelframe];
    piece.hidden = YES;
    piece.layer.cornerRadius = 10.0;
    piece.clipsToBounds = YES;
    piece.opaque = NO;
    
    [piece setTextAlignment:NSTextAlignmentCenter];
    [piece setFont:[UIFont fontWithName:@"Arial" size:1.0*FONT_FACT*spaceFrame.size.width]];
    
    nearestNbrs = [[NSMutableSet alloc] initWithCapacity:4];
    neighbors = [[NSMutableSet alloc] initWithCapacity:10];
   
    UIGraphicsBeginImageContext(piece.frame.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"orangeSquare.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, piece.frame.size.width, piece.frame.size.height)];
    p1Img = UIGraphicsGetImageFromCurrentImageContext();
    
    tmpImage = [UIImage imageNamed:@"blueSquare.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, piece.frame.size.width, piece.frame.size.height)];
    p2Img = UIGraphicsGetImageFromCurrentImageContext();
    
    tmpImage = [UIImage imageNamed:@"redSquare.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, piece.frame.size.width, piece.frame.size.height)];
    p3Img = UIGraphicsGetImageFromCurrentImageContext();
}

- (void)setColor: (CGFloat)red : (CGFloat)green : (CGFloat)blue : (CGFloat)alpha {
    
    color.red = red;
    color.green = green;
    color.blue = blue;
}

- (void)configurePiece: (bool)isRefPiece : (bool)isSumPiece{
    
    UIImage *img;

    if(isRefPiece)
        img = p2Img;
    else if(isSumPiece)
        img = p3Img;
    else
        img = p1Img;
    
    piece.text = [NSString stringWithFormat:@"%d", value];
    piece.backgroundColor = [UIColor colorWithPatternImage:img];
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
    
    [nearestNbrs removeAllObjects];
    [neighbors removeAllObjects];
    
    nearestNbrs = nil;
    neighbors = nil;
    
    p1Img = nil;
    p2Img = nil;
}

@end

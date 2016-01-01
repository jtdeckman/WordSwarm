//
//  tileImages.h
//  Droozle
//
//  Created by Jason Deckman on 12/26/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TileImages : NSObject {
    
    NSMutableArray *images;
   // NSMutableDictionary *lettersForUIColors;
    
    CGSize pieceSize;
}

@property (nonatomic) CGSize pieceSize;

- (void)setUp:(CGSize)frm;
- (void)deconstruct;

- (UIColor*)backgroundImageForIndex:(int)ind;

@end

//
//  LetterBar.h
//  WordSwarm
//
//  Created by Jason Deckman on 9/10/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileImages.h"
#import "WordLogic.h"
#import "Constants.h"

@interface LetterBar : UIView {
    
    NSMutableArray *letters;    
}

- (void)setUp:(CGRect)frm :(NSArray*)letterArry :(CGFloat)maxDim :(CGFloat)offset :(WordLogic*)wl;

@end

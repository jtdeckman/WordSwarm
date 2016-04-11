//
//  HowToScreenInit.h
//  WordBatch
//
//  Created by Jason Deckman on 4/10/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import "HowToScreen.h"

@interface HowToScreenInit : HowToScreen {
    
    BOOL boxChecked;
    
    UIImage *boxUncheckedImg;
    UIImage *boxCheckedImg;
}

@property(nonatomic, strong) UIImageView *checkBox;

@end

//
//  HowToPage.h
//  WordSwarm
//
//  Created by Jason Deckman on 9/26/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowToPage : UIView {
    
    UIImageView *screen;
}

@property(nonatomic, strong) UILabel *doneLabel;
@property(nonatomic, strong) UILabel *checkBox;

- (void)setUp:(CGRect)frm;

@end

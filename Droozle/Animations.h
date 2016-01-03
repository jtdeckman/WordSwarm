//
//  Animations.h
//  Droozle
//
//  Created by Jason Deckman on 12/30/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface Animations : NSObject {
    
    UILabel *textBox1;
    UILabel *textBox2;
    
    CGRect baseLocBox1;
    CGRect baseLocBox2;
    
    UIView *rootView;
}

@property (nonatomic, strong) UILabel *textBox1;
@property (nonatomic, strong) UILabel *textBox2;

- (void)setUp:(CGRect)frame :(CGFloat)origy :(UIView*)rview;

- (void)animateTextBox1:(CGFloat)duration :(CGFloat)startLoc :(CGFloat)delay :(NSString*)text;
- (void)animateTextBox2:(CGFloat)duration :(CGFloat)startLoc :(CGFloat)endLoc :(CGFloat)delay :(NSString*)text;

- (void)deconstruct;

@end

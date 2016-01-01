//
//  WordBar.h
//  Droozle
//
//  Created by Jason Deckman on 12/31/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WordBar : NSObject {
    
    NSMutableArray *letters;
    
    UILabel *barBackground;
    UILabel *catLabel;
    
    CGFloat xOffset;
}

@property (nonatomic,strong) NSMutableArray *letters;

@property (nonatomic,strong) UILabel *barBackground;
@property (nonatomic,strong) UILabel *catLabel;

- (void)setUp:(uint)nLetters :(CGRect)frame :(CGFloat)offset :(UIView*)rootView;
- (void)deconstruct;

@end

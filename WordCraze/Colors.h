//
//  Colors.h
//  Droozle
//
//  Created by Jason Deckman on 9/21/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Colors : NSObject
    
@property (nonatomic) JDColor topBarBackgroundColor;
@property (nonatomic) JDColor bottomBarBackgroundColor;
@property (nonatomic) JDColor boardViewBackgroundColor;
@property (nonatomic) JDColor scoreColor;
@property (nonatomic) JDColor levelColor;
@property (nonatomic) JDColor redFlashColor;

- (void)setUpColors;

@end

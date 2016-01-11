//
//  AnimationPieces.h
//  Droozle
//
//  Created by Jason Deckman on 12/28/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationPieces : NSObject {
    
    NSMutableArray *pieces;
}

@property (nonatomic, strong) NSMutableArray *pieces;

- (void)setUpPieces;
- (void)deconstruct;

@end

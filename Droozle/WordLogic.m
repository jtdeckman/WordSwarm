//
//  WordLogic.m
//  Droozle
//
//  Created by Jason Deckman on 11/5/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "WordLogic.h"

@implementation WordLogic

- (void)initLetters {

    letters = [[NSMutableArray alloc] initWithObjects:@"A",
               @"A",
               @"A",
               @"A",
               @"A",
               @"A",
               @"A",
               @"A",
               @"A",
               @"B",
               @"B",
               @"C",
               @"C",
               @"D",
               @"D",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"E",
               @"F",
               @"F",
               @"G",
               @"G",
               @"G",
               @"H",
               @"H",
               @"H",
               @"H",
               @"I",
               @"I",
               @"I",
               @"I",
               @"I",
               @"I",
               @"I",
               @"I",
               @"J",
               @"K",
               @"K",
               @"L",
               @"L",
               @"L",
               @"L",
               @"M",
               @"M",
               @"N",
               @"N",
               @"N",
               @"N",
               @"N",
               @"O",
               @"O",
               @"O",
               @"O",
               @"O",
               @"O",
               @"O",
               @"O",
               @"P",
               @"P",
               @"Q",
               @"R",
               @"R",
               @"R",
               @"R",
               @"R",
               @"S",
               @"S",
               @"S",
               @"S",
               @"S",
               @"T",
               @"T",
               @"T",
               @"T",
               @"T",
               @"T",
               @"T",
               @"U",
               @"U",
               @"U",
               @"U",
               @"V",
               @"W",
               @"W",
               @"X",
               @"Y",
               @"Y",
               @"Z",
               nil];
    
    nArraySelections = (int)[letters count];
}

- (NSString*)getLetter {
 
    int index;

    index = arc4random() % nArraySelections;
    
    return letters[index];
}

@end

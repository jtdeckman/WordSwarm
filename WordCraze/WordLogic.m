//
//  WordLogic.m
//  Droozle
//
//  Created by Jason Deckman on 11/5/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "WordLogic.h"

@implementation WordLogic

@synthesize nArraySelections, letters, wordTypes;

- (NSString*)getLetter {
 
    int index;

    index = arc4random() % nArraySelections;
    
    return letters[index];
}

- (NSString*)randomLetter {
    
    int index = arc4random() % nArraySelections;
    
    return letters[index];
}

- (NSString*)randomLetterFromTier:(uint)tier {

    int index = arc4random() % ((NSMutableArray*)letterTiers[tier]).count;
    
    return (NSString*)letterTiers[tier][index];
}

- (NSString*)getType {

    int index = arc4random() % [wordTypes count];
    
    return wordTypes[index];
}

- (BOOL)isWord:(NSString*)word inCategory:(NSString*)cat {

    NSString *result = [dictionary definitionFor:word];
    
    NSString *subString = [result substringToIndex:20];
    NSArray *components = [subString componentsSeparatedByString:@" "];
    
    NSString *wrd1 = components[1];
    NSString *wrd2 = components[2];
    
    if([wrd1 isEqualToString:@"definition"] && [wrd2 isEqualToString:@"not"])
        return NO;
    
    else {
        
        if([cat isEqualToString:@"Word"])
            return YES;
        
        else {
            
            if([self checkWord:result forCategory:cat]) return YES;
        }
    }
    
    return NO;
}

- (int)pointValueForLetter:(NSString*)letter {

    
    if(letter.length > 1) return  -1;
    
    NSNumber *val = [pointsForLetters objectForKey:letter];
    
    return (int)[val integerValue];
}

- (BOOL)checkWord:(NSString*)word forCategory:(NSString*)cat {

    if([cat isEqualToString:@"Noun"]) {

        if([word containsString:@"(noun)"]) return YES;
    }
    
    else if([cat isEqualToString:@"Verb"]) {
        
        if([word containsString:@"(verb)"]) return YES;
    }
    
    else if([cat isEqualToString:@"Adj"]) {
        
        if([word containsString:@"(adj)"]) return YES;
    }
    
    else if([cat isEqualToString:@"Adv"]) {
        
        if([word containsString:@"(adv)"]) return YES;
    }
    
    else {
        
    }
    
    return NO;
}

- (NSMutableArray*)lettersForLevel:(int)level {

    NSMutableArray *levelLetters = [[NSMutableArray alloc] initWithCapacity:100];
    
    if(level <= 10) {
        
        
        if(level <= 3) {
            uint nLett = 7 + level;//level + 6;

            for(int i=0; i<nLett; i++) {
            
                [levelLetters addObject:[self randomLetterFromTier:0]];
            }
        }
        
        else if(level <= 5) {
            
            uint nLett = 15 + level;//3*level + 3;//level + 3;
            
            for(int i=0; i<nLett; i++) {
                
                [levelLetters addObject:[self randomLetterFromTier:0]];
            }
        }
        
        else {
            
            uint nLett = 23 + level;//level + 3;
            
            for(int i=0; i<nLett; i++) {
                
                [levelLetters addObject:[self randomLetterFromTier:0]];
            }

            
        }
    }
    
    else if(level <= 15) {
        
        uint nLett = level + 2;
        
        for(int i=0; i<nLett; i++) {
            
            [levelLetters addObject:[self randomLetterFromTier:0]];
        }
    }
    
    else if(level <= 20) {
        
        uint nLett = level - 12;
        
        for(int i=0; i<nLett; i++) {
            
            [levelLetters addObject:[self randomLetterFromTier:1]];
        }
    }
    
    return levelLetters;
}

- (void)initWordTypesForLevel:(int)level {

    [wordTypes removeAllObjects];
    
    if(level < 0) {
        
        if(level < -1) {
            
            [wordTypes addObject:@"Word"];
            [wordTypes addObject:@"Noun"];
            [wordTypes addObject:@"Verb"];
            [wordTypes addObject:@"Adj"];
        }
        else {
            
            [wordTypes addObject:@"Word"];
            [wordTypes addObject:@"Word"];
            [wordTypes addObject:@"Word"];
            [wordTypes addObject:@"Word"];
        }
    }
    
    if(level == 0 || level == 1) {
        
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
    }
    
    else if(level == 2) {
        
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Word"];
    }
    
    else if(level == 3) {
       
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Noun"];
    }
    
    else if(level == 4) {
        
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Verb"];
    }
    
    else if(level == 5) {
        
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Verb"];
        [wordTypes addObject:@"Adj"];

    }
    
    else if(level == 6) {
        
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Verb"];
        [wordTypes addObject:@"Verb"];
    }
    
    else if(level == 7) {
        
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Verb"];
        [wordTypes addObject:@"Verb"];
    }
    
    else if(level == 8) {
        
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Verb"];
        [wordTypes addObject:@"Adj"];
    }
    
    else if(level == 9) {
        
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Verb"];
        [wordTypes addObject:@"Adj"];
    }
    
    else if(level == 10) {
        
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Verb"];
        [wordTypes addObject:@"Adj"];
    }
    
    else if(level == 11) {
        
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Verb"];
        [wordTypes addObject:@"Verb"];
        [wordTypes addObject:@"Adj"];
    }
    
    else {
        
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Word"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Noun"];
        [wordTypes addObject:@"Verb"];
        [wordTypes addObject:@"Verb"];
        [wordTypes addObject:@"Adj"];
        [wordTypes addObject:@"Adj"];
    }
}

- (void)deconstruct {
    
    [wordTypes removeAllObjects];
    [letters removeAllObjects];
    [pointsForLetters removeAllObjects];
    
    dictionary = nil;
    wordTypes = nil;
    letters = nil;
    
    pointsForLetters = nil;
}

- (void)initLetters {
    
    dictionary = [Lexicontext sharedDictionary];
    
    wordTypes = [[NSMutableArray alloc] initWithCapacity:100];
    
    letters = [[NSMutableArray alloc] initWithObjects:
               @"A",
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
               @"V",
               @"W",
               @"W",
               @"X",
               @"Y",
               @"Y",
               @"Z",
               nil];
    
    nArraySelections = (int)[letters count];
    
    NSNumber *p0 = [NSNumber numberWithInt:0];
    NSNumber *p1 = [NSNumber numberWithInt:1];
    NSNumber *p2 = [NSNumber numberWithInt:2];
    NSNumber *p3 = [NSNumber numberWithInt:3];
    NSNumber *p4 = [NSNumber numberWithInt:4];
    NSNumber *p5 = [NSNumber numberWithInt:5];
    NSNumber *p7 = [NSNumber numberWithInt:7];
    NSNumber *p10 = [NSNumber numberWithInt:10];
    NSNumber *p12 = [NSNumber numberWithInt:12];
    
    pointsForLetters = [[NSMutableDictionary alloc]  initWithObjectsAndKeys:
                        p1,@"A",
                        p4,@"B",
                        p7,@"C",
                        p2,@"D",
                        p1,@"E",
                        p4,@"F",
                        p3,@"G",
                        p3,@"H",
                        p2,@"I",
                        p10,@"J",
                        p5,@"K",
                        p2,@"L",
                        p4,@"M",
                        p2,@"N",
                        p1,@"O",
                        p4,@"P",
                        p10,@"Q",
                        p1,@"R",
                        p1,@"S",
                        p1,@"T",
                        p2,@"U",
                        p7,@"V",
                        p7,@"W",
                        p10,@"X",
                        p4,@"Y",
                        p12,@"Z",
                        p0,@"",
                        nil];
    
    letterTiers = [[NSMutableArray alloc] initWithCapacity:4];
    
    letterTiers[0] = [[NSMutableArray alloc] initWithObjects:
                      @"A",
                      @"A",
                      @"A",
                      @"A",
                      @"A",
                      @"A",
                      @"A",
                      @"A",
                      @"A",
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
                      @"G",
                      @"H",
                      @"I",
                      @"I",
                      @"I",
                      @"I",
                      @"I",
                      @"I",
                      @"L",
                      @"L",
                      @"N",
                      @"O",
                      @"O",
                      @"O",
                      @"O",
                      @"O",
                      @"O",
                      @"O",
                      @"O",
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
                      nil];
    
    letterTiers[1] = [[NSMutableArray alloc] initWithObjects:
                      @"A",
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
                      @"V",
                      @"W",
                      @"W",
                      @"X",
                      @"Y",
                      @"Y",
                      @"Z",
                      nil];
    
    letterTiers[2] = [[NSMutableArray alloc] initWithObjects:
                      @"A",
                      @"A",
                      @"A",
                      @"A",
                      @"A",
                      @"A",
                      @"A",
                      @"A",
                      @"A",
                      @"B",
                      @"C",
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
                      @"G",
                      @"H",
                      @"I",
                      @"I",
                      @"I",
                      @"I",
                      @"I",
                      @"I",
                      @"J",
                      @"K",
                      @"L",
                      @"M",
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
                      @"Q",
                      @"R",
                      @"S",
                      @"T",
                      @"U",
                      @"V",
                      @"W",
                      @"X",
                      @"Y",
                      @"Z",
                      nil];
    
    letterTiers[3] = [[NSMutableArray alloc] initWithObjects:
                      @"A",
                      @"A",
                      @"A",
                      @"A",
                      @"B",
                      @"C",
                      @"D",
                      @"E",
                      @"E",
                      @"E",
                      @"E",
                      @"E",
                      @"F",
                      @"G",
                      @"H",
                      @"I",
                      @"I",
                      @"I",
                      @"I",
                      @"J",
                      @"K",
                      @"L",
                      @"M",
                      @"N",
                      @"O",
                      @"O",
                      @"O",
                      @"O",
                      @"P",
                      @"Q",
                      @"R",
                      @"S",
                      @"T",
                      @"U",
                      @"V",
                      @"W",
                      @"X",
                      @"Y",
                      @"Z",
                      nil];
    
    letterTiers[3] = [[NSMutableArray alloc] initWithObjects:
                      @"A",
                      @"B",
                      @"C",
                      @"D",
                      @"E",
                      @"F",
                      @"G",
                      @"H",
                      @"I",
                      @"J",
                      @"K",
                      @"L",
                      @"M",
                      @"N",
                      @"O",
                      @"P",
                      @"Q",
                      @"R",
                      @"S",
                      @"T",
                      @"U",
                      @"V",
                      @"W",
                      @"X",
                      @"Y",
                      @"Z",
                      nil];


    
}

- (void)reinitLetters {
    
    [letters removeAllObjects];
    letters = nil;
    
        letters = [[NSMutableArray alloc] initWithObjects:
                   @"A",
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
                   @"V",
                   @"W",
                   @"W",
                   @"X",
                   @"Y",
                   @"Y",
                   @"Z",
                   nil];

}

@end

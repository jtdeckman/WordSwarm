//
//  phraseBar.m
//  WordSwarm
//
//  Created by Jason Deckman on 7/1/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import "phraseBar.h"

@implementation phraseBar {
    
    UILabel *phraseLabel;
    
    NSArray *phrases;
}

- (void)setUp:(CGRect)frm {
    
    self.frame = frm;
    
    self.backgroundColor = [UIColor blackColor];
    
    phraseLabel = [[UILabel alloc] initWithFrame:frm];
    
    phraseLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:0.25*frm.size.height];
    phraseLabel.hidden = NO;
    phraseLabel.text = @"";
    
    phrases = [self getPhrases];
}

- (NSArray*)getPhrases {

    NSArray *phraseArray = [[NSArray alloc] initWithObjects:
                            [NSArray arrayWithObjects:@"I Have many stripes", @"Zebra", nil],
                            [NSArray arrayWithObjects:@"I like to build dams", @"Beaver", nil],
                            [NSArray arrayWithObjects:@"You ugly and your mother dresses you", @"funny",nil],
                            [NSArray arrayWithObjects:@"It used to be wine, women, and song, now its beer, the old lady, and", @"tv", nil], nil];
    
    return phraseArray;
}

- (NSArray*)getPhrase {

    uint rnum = arc4random() % ([phrases count] - 1);
    
    NSArray *phr = [phrases objectAtIndex:rnum];
    
    return phr;
}

@end

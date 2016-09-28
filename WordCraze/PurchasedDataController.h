//
//  PurchasedDataController.h
//  WordSwarm
//
//  Created by Jason Deckman on 9/27/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kPurchasedContentUpdated = @"kPurchasedContentUpdated";

@interface PurchasedDataController : NSObject

@property (assign, nonatomic, readonly) BOOL tierOne;
@property (assign, nonatomic, readonly) BOOL tierTwo;
@property (assign, nonatomic, readonly) BOOL tierThree;

+ (PurchasedDataController *)SharedInstance;

@end

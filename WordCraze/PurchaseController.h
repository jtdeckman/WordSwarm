//
//  PurchaseController.h
//  WordSwarm
//
//  Created by Jason Deckman on 9/27/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

static NSString * const kInAppPurchaseFetchedNotification = @"kInAppPurchaseFetchedNotification";
static NSString * const kInAppPurchaseCompletedNotification = @"kInAppPurchaseCompletedNotification";
static NSString * const kInAppPurchaseRestoredNotification = @"kInAppPurchaseRestoredNotification";

static NSString * const kProductIDKey = @"kProductIDKey";

@interface PurchaseController : NSObject

@property (nonatomic, strong) NSArray *products;

+ (PurchaseController *)sharedInstance;

- (void)requestProducts;
- (void)restorePurchases;
- (void)purchaseOptionSelectedObjectIndex:(NSUInteger)index;

- (NSSet *)bundledProducts;

@end

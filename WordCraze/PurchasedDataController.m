//
//  PurchasedDataController.m
//  WordSwarm
//
//  Created by Jason Deckman on 9/27/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import "PurchasedDataController.h"
#import "PurchaseController.h"

static NSString * const kTierOneKey = @"tierOne";
static NSString * const kTierTwoKey = @"tierTwo";
static NSString * const kTierThreeKey = @"tierThree";

@interface PurchasedDataController()

@property (assign, nonatomic) BOOL tierOne;
@property (assign, nonatomic) BOOL tierTwo;
@property (assign, nonatomic) BOOL tierThree;

@end

@implementation PurchasedDataController

+ (PurchasedDataController *)SharedInstance {
    static PurchasedDataController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [PurchasedDataController new];
        [sharedInstance registerForNotifications];
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseNotification:) name:kInAppPurchaseCompletedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseNotification:) name:kInAppPurchaseRestoredNotification object:nil];
}

#pragma mark - Save to NSUserDefaults

- (void)loadFromDefaults {
    self.tierOne = [[NSUserDefaults standardUserDefaults] boolForKey:kTierOneKey];
    self.tierTwo = [[NSUserDefaults standardUserDefaults] boolForKey:kTierTwoKey];
    self.tierThree = [[NSUserDefaults standardUserDefaults] boolForKey:kTierThreeKey];
    
    if (!self.tierOne) {
        self.tierOne = NO;
    }
    if (!self.tierTwo) {
        self.tierTwo = NO;
    }
    if (!self.tierThree) {
        self.tierThree = NO;
    }
}

- (void)setTierOne:(BOOL)tierOne {
    _tierOne = tierOne;
    [[NSUserDefaults standardUserDefaults] setBool:tierOne forKey:kTierOneKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setTierTwo:(BOOL)tierTwo {
    _tierTwo = tierTwo;
    [[NSUserDefaults standardUserDefaults] setBool:tierTwo forKey:kTierTwoKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setTierThree:(BOOL)tierThree {
    _tierThree = tierThree;
    [[NSUserDefaults standardUserDefaults] setBool:tierThree forKey:kTierThreeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//  End NSUserDefaults Saver

#pragma mark - Notificationizer

- (void)purchaseNotification:(NSNotification *)notification {
    
    NSString *productIdentifier = notification.userInfo[kProductIDKey];
    
    if ([productIdentifier isEqualToString:@"com.abtechsolutions.QueueSign.tierOne"]) {
        self.tierOne = YES;
    }
    if ([productIdentifier isEqualToString:@"com.abtechsolutions.QueueSign.tierTwo"]) {
        self.tierTwo = YES;
    }
    if ([productIdentifier isEqualToString:@"com.abtechsolutions.QueueSign.tierThree"]) {
        self.tierThree = YES;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kPurchasedContentUpdated object:nil userInfo:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

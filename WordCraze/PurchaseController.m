//
//  PurchaseController.m
//  WordSwarm
//
//  Created by Jason Deckman on 9/27/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import "PurchaseController.h"

@interface PurchaseController () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, strong) SKProductsRequest *productsRequest;
@property (nonatomic, assign) BOOL productsRequested;

@end

@implementation PurchaseController

+ (PurchaseController *)sharedInstance {
    static PurchaseController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PurchaseController alloc] init];
        [sharedInstance loadStore];
    });
    return sharedInstance;
}

// This method retrieves product info from the Products.json
- (NSSet *)bundledProducts {
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *bundleProducts = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[bundle URLForResource:@"Products" withExtension:@"json"]] options:0 error:nil];
    if (bundleProducts) {
        NSSet *products = [NSSet setWithArray:bundleProducts];
        return products;
    }
    return nil;
}

- (void)requestProducts {
    if (!self.productsRequest) {
        // For product IDs
        self.productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[self bundledProducts]];
        self.productsRequest.delegate = self;
    }
    if (!self.productsRequested) {
        // requests products from iTunes Connect
        
        [self.productsRequest start];
        self.productsRequested = YES;
    }
}

- (void) restorePurchases {
    
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}



- (void)purchaseOptionSelectedObjectIndex:(NSUInteger)index {
    
    if ([SKPaymentQueue canMakePayments]) {
        if ([self.products count] > 0) {
            SKPayment *payment = [SKPayment paymentWithProduct:self.products[index]];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Unable To Purchase" message:@"This action is currently unavailable. Please try again later." preferredStyle:UIAlertControllerStyleAlert];
            [alert presentationController];
        }
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Unable To Purchase" message:@"In-App Purchases are disabled. Please enable In-App Purchases to proceed with this transaction." preferredStyle:UIAlertControllerStyleAlert];
        [alert presentationController];
    }
}



- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    self.productsRequested = NO;
    
    NSArray *products = response.products;
    self.products = products;
    for (SKProduct *validProduct in response.products) {
        NSLog(@"Product found with identifier: %@", validProduct.productIdentifier);
    }
    for (NSString *invalidProductID in response.invalidProductIdentifiers) {
        NSLog(@"Product invalid with identifier: %@", invalidProductID);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseFetchedNotification object:self userInfo:nil];
}



- (void)loadStore {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [self requestProducts];
}

- (void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful {
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    
    NSString *productIdentifier = @"";
    if (transaction.payment.productIdentifier) {
        productIdentifier = transaction.payment.productIdentifier;
    } else if (transaction.originalTransaction.payment.productIdentifier) {
        productIdentifier = transaction.payment.productIdentifier;
    }
    
    [self finishTransaction:transaction wasSuccessful:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseCompletedNotification object:self userInfo:@{kProductIDKey:productIdentifier}];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Purchases Restored" message:@"Thank you for restoring your purchased items." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okay = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okay];
    [alert presentViewController:alert animated:true completion:nil];
    
    NSString *productIdentifier = @"";
    if (transaction.payment.productIdentifier) {
        productIdentifier = transaction.payment.productIdentifier;
    } else if (transaction.originalTransaction.payment.productIdentifier) {
        productIdentifier = transaction.payment.productIdentifier;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseRestoredNotification object:self userInfo:@{kProductIDKey:productIdentifier}];
    [self finishTransaction:transaction wasSuccessful:YES];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    //Stops and logs failed transactions
    if (transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"Error: %@", [transaction error]);
        [self finishTransaction:transaction wasSuccessful:NO];
    } else {
        NSLog(@"User cancelled transaction: %@", [transaction error]);
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    NSLog(@"Payment Queue method, PING!");
    
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"payment purchasing");
                break;
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                NSLog(@"payment purchased");
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                NSLog(@"payment failed");
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                NSLog(@"payment restored");
                break;
            case SKPaymentTransactionStateDeferred:
                NSLog(@"payment deferred");
                break;
                
            default:
                break;
        }
    }
}

@end

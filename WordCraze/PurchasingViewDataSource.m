//
//  PurchasingViewDataSource.m
//  WordSwarm
//
//  Created by Jason Deckman on 9/27/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import "PurchasingViewDataSource.h"
#import "PurchaseController.h"
#import <StoreKit/StoreKit.h>

@implementation PurchasingViewDataSource

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [[PurchaseController sharedInstance].products count];
//}
//
//- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"product"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"product"];
//    }
//
//    SKProduct *product = [PurchaseController sharedInstance].products[indexPath.row];
//    cell.textLabel.text = product.localizedTitle;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", product.price, product.localizedDescription];
//
//    return cell;
//}

@end

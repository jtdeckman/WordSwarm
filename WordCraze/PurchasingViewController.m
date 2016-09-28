//
//  PurchasingViewController.m
//  WordSwarm
//
//  Created by Jason Deckman on 9/27/16.
//  Copyright © 2016 JDeckman. All rights reserved.
//

#import "PurchasingViewController.h"
#import "PurchasingViewDataSource.h"
#import "PurchaseController.h"

@interface PurchasingViewController() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) PurchasingViewDataSource *datasource;

@end

@implementation PurchasingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    //    self.datasource = [PurchasingViewDataSource new];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[PurchaseController sharedInstance] requestProducts];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsRequested:) name:kInAppPurchaseFetchedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:kInAppPurchaseCompletedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productRestored:) name:kInAppPurchaseRestoredNotification object:nil];
}

- (void)productsRequested:(NSNotification *)notification {
    [self.tableView reloadData];
}
- (void)productPurchased:(NSNotification *)notification {
    
}
- (void)productRestored:(NSNotification *)notification {
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[PurchaseController sharedInstance] purchaseOptionSelectedObjectIndex:indexPath.row];
}


// Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[PurchaseController sharedInstance].products count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"product"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"product"];
    }
    
    SKProduct *product = [PurchaseController sharedInstance].products[indexPath.row];
    cell.textLabel.text = product.localizedTitle;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", product.price, product.localizedDescription];
    
    return cell;
}

@end

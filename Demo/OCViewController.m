//
//  OCViewController.m
//  Demo
//
//  Created by 8-PC on 2020/6/2.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import "OCViewController.h"
#import <FXListKit/FXListKit.h>
#import <FXListKitAnimation/FXListKitAnimation.h>

@interface OCViewController ()

@property (nonatomic, strong) ListViewManager *listViewManager;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SectionProperty *property = [[SectionProperty alloc] initWithInset:UIEdgeInsetsZero minimumLineSpacing:10 minimumInteritemSpacing:0 referenceSizeForHeader:CGSizeZero referenceSizeForFooter:CGSizeZero];
    RowProperty *rowProperty = [[RowProperty alloc] initWithSingle:50];
    RowBridgeOC *row = [[RowBridgeOC alloc] initWithCellType:UICollectionViewCell.class cellConfig:^(UICollectionView * _Nonnull collectionView, UIView * _Nonnull view, NSIndexPath * _Nonnull indexPath) {
        view.backgroundColor = [UIColor purpleColor];
    } property:rowProperty didSelect:^{
        NSLog(@"didselect");
    }];
    SectionBridgeOC *section = [[SectionBridgeOC alloc] initWithProperty:property rows:@[row]];
    self.listViewManager = [[ListViewManager alloc] initWithSections:@[section]];

    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:UICollectionViewFlowLayout.alloc.init];

    [self.view addSubview:self.collectionView];
    [self.listViewManager configCollectionView:self.collectionView];
}


@end

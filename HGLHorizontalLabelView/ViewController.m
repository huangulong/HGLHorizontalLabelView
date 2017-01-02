//
//  ViewController.m
//  RoomChooseDemo
//
//  Created by huang long on 16/12/30.
//  Copyright © 2016年 huang gu long. All rights reserved.
//

#import "ViewController.h"
#import "GLLabelTableHeaderView.h"
#import "GLLabelTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,GLLabelTableHeaderViewDelegate,GLLabelTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic , strong)GLLabelTableHeaderView * headerView;

@property(nonatomic , assign)CGPoint point;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[GLLabelTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        cell.delegate = self;
        [cell loadCount:20 width:150];
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 20; i ++) {
        [array addObject:[NSString stringWithFormat:@"%ld%02d",indexPath.row,i]];
    }
    cell.titleArray = array;
    [cell setPoint:self.point delay:YES];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GLLabelTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (header == nil) {
        header = [[GLLabelTableHeaderView alloc] initWithReuseIdentifier:@"header"];
        header.delegate = self;
        [header loadCount:20 width:150];
        header.cellColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
        _headerView = header;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 20; i ++) {
        [array addObject:[NSString stringWithFormat:@"h%d",i]];
    }
    header.titleArray = array;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

#pragma mark - GLLabelTableHeaderViewDelegate
- (void)labelHeaderView:(GLLabelTableHeaderView *)headerView didScrollOffset:(CGPoint)contentOffset{
    NSArray *array = [self.tableView visibleCells];
    self.point = contentOffset;
    for (GLLabelTableViewCell *cell in array) {
        cell.point = contentOffset;
    }
}

- (void)labelHeaderView:(GLLabelTableHeaderView *)headerView didSelected:(NSInteger)index{
    
}

#pragma mark - GLLabelTableViewCellDelegate
- (void)labelCell:(GLLabelTableViewCell *)cell didSelected:(NSInteger)index{
    
}

- (void)labelCell:(GLLabelTableViewCell *)cell didScrollOffset:(CGPoint)contentOffset{
    //    NSLog(@"%s--%@-%@",__FUNCTION__,cell,NSStringFromCGPoint(contentOffset));
    [_headerView setPoint:contentOffset];
}

@end

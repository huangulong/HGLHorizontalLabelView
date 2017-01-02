//
//  GLViewController.m
//  RoomChooseDemo
//
//  Created by huang long on 16/12/30.
//  Copyright © 2016年 huang gu long. All rights reserved.
//

#import "GLViewController.h"
#import "GLLabelTableViewCell.h"
#import "GLLabelCustomHeaderView.h"
#import "Masonry.h"
@interface GLViewController ()<UITableViewDelegate,UITableViewDataSource,GLLabelTableViewCellDelegate,GLLabelCustomHeaderViewViewDelegate>

@property(nonatomic , weak)UITableView * tableView;

@property(nonatomic , weak)GLLabelCustomHeaderView * headerView;

@property(nonatomic , assign)CGPoint point;

@end

@implementation GLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - GLLabelCustomHeaderViewViewDelegate
- (void)labelCustomView:(GLLabelCustomHeaderView *)headerView didScrollOffset:(CGPoint)contentOffset{
    NSArray *array = [self.tableView visibleCells];
    self.point = contentOffset;
    for (GLLabelTableViewCell *cell in array) {
        cell.point = contentOffset;
    }
}
#pragma mark - GLLabelTableViewCellDelegate
- (void)labelCustomView:(GLLabelCustomHeaderView *)headerView didSelected:(NSInteger)index{
    
}

- (void)labelCell:(GLLabelTableViewCell *)cell didSelected:(NSInteger)index{
    
}

- (void)labelCell:(GLLabelTableViewCell *)cell didScrollOffset:(CGPoint)contentOffset{
    //    NSLog(@"%s--%@-%@",__FUNCTION__,cell,NSStringFromCGPoint(contentOffset));
    [_headerView setPoint:contentOffset];
}

#pragma mark - getter setter
- (UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.and.right.offset(0);
            make.top.equalTo(self.headerView.mas_bottom).with.offset(0);
        }];
        _tableView = tableView;
    }
    return _tableView;
    
}

- (GLLabelCustomHeaderView *)headerView{
    if (_headerView == nil) {
        GLLabelCustomHeaderView *header = [[GLLabelCustomHeaderView alloc] init];
        [header loadCount:20 width:150];
        header.delegate = self;
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 20; i ++) {
            [array addObject:[NSString stringWithFormat:@"h%d",i]];
        }
        header.titleArray = array;
        [self.view addSubview:header];
        [header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.offset(0);
            make.top.offset(64);
            make.height.offset(44);
        }];
        _headerView = header;
    }
    return _headerView;
}

@end

//
//  TGPopoverViewController.m
//  Popover
//
//  Created by tangge on 16/5/8.
//  Copyright © 2016年 tangge. All rights reserved.
//

#import "TGPopoverViewController.h"

@interface TGPopoverViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *popverView;

@end

@implementation TGPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld条数据",indexPath.row ];
    return cell;
}
@end

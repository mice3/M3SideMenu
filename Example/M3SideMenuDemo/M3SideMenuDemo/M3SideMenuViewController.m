//
//  M3SideMenuViewController.m
//  Ulu
//
//  Created by Rok Cresnik on 13/08/14.
//  Copyright (c) 2014 Rok Cresnik. All rights reserved.
//

#import "M3SideMenuViewController.h"
#import "M3SideMenu.h"
#import "M3SideMenuCell.h"

#define kCellIdentifier    @"SideMenuCell"

@interface M3SideMenuViewController ()<UITableViewDataSource, M3SideMenuDelegate>

@property (strong, nonatomic) M3SideMenu *menu;
@property (strong, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) NSMutableArray *tableObjects;

@end

@implementation M3SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableObjects         = [@[@{@"name":@"0"}] mutableCopy];
    
    self.menu = [[M3SideMenu alloc] initWithDelegate:self];
    
    UINib *vehicleCellNib = [UINib nibWithNibName:@"M3SideMenuCell" bundle:[NSBundle mainBundle]];
    [self.menu.tableView registerNib:vehicleCellNib forCellReuseIdentifier:kCellIdentifier];
    self.menu.isTableViewExtandingEnabled = YES;
    
    
    UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"User"]];
    CGRect frame = view.frame;
    frame.size = CGSizeMake(frame.size.width * 2, frame.size.height * 2);
    view.frame = frame;
    [self.menu configureBottom:view];
    [self.view addSubview:self.menu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClickHandler:(UIButton *)aButton {
    int val = 0;
    if (self.menu.buttonCount == 1
        || aButton.tag < (self.menu.buttonCount / 2)) {
        val = 1;
    }else {
        val = -1;
    }
    self.menu.buttonCount += val;
    
    UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"User"]];
    CGRect frame = view.frame;
    double factor = (arc4random() % 300) / 100;
    frame.size = CGSizeMake(frame.size.width * factor, frame.size.height * factor);
    view.frame = frame;
    [self.menu configureBottom:view];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    int i = 0;
    if (self.menu.isTableViewExtandingEnabled) {
//        The "Add new cell"-cell
        i = 1;
    }
    return [self.tableObjects count] + i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    M3SideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    NSString *description = @"Add new cell";
    UIColor *color = [UIColor greenColor];

    if (![indexPath isEqual:[NSIndexPath indexPathForItem:0 inSection:0]]) {
        cell.accessoryView = nil;
    } else {
        [self.menu.expandButton removeFromSuperview];
        cell.accessoryView = self.menu.expandButton;
    }
    
    
    if (indexPath.row != [self.tableObjects count]) {
        NSDictionary *dict = [self.tableObjects objectAtIndex:indexPath.row];
        description = [NSString stringWithFormat:@"Cell %@", [dict objectForKey:@"name"]];
        color = [UIColor redColor];
    }
    cell.avatarImageView.backgroundColor = color;
    cell.descriptionLabel.text = description;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0
        || indexPath.row != [self.tableObjects count]) {
        M3SideMenuCell *cell = (M3SideMenuCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.section]];
        cell.accessoryView = nil;
    }
    if (indexPath.row == [self.tableObjects count]) {
        long num = [[[self.tableObjects lastObject] objectForKey:@"name"] intValue];
        
        [tableView beginUpdates];
        [self.tableObjects addObject:@{@"name":[NSNumber numberWithLong:num+1]}];
        [tableView insertRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationLeft];
        [tableView endUpdates];
        
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else {
        [tableView beginUpdates];
        [self.tableObjects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationLeft];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                 withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kM3CellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kM3HeaderHeight;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

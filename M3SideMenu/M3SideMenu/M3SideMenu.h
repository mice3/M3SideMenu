//
//  M3SideMenu.h
//  Ulu
//
//  Created by Rok Cresnik on 13/08/14.
//  Copyright (c) 2014 Rok Cresnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol M3SideMenuDelegate <NSObject>

- (void)buttonClickHandler:(UIButton *)button;
@optional
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

// Configuration
// 1: Table
#define kPadding 10
#define kM3CellHeight     92
#define kM3HeaderHeight   15

@interface M3SideMenu : UIView

@property (weak, nonatomic) id<M3SideMenuDelegate>delegate;

@property (nonatomic) BOOL isTableViewExtandingEnabled;
@property (nonatomic) long buttonCount;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *expandButton;

- (id)initWithDelegate:(id)delegate;

- (void)configureBottom:(UIView *)aView;

- (void)removeCellAt:(NSIndexPath *)indexPath;
- (void)insertCellAt:(NSIndexPath *)indexPath;

@end

//
//  M3SideMenu.m
//  Ulu
//
//  Created by Rok Cresnik on 13/08/14.
//  Copyright (c) 2014 Rok Cresnik. All rights reserved.
//

#import "M3SideMenu.h"

@interface M3SideMenu() <UIGestureRecognizerDelegate>


@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;

@property (nonatomic) double delta;

@property (nonatomic) BOOL isDraging;
@property (nonatomic) double startX;

@end

@implementation M3SideMenu

- (id)initWithDelegate:(id)delegate {
    self = [[[NSBundle mainBundle] loadNibNamed:@"M3SideMenu" owner:self options:nil] objectAtIndex:0];
    self.tableView.delegate     = delegate;
    self.tableView.dataSource   = delegate;
    self.delegate = delegate;
    
    self.buttonCount = 2;
    
    
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    panRecognizer.delegate = self;
    [self.sideMenuButton addGestureRecognizer:panRecognizer];
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
    [self hideSideMenu:YES];
}

#pragma mark - Configuration
- (void)setButtonCount:(long)buttonCount {
    if (buttonCount == 0) return;
    
    if (self.buttonCount < buttonCount) {
        while ([self.buttonArray count] < buttonCount) {
            [self addNewButton];
        }
    } else {
        while ([self.buttonArray count] > buttonCount) {
            UIButton *button = (UIButton *)[self.buttonArray lastObject];
            [button removeFromSuperview];
            [self.buttonArray removeObject:button];
            button = nil;
        }
    }
    _buttonCount = buttonCount;

    [self repositionViewsAnimated:YES];
}

- (void)addNewButton {
    long tag = [(UIButton *)[self.buttonArray lastObject] tag] + 1;
    
    if (!self.buttonArray) {
        self.buttonArray = [@[] mutableCopy];
        tag = 0;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self.delegate action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    [button setTitle:[NSString stringWithFormat:@"Button %li", tag] forState:UIControlStateNormal];

    [self.buttonArray addObject:button];
    [self.navigationView addSubview:button];
}

- (void)configureTop:(UIView *)aView {
    [self configureView:aView inParentView:self.topView];
}

- (void)configureBottom:(UIView *)aView {
    [self configureView:aView inParentView:self.bottomView];
}

- (void)configureView:(UIView *)aView inParentView:(UIView *)parentView {
    [parentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGRect frame = parentView.frame;
    frame.size.height   = aView.frame.size.height + 2 * kPadding;
    parentView.frame    = frame;
    
    frame.origin.x  = (frame.size.width - aView.frame.size.width) / 2;
    frame.origin.y  = kPadding;
    frame.size      = aView.frame.size;
    aView.frame     = frame;
    [parentView addSubview:aView];
    
    [self repositionViewsAnimated:YES];
}

- (void)repositionViewsAnimated:(BOOL)animated {
    [UIView animateWithDuration:animated ? .5 : 0 animations:^{
        double height = [[UIScreen mainScreen] bounds].size.height;
        CGRect tFrame = self.topView.frame;
        CGRect mFrame = self.navigationView.frame;
        CGRect bFrame = self.bottomView.frame;
        
        tFrame.size.height = kM3CellHeight + kM3HeaderHeight;
        self.topView.frame = tFrame;
        mFrame.origin.y     = tFrame.origin.y + tFrame.size.height;
        mFrame.size.height  = height - tFrame.origin.y - tFrame.size.height - bFrame.size.height;
        self.navigationView.frame = mFrame;
        [self repositionButtons];
        
        bFrame.origin.y     = mFrame.origin.y + mFrame.size.height;
        self.bottomView.frame = bFrame;
    }];
}

- (void)repositionButtons {
    double buttonHeight = self.navigationView.frame.size.height / self.buttonCount;
    CGRect frame    = self.navigationView.frame;
    frame.origin.y  = 0;
    frame.size.height = buttonHeight;
    for (UIButton *button in self.buttonArray) {
        button.frame = frame;
        frame.origin.y += buttonHeight;
    }
    self.delta = self.navigationView.frame.size.height;
}

#pragma mark - Button handers
- (IBAction)sideMenuButtonClickHandler:(id)sender {
    BOOL hide = self.frame.origin.x == 0 ? YES : NO;
    [self hideSideMenu:hide];
}

- (IBAction)expandButtonClickHandler:(id)sender {
    BOOL expandTableView = YES;
    if (self.navigationView.frame.size.height == 0) {
        expandTableView = NO;
    }
    [self expandTableView:expandTableView];
}

#pragma mark - Animations
- (void)expandTableView:(BOOL)expand {
    BOOL isExpanded = (self.navigationView.frame.size.height == 0);
    if (expand == isExpanded) return;
    self.tableView.scrollEnabled = expand;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.expandButton setTransform:CGAffineTransformMakeRotation(expand ? M_PI: 0)];
        
        CGRect frame = self.topView.frame;
        frame.size.height += expand ? self.delta : -self.delta;
        self.topView.frame = frame;
        
        frame = self.navigationView.frame;
        frame.origin.y += expand ? self.delta : -self.delta;
        frame.size.height = expand ? 0 : self.delta;
        self.navigationView.frame = frame;
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }];
}

- (void)hideSideMenu:(BOOL)hide {
    [UIView animateWithDuration:0.5 animations:^{
        [self.sideMenuButton setTransform:CGAffineTransformMakeRotation(hide ? M_PI_2 : 0)];
        CGRect frame = self.frame;
        frame.origin.x = hide ? -280 : 0;
        self.frame = frame;
    }];
    
    [self expandTableView:NO];
}

#pragma mark - Touch management
- (void)panView:(UIPanGestureRecognizer *)recognizer {

    CGPoint currentPoint = [recognizer translationInView:self.superview];
//    NSLog(@"%.1f, %.1f", currentPoint.x, currentPoint.y);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.startX = self.frame.origin.x;
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat newX = self.startX + currentPoint.x;
            CGRect frame = self.frame;
            if (newX  < -self.navigationView.frame.size.width) {
                newX = -self.navigationView.frame.size.width;
            } else if (newX > 0) {
                newX = 0;
            }
            frame.origin.x = newX;
            self.frame = frame;
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            BOOL hide = (currentPoint.x < self.navigationView.frame.size.width / 2);
            [self hideSideMenu:hide];
        }
        default:
            break;
    }
}

@end

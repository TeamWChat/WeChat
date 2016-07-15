//
//  WCOutputToolManager.m
//  Demo_Chat
//
//  Created by admin on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCOutputToolManager.h"
#import "WCInputView.h"

static const CGFloat kInputViewHeight = 49;

#define kDefaultTopConstraint (kScreenHeight-kInputViewHeight)

@interface WCOutputToolManager ()

@property (nonatomic, weak) UIViewController *superViewController;
@property (nonatomic, weak) WCInputView *inputView;
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;

@end

@implementation WCOutputToolManager

#pragma mark - Initialization

+ (instancetype)showInSupperController:(UIViewController *)superViewController {
    WCOutputToolManager *manager = [[self alloc] initWithParentViewController:superViewController];
    return manager;
}

- (instancetype)initWithParentViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _superViewController = viewController;
        [self.view layoutIfNeeded];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - Setup UI

- (void)setupUI {
    
    [self bindingParentViewController];
    [self setupInputView];
    [self setupConstraint];
}

- (void)bindingParentViewController {
    [self.superViewController addChildViewController:self];
    [self.superViewController.view addSubview:self.view];
}

- (void)setupInputView {
    WCInputView *inputView = [WCInputView inputView];
    [self.view addSubview:inputView];
    self.inputView = inputView;
}

- (void)setupConstraint {
    
    //设置输入框约束
    [self.inputView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.inputView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.inputView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.inputView autoSetDimension:ALDimensionHeight toSize:kInputViewHeight];
    
    //设置自身约束
    [self.view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.view autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    self.topConstraint = [self.view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kDefaultTopConstraint];
    [self.view autoSetDimension:ALDimensionHeight toSize:kScreenHeight];
}


#pragma mark - UIKeyboardNotification Selector

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.topConstraint.constant = kDefaultTopConstraint - CGRectGetHeight(keyboardEndFrame);
    
    [UIView animateWithDuration:duration
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         _canHideKeyboard = YES;
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.topConstraint.constant = kDefaultTopConstraint;
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        _canHideKeyboard = NO;
    }];
}

#pragma mark - Public Method

- (void)endTyping {
    if (_canHideKeyboard) {
        [self.inputView endEditing:YES];
    }
}

@end

//
//  WCOutputToolManager.m
//  Demo_Chat
//
//  Created by admin on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCOutputToolManager.h"
#import "WCEmotionView.h"
#import "WCTypeSelectView.h"
#import "WCEmotion.h"

static const CGFloat kInputViewHeight       = 49.f;
static const CGFloat kEmotionViewHeight     = 270.f;
static const CGFloat kTypeSelectViewHeight  = kEmotionViewHeight;

#define kDefaultTopConstraint (kScreenHeight-kInputViewHeight)

@interface WCOutputToolManager ()<WCInputViewDelegate>

@property (nonatomic, weak) UIViewController        *superViewController;
@property (nonatomic, weak) WCInputView             *inputView;
@property (nonatomic, weak) WCEmotionView           *emotionView;
@property (nonatomic, weak) WCTypeSelectView        *typeSelectView;

/**当动画结束后才可以popDown*/
@property (nonatomic, assign) BOOL                  canPopDown;
/**自身与parentView的top约束*/
@property (nonatomic, strong) NSLayoutConstraint    *topConstraint;
/**emotionView 与 inputView的top约束*/
@property (nonatomic, strong) NSLayoutConstraint    *emotionTopConstraint;
/**typeSelectView 与 inputView的top约束*/
@property (nonatomic, strong) NSLayoutConstraint    *typeSelectTopConstraint;

@end

@implementation WCOutputToolManager

#pragma mark - Lazy Load

- (WCEmotionView *)emotionView {
    if (!_emotionView) {
        WCEmotionView *emotionView = [[WCEmotionView alloc] init];
        emotionView.emotions = [WCEmotion emojis];
        [self.view addSubview:emotionView];
        _emotionView = emotionView;
    }
    return _emotionView;
}

- (WCInputView *)inputView {
    if (!_inputView) {
        WCInputView *inputView = [WCInputView inputView];
        inputView.delegate = self;
        [self.view addSubview:inputView];
        _inputView = inputView;
    }
    return _inputView;
}

- (WCTypeSelectView *)typeSelectView {
    if (!_typeSelectView) {
        WCTypeSelectView *typeSelectView = [[WCTypeSelectView alloc] init];
        [self.view addSubview:typeSelectView];
        _typeSelectView = typeSelectView;
    }
    return _typeSelectView;
}

#pragma mark - Initialization

+ (instancetype)showInSupperController:(UIViewController *)superViewController {
    WCOutputToolManager *manager = [[self alloc] initWithParentViewController:superViewController];
    return manager;
}

- (instancetype)initWithParentViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _superViewController = viewController;
        [self.view setNeedsLayout];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _canPopDown = YES;
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didStartTalk:)
                                                 name:kWCInputViewDidStartTalkNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didPauseTalk:)
                                                 name:kWCInputViewDidPauseTalkNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didCancelTalk:)
                                                 name:kWCInputViewDidCancelTalkNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFinishTalk:)
                                                 name:kWCInputViewDidFinishTalkNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kWCInputViewDidFinishTalkNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kWCInputViewDidCancelTalkNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kWCInputViewDidPauseTalkNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kWCInputViewDidStartTalkNotification
                                                  object:nil];
}

#pragma mark - Setup UI

- (void)setupUI {
    
    [self bindingParentViewController];
    [self setupConstraint];
}

- (void)bindingParentViewController {
    [self.superViewController addChildViewController:self];
    [self.superViewController.view addSubview:self.view];
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
    
    [self.emotionView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.emotionView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.emotionView autoSetDimension:ALDimensionHeight toSize:kEmotionViewHeight];
    self.emotionTopConstraint = [self.emotionView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.inputView withOffset:0];
    self.emotionView.backgroundColor = [UIColor blueColor];
    
    [self.typeSelectView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.typeSelectView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.typeSelectView autoSetDimension:ALDimensionHeight toSize:kEmotionViewHeight];
    self.typeSelectTopConstraint = [self.typeSelectView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.inputView withOffset:0];
    self.typeSelectView.backgroundColor = [UIColor orangeColor];
}

#pragma mark - UIKeyboardNotification Selector

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(keyboardEndFrame);
    self.topConstraint.constant = kDefaultTopConstraint - keyboardHeight;
    self.emotionTopConstraint.constant = keyboardHeight;
    self.typeSelectTopConstraint.constant = keyboardHeight;
    [self animtedLayoutIfNeeded];
}

- (void)didStartTalk:(NSNotification *)notification {
    NSLog(@"开始聊天");
}

- (void)didCancelTalk:(NSNotification *)notification {
    NSLog(@"取消聊天");
}

- (void)didFinishTalk:(NSNotification *)notification {
    NSLog(@"完成聊天");
}

- (void)didPauseTalk:(NSNotification *)notification {
    NSLog(@"暂停聊天");
}

#pragma mark - WCInputViewDelegate

- (void)inputView:(WCInputView *)inputView voiceButtonDidTouch:(UIButton *)voiceButton {
    self.topConstraint.constant = kDefaultTopConstraint;
    [self animtedLayoutIfNeeded];
}

- (void)inputView:(WCInputView *)inputView keyboardButtonDidTouch:(UIButton *)keyboardButton {

}

- (void)inputView:(WCInputView *)inputView emotionButtonDidTouch:(UIButton *)emotionButton {
    self.topConstraint.constant = kDefaultTopConstraint - kEmotionViewHeight;
    self.emotionTopConstraint.constant = 0;
    self.typeSelectTopConstraint.constant = kEmotionViewHeight;
    [self animtedLayoutIfNeeded];
}

- (void)inputView:(WCInputView *)inputView typeSelectButtonDidTouch:(UIButton *)typeSelectButton {
    self.topConstraint.constant = kDefaultTopConstraint - kTypeSelectViewHeight;
    self.typeSelectTopConstraint.constant = 0;
    self.emotionTopConstraint.constant = kTypeSelectViewHeight;
    [self animtedLayoutIfNeeded];
}

#pragma mark - Public Method

- (void)popDown {
    if (!_canPopDown) {
        return;
    }
    
    self.topConstraint.constant = kDefaultTopConstraint;
    [self.inputView resetButtonState];
    [self animtedLayoutIfNeeded];
}

#pragma mark - Private Method

- (void)animtedLayoutIfNeeded {
    CGFloat animatedDuration = 0.25f;
    if ([self.delegate respondsToSelector:@selector(toolManager:willChangeFrameWithValue:duration:)]) {
        CGFloat topChangedValue = kDefaultTopConstraint - self.topConstraint.constant;
        [self.delegate toolManager:self willChangeFrameWithValue:topChangedValue duration:animatedDuration];
    }
    
    _canPopDown = NO;
    [UIView animateWithDuration:animatedDuration animations:^{
        [self.view setNeedsLayout];
    } completion:^(BOOL finished) {
        _canPopDown = YES;
    }];
}

@end

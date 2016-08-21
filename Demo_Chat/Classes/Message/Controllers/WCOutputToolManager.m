//
//  WCOutputToolManager.m
//  Demo_Chat
//
//  Created by admin on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCOutputToolManager.h"
#import "WCEmotionContainView.h"
#import "WCEmotion.h"
#import "WCFunctionItemView.h"
#import "WCEmotionBag.h"

static const CGFloat kInputViewHeight       = 49.f;
static const CGFloat kEmotionViewHeight     = 270.f;
static const CGFloat kTypeSelectViewHeight  = kEmotionViewHeight;

#define kDefaultTopConstraint (kScreenHeight-kInputViewHeight)

@interface WCOutputToolManager ()<WCInputViewDelegate>

@property (nonatomic, weak) UIViewController        *superViewController;
@property (nonatomic, weak) WCInputView             *inputView;//输入框视图
@property (nonatomic, weak) WCEmotionContainView    *emotionContainView;//表情视图
@property (nonatomic, weak) WCFunctionItemView      *functionItemView;//功能视图

/**当动画结束后才可以popDown*/
@property (nonatomic, assign) BOOL                  canPopDown;
/**自身与parentView的top约束*/
@property (nonatomic, strong) NSLayoutConstraint    *topConstraint;
/**emotionView 与 inputView的top约束*/
@property (nonatomic, strong) NSLayoutConstraint    *emotionTopConstraint;
/**typeSelectView 与 inputView的top约束*/
@property (nonatomic, strong) NSLayoutConstraint    *functionItemTopConstraint;

@end

@implementation WCOutputToolManager

#pragma mark - Lazy Load

- (WCEmotionContainView *)emotionContainView {
    if (!_emotionContainView) {
        WCEmotionContainView *emotionContainView = [[WCEmotionContainView alloc] init];
        [self.view addSubview:emotionContainView];
        _emotionContainView = emotionContainView;
    }
    return _emotionContainView;
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

- (WCFunctionItemView *)functionItemView {
    if (!_functionItemView) {
        WCFunctionItemView *functionItemView = [[WCFunctionItemView alloc] init];
        [self.view addSubview:functionItemView];
        _functionItemView = functionItemView;
    }
    return _functionItemView;
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
    
    [self.emotionContainView addEmotionBag:[[WCEmotionBag alloc] initWithTitle:@"默认表情" emotions:[WCEmotion emotions]]];
    [self.emotionContainView addEmotionBag:[[WCEmotionBag alloc] initWithTitle:@"Emoji表情" emotions:[WCEmotion emojis]]];
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
    
    [self.emotionContainView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.emotionContainView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.emotionContainView autoSetDimension:ALDimensionHeight toSize:kEmotionViewHeight];
    self.emotionTopConstraint = [self.emotionContainView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.inputView withOffset:0];
    
    [self.functionItemView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.functionItemView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.functionItemView autoSetDimension:ALDimensionHeight toSize:kEmotionViewHeight];
    self.functionItemTopConstraint = [self.functionItemView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.inputView withOffset:0];
    self.functionItemView.backgroundColor = [UIColor orangeColor];
    
    [self.view setNeedsLayout];
}

#pragma mark - UIKeyboardNotification Selector

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(keyboardEndFrame);
    self.topConstraint.constant = kDefaultTopConstraint - keyboardHeight;
    self.emotionTopConstraint.constant = keyboardHeight;
    self.functionItemTopConstraint.constant = keyboardHeight;
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
    self.functionItemTopConstraint.constant = kEmotionViewHeight;
    [self animtedLayoutIfNeeded];
}

- (void)inputView:(WCInputView *)inputView typeSelectButtonDidTouch:(UIButton *)typeSelectButton {
    self.topConstraint.constant = kDefaultTopConstraint - kTypeSelectViewHeight;
    self.functionItemTopConstraint.constant = 0;
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

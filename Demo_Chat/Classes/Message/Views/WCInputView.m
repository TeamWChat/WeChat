//
//  WCInputView.m
//  Demo_Chat
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCInputView.h"

NSString *const kWCInputViewDidStartTalkNotification        = @"kWCInputViewDidStartTalkNotification";
NSString *const kWCInputViewDidCancelTalkNotification       = @"kWCInputViewDidCancelTalkNotification";
NSString *const kWCInputViewDidPauseTalkNotification        = @"kWCInputViewDidPauseTalkNotification";
NSString *const kWCInputViewDidFinishTalkNotification       = @"kWCInputViewDidFinishTalkNotification";

NSString *const kWCInputViewDidSendMessageNotification  = @"kWCInputViewDidSendMessageNotification";
NSString *const kWCInputViewMessageKey                  = @"kWCInputViewMessageKey";

@interface WCInputView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton   *emotionButton;
@property (weak, nonatomic) IBOutlet UIButton   *voiceButton;
@property (weak, nonatomic) IBOutlet UIButton   *typeSelectButton;

@property (nonatomic, weak) UIButton            *talkButton;

@end

@implementation WCInputView

#pragma mark - Initialization

+ (instancetype)inputView {
    return [[[NSBundle mainBundle] loadNibNamed:@"WCInputView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [self setSelectedButtonHLImage];
    [self setupTalkButton];
}

- (void)setSelectedButtonHLImage {
    UIImage *keyboardHLImage = [UIImage imageNamed:@"ToolViewKeyboardHL"];
    UIControlState state = UIControlStateHighlighted|UIControlStateSelected;
    [self.emotionButton setBackgroundImage:keyboardHLImage forState:state];
    [self.voiceButton setBackgroundImage:keyboardHLImage forState:state];
}

- (void)setupTalkButton {
    UIButton *talkButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [talkButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [talkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:talkButton];
    self.talkButton = talkButton;
    talkButton.hidden = YES;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(selectorToTalkButtonPanGesture:)];
    [talkButton addGestureRecognizer:panGesture];
    
    [talkButton addTarget:self action:@selector(respondsToTalkButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    
    UIView *textField = self.textField;
    [talkButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:textField withOffset:0];
    [talkButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:textField withOffset:0];
    [talkButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:textField withOffset:0];
    [talkButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:textField withOffset:0];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSDictionary *userInfo = @{kWCInputViewMessageKey:textField.text};
    [[NSNotificationCenter defaultCenter] postNotificationName:kWCInputViewDidSendMessageNotification
                                                        object:nil
                                                      userInfo:userInfo];
    return YES;
}

#pragma mark - Action

- (IBAction)respondsToEmotionButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {//点了表情按钮
        if ([self.delegate respondsToSelector:@selector(inputView:emotionButtonDidTouch:)]) {
            [self.delegate inputView:self emotionButtonDidTouch:sender];
        }
        [self.textField resignFirstResponder];
    } else {//点了键盘按钮
        if ([self.delegate respondsToSelector:@selector(inputView:keyboardButtonDidTouch:)]) {
            [self.delegate inputView:self keyboardButtonDidTouch:sender];
        }
        [self.textField becomeFirstResponder];
    }
    
    self.talkButton.hidden = YES;
    self.voiceButton.selected = NO;
    self.typeSelectButton.selected = NO;
}

- (IBAction)rensondsToVoiceButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {//点了声音按钮
        if ([self.delegate respondsToSelector:@selector(inputView:voiceButtonDidTouch:)]) {
            [self.delegate inputView:self voiceButtonDidTouch:sender];
        }
        self.talkButton.hidden = NO;
        [self.textField resignFirstResponder];
    } else {//点了键盘按钮
        if ([self.delegate respondsToSelector:@selector(inputView:keyboardButtonDidTouch:)]) {
            [self.delegate inputView:self keyboardButtonDidTouch:sender];
        }
        self.talkButton.hidden = YES;
        [self.textField becomeFirstResponder];
    }
    
    self.emotionButton.selected = NO;
    self.typeSelectButton.selected = NO;
}

- (IBAction)respondsToTypeSelectButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(inputView:typeSelectButtonDidTouch:)]) {
        [self.delegate inputView:self typeSelectButtonDidTouch:sender];
    }
    
    if (sender.selected) {
        [self.textField resignFirstResponder];
    } else {
        [self.textField becomeFirstResponder];
    }
    
    self.talkButton.hidden = YES;
    self.voiceButton.selected = NO;
    self.emotionButton.selected = NO;
}

#pragma mark - Selector

- (void)selectorToTalkButtonPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:sender.view];
    BOOL inView = CGRectContainsPoint(sender.view.frame, touchPoint);
    
    if (sender.state != UIGestureRecognizerStateEnded) {
        if (inView) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kWCInputViewDidStartTalkNotification object:nil];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kWCInputViewDidPauseTalkNotification object:nil];
        }
    } else {
        if (inView) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kWCInputViewDidFinishTalkNotification object:nil];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kWCInputViewDidCancelTalkNotification object:nil];
        }
    }
}

- (void)selectorToTalkButtonTapGesture:(UITapGestureRecognizer *)sender {
    }

- (void)respondsToTalkButtonTouchDown:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kWCInputViewDidStartTalkNotification object:nil];
}

#pragma mark - Public Method

- (void)resetButtonState {
    self.emotionButton.selected = NO;
    self.typeSelectButton.selected = NO;
    [self.textField resignFirstResponder];
}

@end

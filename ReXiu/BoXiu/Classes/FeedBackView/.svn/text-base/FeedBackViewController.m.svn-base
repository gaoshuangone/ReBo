//
//  FeedBackViewController.m
//  BoXiu
//
//  Created by andy on 14-4-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "FeedBackViewController.h"
#import "FeedBackModel.h"
#import "EWPTextView.h"

@interface FeedBackViewController ()

@property (nonatomic,strong) EWPTextView *textView;

@end

@implementation FeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseScroolViewType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"意见反馈";
    
    _textView = [[EWPTextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 133)];
    _textView.placeHolder = @"亲，写下您的意见，让我们做的更好";
    _textView.font = [UIFont boldSystemFontOfSize:13];
    _textView.placeHolderColor = [CommonFuction colorFromHexRGB:@"d7d7d7"];
    _textView.layer.borderWidth = 0;
    _textView.textColor =[UIColor lightGrayColor];
    [self.scrollView addSubview:_textView];
    
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(300, 42)];
//    UIImage *highImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(300, 42)];
    
    EWPButton *commitBtn = [[EWPButton alloc] initWithFrame:CGRectMake(40, 165, 240, 33)];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    commitBtn.layer.masksToBounds = YES;
    commitBtn.layer.cornerRadius = 16.5;
    commitBtn.layer.borderWidth = 1.0f;
    commitBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [commitBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:IMAGE_SUBJECT_SEL(240, 33) forState:UIControlStateHighlighted];
    [commitBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
//    [commitBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateHighlighted];
    [self.scrollView addSubview:commitBtn];
    
    __weak typeof(self) weakSelf = self;
    [commitBtn setButtonBlock:^(id sender)
     {
        __strong typeof(self) strongSelf = weakSelf;
         //提交意见反馈
         [strongSelf.textView resignFirstResponder];
         if (strongSelf.textView.text.length==0 || [strongSelf.textView.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0) {
               [strongSelf showNoticeInWindow:@"请填写反馈信息!"];
             return ;
         }
         
         
         BOOL isHaveEjmail =  [self isContainsEmoji:strongSelf.textView.text];
         
         if (isHaveEjmail) {
             [self showNoticeInWindow:@"提交失败，内容不能包含特殊字符"];
             return;
         }

         
         //提交
         NSMutableDictionary *dict = [NSMutableDictionary dictionary];
         [dict setObject:strongSelf.textView.text forKey:@"content"];
         
         [strongSelf requestDataWithAnalyseModel:[FeedBackModel class] params:dict success:^(id object)
          {
              /*成功返回数据*/
              FeedBackModel *model = object;
              if (model.result == 0)
              {
                  [strongSelf showNoticeInWindow:@"反馈信息提交成功!"];
                  [strongSelf performSelector:@selector(popCanvasWithArgment:) withObject:nil afterDelay:3];
              }
          }
           fail:^(id object)
          {
              /*失败返回数据*/
          }];

     }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [self moveInputBarWithKeyboardHeight:100 withDuration:animationDuration];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [self moveInputBarWithKeyboardHeight:-100 withDuration:animationDuration];
}

- (void)moveInputBarWithKeyboardHeight:(float)keyboardHeight withDuration:(NSTimeInterval)animationDuration
{
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height + keyboardHeight);
    } completion:^(BOOL finished) {
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

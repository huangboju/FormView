//
//  MTExpDetailVC.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/15.
//

#import "MTExpDetailVC.h"

@interface MTExpDetailVC ()

/// textView
@property (nonatomic, strong) UITextView *textView;

@end

// MTExpDetailVC
@implementation MTExpDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
}

- (void)setText:(NSString *)text {
    self.textView.text = text;
}

- (void)initSubViews {
    [self.view addSubview:self.textView];
    [self.textView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.textView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.textView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.textView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = UITextView.new;
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.editable = NO;
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _textView;
}

@end

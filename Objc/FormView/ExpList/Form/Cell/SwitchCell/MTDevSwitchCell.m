//
//  MTDevSwitchCell.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/2/20.
//

#import "MTDevSwitchCell.h"

#import "UIView+Convenience.h"

@interface MTDevSwitchCellItem()

@property (nonatomic, copy)  NSString *title;

@property (nonatomic, assign) BOOL isOn;

@end


@implementation MTDevSwitchCellItem


- (void)addTitle:(NSString *)title {
    self.title = title;
}

- (void)addIsOn:(BOOL)isOn {
    self.isOn = isOn;
}

@end



@interface MTDevSwitchCell()

@property (nonatomic, strong) UISwitch *switchView;

@property (nonatomic, strong) MTDevSwitchCellItem *viewData;

@end

@implementation MTDevSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.textLabel.font = [UIFont boldSystemFontOfSize:18];

        [self.contentView addSubview:self.switchView];
        [self.switchView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-15].active = YES;
        [self.switchView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}

- (void)switchViewValueChanged:(UISwitch *)switchView {
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(MTDevSwitchCellDelegate)]) {
        self.viewData.isOn = switchView.isOn;
        [(id <MTDevSwitchCellDelegate>)vc switchCellSwitchViewValueChanged:self];
    }
}

- (void)updateViewData:(MTDevSwitchCellItem *)viewData {
    _viewData = viewData;
    self.textLabel.text = viewData.title;
    self.switchView.on = viewData.isOn;
}

- (UISwitch *)switchView {
    if (!_switchView) {
        _switchView = UISwitch.new;
        _switchView.translatesAutoresizingMaskIntoConstraints = NO;
        [_switchView addTarget:self action:@selector(switchViewValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

@end

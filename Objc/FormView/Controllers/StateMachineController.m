//
//  StateMachineController.m
//  FormView
//
//  Created by 黄伯驹 on 28/02/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "StateMachineController.h"
#import <TransitionKit.h>

@interface StateMachineController ()

@property (nonatomic, strong) TKStateMachine *stateMachine;

@end

@implementation StateMachineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *onItem = [[UIBarButtonItem alloc] initWithTitle:@"on" style:UIBarButtonItemStylePlain target:self action:@selector(onAction)];
    UIBarButtonItem *offItem = [[UIBarButtonItem alloc] initWithTitle:@"off" style:UIBarButtonItemStylePlain target:self action:@selector(offAction)];
    self.navigationItem.rightBarButtonItems = @[onItem, offItem];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction)];
    [self.view addGestureRecognizer:longPress];
    
    [self initStateMachine];
}

- (void)longPressAction {
    NSError *error;
    BOOL bRes =
    [self.stateMachine fireEvent:@"turn_broken_light"
                        userInfo:@{}
                           error:&error];
    if (!bRes) {
        NSLog(@"event error %@", [error localizedDescription]);
    }
}

- (void)offAction {
    NSError *error;
    BOOL bRes =
    [self.stateMachine fireEvent:@"turn_off_light"
                        userInfo:@{}
                           error:&error];
    if (!bRes) {
        NSLog(@"event error %@", [error localizedDescription]);
    }
}

- (void)onAction {
    NSError *error;
    BOOL bRes =
    [self.stateMachine fireEvent:@"turn_on_light"
                        userInfo:@{}
                           error:&error];
    if (!bRes) {
        NSLog(@"event error %@", [error localizedDescription]);
    }
}

- (void)initStateMachine {
    __weak typeof(self) weakSelf = self;

    TKState *offState = [TKState stateWithName:@"off"];
    [offState setDidEnterStateBlock:^(TKState *state, TKTransition *transition) {
        weakSelf.view.backgroundColor = [UIColor blackColor];
    }];

    TKState *onState = [TKState stateWithName:@"on"];
    [onState setDidEnterStateBlock:^(TKState *state, TKTransition *transition) {
        weakSelf.view.backgroundColor = [UIColor whiteColor];
    }];
    TKState *brokenState = [TKState stateWithName:@"broken"];
    [brokenState setDidEnterStateBlock:^(TKState *state, TKTransition *transition) {
        weakSelf.view.backgroundColor = [UIColor whiteColor];
    }];

    [self.stateMachine addStates:@[offState, onState, brokenState]];
    self.stateMachine.initialState = offState;
    
    TKEvent *offEvent = [TKEvent eventWithName:@"turn_off_light" transitioningFromStates:@[onState] toState:offState];
    TKEvent *onEvent = [TKEvent eventWithName:@"turn_on_light" transitioningFromStates:@[offState] toState:onState];
    TKEvent *cutEvent = [TKEvent eventWithName:@"turn_broken_light" transitioningFromStates:@[offState] toState:onState];
    [self.stateMachine addEvents:@[offEvent, onEvent, cutEvent]];
    [self.stateMachine activate];
}

- (TKStateMachine *)stateMachine {
    if (!_stateMachine) {
        _stateMachine = [TKStateMachine new];
    }
    return _stateMachine;
}

@end

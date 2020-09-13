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

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *onItem = [[UIBarButtonItem alloc] initWithTitle:@"on" style:UIBarButtonItemStylePlain target:self action:@selector(onAction)];
    UIBarButtonItem *offItem = [[UIBarButtonItem alloc] initWithTitle:@"off" style:UIBarButtonItemStylePlain target:self action:@selector(offAction)];
    self.navigationItem.rightBarButtonItems = @[onItem, offItem];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction)];
    [self.view addGestureRecognizer:longPress];
    
    [self initStateMachine];
    [self initInboxStateMachine];
    
    [self initSimpleStateMachine];
}

- (void)initSimpleStateMachine {
    TKState *S1 = [TKState stateWithName:@"S1"];
    TKState *S2 = [TKState stateWithName:@"S2"];
    TKState *S3 = [TKState stateWithName:@"S3"];

    // Simple transition
    TKEvent *simple = [TKEvent eventWithName:@"Simple Event" transitioningFromStates:@[S1, S2] toState:S3];

    // Add more transitions to existing event
    [simple addTransitionFromStates:@[S3] toState:S1];

    // Or add them all at once
//    TKEvent *complex = [TKEvent eventWithName:@"Complex Event" transitions:@{ @[S1, S2]: S3, @[S3]: S1 }];
}

- (void)initInboxStateMachine {
    TKStateMachine *inboxStateMachine = [TKStateMachine new];

    TKState *unread = [TKState stateWithName:@"Unread"];
    [unread setDidEnterStateBlock:^(TKState *state, TKTransition *transition) {
        [self incrementUnreadCount];
    }];
    TKState *read = [TKState stateWithName:@"Read"];
    [read setDidExitStateBlock:^(TKState *state, TKTransition *transition) {
        [self decrementUnreadCount];
    }];
    TKState *deleted = [TKState stateWithName:@"Deleted"];
    [deleted setDidEnterStateBlock:^(TKState *state, TKTransition *transition) {
        [self moveMessageToTrash];
    }];

    [inboxStateMachine addStates:@[ unread, read, deleted ]];
    inboxStateMachine.initialState = unread;

    TKEvent *viewMessage = [TKEvent eventWithName:@"View Message" transitioningFromStates:@[ unread ] toState:read];
    TKEvent *deleteMessage = [TKEvent eventWithName:@"Delete Message" transitioningFromStates:@[ read, unread ] toState:deleted];
    TKEvent *markAsUnread = [TKEvent eventWithName:@"Mark as Unread" transitioningFromStates:@[ read, deleted ] toState:unread];

    [inboxStateMachine addEvents:@[ viewMessage, deleteMessage, markAsUnread ]];

    // Activate the state machine
    [inboxStateMachine activate];

    [inboxStateMachine isInState:@"Unread"]; // YES, the initial state

    // Fire some events
    NSDictionary *userInfo = nil;
    NSError *error = nil;
    BOOL success = [inboxStateMachine fireEvent:@"View Message" userInfo:userInfo error:&error]; // YES
    success = [inboxStateMachine fireEvent:@"Delete Message" userInfo:userInfo error:&error]; // YES
    success = [inboxStateMachine fireEvent:@"Mark as Unread" userInfo:userInfo error:&error]; // YES

    success = [inboxStateMachine canFireEvent:@"Mark as Unread"]; // NO

    // Error. Cannot mark an Unread message as Unread
    success = [inboxStateMachine fireEvent:@"Mark as Unread" userInfo:nil error:&error]; // NO

    // error is an TKInvalidTransitionError with a descriptive error message and failure reason
}

- (void)incrementUnreadCount {
    
}

- (void)decrementUnreadCount {
    
}

- (void)moveMessageToTrash {
    
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

- (TKStateMachine *)stateMachine {
    if (!_stateMachine) {
        _stateMachine = [TKStateMachine new];
    }
    return _stateMachine;
}

@end

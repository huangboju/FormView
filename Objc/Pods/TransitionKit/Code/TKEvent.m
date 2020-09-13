//
//  TKEvent.m
//  TransitionKit
//
//  Created by Blake Watters on 3/17/13.
//  Copyright (c) 2013 Blake Watters. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "TKEvent.h"
#import "TKState.h"

static NSString *TKDescribeStates(NSArray *states)
{
    if (! [states count]) return @"any state";
    
    NSMutableString *description = [NSMutableString string];
    [states enumerateObjectsUsingBlock:^(TKState *state, NSUInteger idx, BOOL *stop) {
        NSString *separator = @"";
        if (idx < [states count] - 1) separator = (idx == [states count] - 2) ? @" and " : @", ";
        [description appendFormat:@"'%@'%@", state.name, separator];
    }];
    return description;
}


@interface TKEvent ()
@property (nonatomic, copy, readwrite) NSString *name;

/** An array of arrays containing, each containning two values: [0] -> source state name, [1] -> destination state name   */
@property (nonatomic, readwrite) NSArray *sourceToDestinationNameMap;

@property (nonatomic) NSArray *sourceStates;
@property (nonatomic) NSArray *destinationStates;

@property (nonatomic, copy) BOOL (^shouldFireEventBlock)(TKEvent *, TKTransition *);
@property (nonatomic, copy) void (^willFireEventBlock)(TKEvent *, TKTransition *);
@property (nonatomic, copy) void (^didFireEventBlock)(TKEvent *, TKTransition *);
@end

@implementation TKEvent

+ (instancetype)eventWithName:(NSString *)name transitioningFromStates:(NSArray *)sourceStates toState:(TKState *)destinationState
{
    if (! [name length]) [NSException raise:NSInvalidArgumentException format:@"The event name cannot be blank."];
    if (!destinationState) [NSException raise:NSInvalidArgumentException format:@"The destination state cannot be nil."];
	
    TKEvent *event = [self new];
	
    event.name = name;
    [event addTransitionFromStates:sourceStates toState:destinationState];
	
    return event;
}

- (TKState*) sourceStateWithName:(NSString*) inStateName
{
	for (TKState *sourceState in self.sourceStates)
	{
		if ([sourceState.name isEqualToString:inStateName])
		{
			return sourceState;
		}
	}
	return nil;
}

- (TKState*) destinationStateWithName:(NSString*) inStateName
{
	for (TKState *destinationState in self.destinationStates)
	{
		if ([destinationState.name isEqualToString:inStateName])
		{
			return destinationState;
		}
	}
	return nil;
}

- (BOOL) hasTransitionFromState:(NSString*) inSourceStateName toState:(NSString*) inDestinationStateName
{
	NSParameterAssert(inDestinationStateName);
	
	return [self.sourceToDestinationNameMap containsObject:@[inSourceStateName?:[NSNull null], inDestinationStateName]];
}

- (void)addTransitionFromStates:(NSArray *)sourceStates toState:(TKState *)destinationState
{
	NSParameterAssert(destinationState);
	
	if (sourceStates == nil)
	{
		if (YES == [self hasTransitionFromState:nil toState:destinationState.name])
		{
			[NSException raise:NSInvalidArgumentException format:@"A transition from state `nil` to `%@` is already registered for the event %@", destinationState.name, self.name];
		}
		self.sourceToDestinationNameMap = [self.sourceToDestinationNameMap arrayByAddingObject:@[[NSNull null], destinationState.name]];
		if (nil == [self destinationStateWithName:destinationState.name])
		{
			self.destinationStates = [self.destinationStates arrayByAddingObject:destinationState];
		}
	}
	else
	{
		// make sure the source states are disjunct with the already defined source states
		for (TKState *sourceState in sourceStates)
		{
			if (! [sourceState isKindOfClass:[TKState class]])
			{
				[NSException raise:NSInvalidArgumentException format:@"Expected a `TKState` object, instead got a `%@` (%@)", [sourceState class], sourceState];
			}
			
			if (nil != [self sourceStateWithName:sourceState.name])
			{
				[NSException raise:NSInvalidArgumentException format:@"A source state named `%@` is already registered for the event %@", sourceState.name, self.name];
			}
			// make sure the source -> destination transition is not yet added
			if (YES == [self hasTransitionFromState:sourceState.name toState:destinationState.name])
			{
				 [NSException raise:NSInvalidArgumentException format:@"A transition from state `%@` to `%@` is already registered for the event %@", sourceState.name, destinationState.name, self.name];
			}
			self.sourceToDestinationNameMap = [self.sourceToDestinationNameMap arrayByAddingObject:@[sourceState.name, destinationState.name]];
			self.sourceStates = [self.sourceStates arrayByAddingObject:sourceState];
			if (nil == [self destinationStateWithName:destinationState.name])
			{
				self.destinationStates = [self.destinationStates arrayByAddingObject:destinationState];
			}
		}
	}
}

- (TKState *)destinationStateForSourceState:(TKState *)sourceState
{
	for (NSArray *statePair in self.sourceToDestinationNameMap)
	{
		if ([statePair[0] isEqualToString:sourceState.name])
		{
			return [self destinationStateWithName:statePair[1]];
		}
	}
	return nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@:%p '%@' transitions from %@ to %@>", NSStringFromClass([self class]), self, self.name, TKDescribeStates(self.sourceStates), TKDescribeStates(self.destinationStates)];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (self)
	{
		self.name = [aDecoder decodeObjectForKey:@"name"];
		self.sourceToDestinationNameMap = [aDecoder decodeObjectForKey:@"sourceToDestinationNameMap"];
		self.sourceStates = [aDecoder decodeObjectForKey:@"sourceStates"];
		self.destinationStates = [aDecoder decodeObjectForKey:@"destinationStates"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
	[aCoder encodeObject:self.sourceToDestinationNameMap forKey:@"sourceToDestinationNameMap"];
	[aCoder encodeObject:self.sourceStates forKey:@"sourceStates"];
	[aCoder encodeObject:self.destinationStates forKey:@"destinationStates"];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    TKEvent *copiedEvent = [[[self class] allocWithZone:zone] init];
    copiedEvent.name = self.name;
    copiedEvent.sourceToDestinationNameMap = self.sourceToDestinationNameMap;
	copiedEvent.sourceStates = self.sourceStates;
	copiedEvent.destinationStates = self.destinationStates;
	
    copiedEvent.shouldFireEventBlock = self.shouldFireEventBlock;
    copiedEvent.willFireEventBlock = self.willFireEventBlock;
    copiedEvent.didFireEventBlock = self.didFireEventBlock;
	
    return copiedEvent;
}

@end

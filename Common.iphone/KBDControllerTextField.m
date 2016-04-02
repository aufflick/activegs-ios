//
//  KBDControllerTextField.m
//  activegs
//
//  Created by Mark Aufflick on 1/04/2016.
//
//

#import "KBDControllerTextField.h"

@interface KBDControllerKeyCommands : NSObject

@property (nonatomic, readonly) UIKeyCommand * esc;
@property (nonatomic, readonly) UIKeyCommand * escAlt;
@property (nonatomic, readonly) UIKeyCommand * up;
@property (nonatomic, readonly) UIKeyCommand * down;
@property (nonatomic, readonly) UIKeyCommand * left;
@property (nonatomic, readonly) UIKeyCommand * right;

@property (nonatomic, readonly) NSArray * allKeyCommands;

@end

#define key(str) [UIKeyCommand keyCommandWithInput:(str) modifierFlags:0 action:act]

@implementation KBDControllerKeyCommands

- (instancetype)init
{
    if (nil == (self = [super init]))
        return nil;
    
    SEL act = @selector(receivedKeyCommand:);
    
    _esc = key(UIKeyInputEscape);
    _up = key(UIKeyInputUpArrow);
    _down = key(UIKeyInputDownArrow);
    _left = key(UIKeyInputLeftArrow);
    _right = key(UIKeyInputRightArrow);
    
    _escAlt = [UIKeyCommand keyCommandWithInput:@"`" modifierFlags:UIKeyModifierCommand action:act discoverabilityTitle:@"ESC Equivalent"];
    
    _allKeyCommands = @[_esc, _escAlt, _up, _down, _left, _right];
    
    return self;
}

@end

static KBDControllerKeyCommands * _KBDControllerKeyCommands;

@implementation KBDControllerTextField

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _KBDControllerKeyCommands = [[KBDControllerKeyCommands alloc] init];
    });
}

- (NSArray<UIKeyCommand *> *)keyCommands
{
    return _KBDControllerKeyCommands.allKeyCommands;
}

- (void)receivedKeyCommand:(UIKeyCommand *)keyCommand
{
    KBDControllerKeyCommands * kc = _KBDControllerKeyCommands;
    
    if (keyCommand == kc.esc || keyCommand == kc.escAlt) [self.keyCommandDelegate esc:keyCommand];
    else if (keyCommand == kc.up)    [self.keyCommandDelegate up:keyCommand];
    else if (keyCommand == kc.down)  [self.keyCommandDelegate down:keyCommand];
    else if (keyCommand == kc.left)  [self.keyCommandDelegate left:keyCommand];
    else if (keyCommand == kc.right) [self.keyCommandDelegate right:keyCommand];
    else
        NSAssert(0, @"Unexpected key command: %@", keyCommand);
}

@end

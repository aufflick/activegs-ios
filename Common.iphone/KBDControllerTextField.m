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

@property (nonatomic, readonly) NSArray * allKeyCommands;

@end

@implementation KBDControllerKeyCommands

- (instancetype)init
{
    if (nil == (self = [super init]))
        return nil;
    
    SEL act = @selector(receivedKeyCommand:);
    
    _esc = [UIKeyCommand keyCommandWithInput:UIKeyInputEscape modifierFlags:0 action:act];
    
    _escAlt = [UIKeyCommand keyCommandWithInput:@"`" modifierFlags:UIKeyModifierCommand action:act discoverabilityTitle:@"ESC Equivalent"];
    
    _allKeyCommands = @[_esc, _escAlt];
    
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
    
    if (keyCommand == kc.esc || keyCommand == kc.escAlt)
    {
        [self.keyCommandDelegate esc:keyCommand];
    }
    else
    {
        NSAssert(0, @"Unexpected key command: %@", keyCommand);
    }
}

@end
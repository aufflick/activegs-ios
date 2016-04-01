//
//  KBDControllerTextField.h
//  activegs
//
//  Created by Mark Aufflick on 1/04/2016.
//
//

#import <UIKit/UIKit.h>

@protocol KBDControllerTextFieldDelegate;

@interface KBDControllerTextField : UITextField

@property(nullable, nonatomic, weak) id<KBDControllerTextFieldDelegate> keyCommandDelegate;

@end

@protocol KBDControllerTextFieldDelegate <NSObject>

/// may be triggered by esc key or Command-`
- (void)esc:(UIKeyCommand * _Nonnull)keyCommand;

@end
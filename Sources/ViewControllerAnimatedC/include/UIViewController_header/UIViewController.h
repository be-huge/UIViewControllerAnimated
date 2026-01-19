#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (beHuge)
@property (weak, nonatomic) id transitioningDelegate;
- (UIView *)_parentContentContainer;
- (void)dismissViewControllerAnimated:(BOOL)a0 completion:(id /* block */)a1;
@end
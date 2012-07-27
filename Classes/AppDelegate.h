#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController * navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)  UINavigationController * navigationController;
@property (strong, nonatomic) ViewController *viewController;

@end


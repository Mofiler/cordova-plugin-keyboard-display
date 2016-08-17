//
//  CDVKeyboardDisplay.m
//  Oppa
//
//  Extends the AppDelegate to pop up the keyboard when programmatically focussing an input field.

#import <objc/runtime.h>
#import "AppDelegate.h"

@implementation AppDelegate(AppDelegate)

/**
 * This is main kick off after the app inits, the views and Settings are setup here. (preferred - iOS4 and up)
 */
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
  [self keyboardDisplayDoesNotRequireUserAction];
  
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void) keyboardDisplayDoesNotRequireUserAction {
  SEL sel = sel_getUid("_startAssistingNode:userIsInteracting:blurPreviousNode:userObject:");
  Class WKContentView = NSClassFromString(@"WKContentView");
  Method method = class_getInstanceMethod(WKContentView, sel);
  IMP originalImp = method_getImplementation(method);
  IMP imp = imp_implementationWithBlock(^void(id me, void* arg0, BOOL arg1, BOOL arg2, id arg3) {
    ((void (*)(id, SEL, void*, BOOL, BOOL, id))originalImp)(me, sel, arg0, TRUE, arg2, arg3);
  });
  method_setImplementation(method, imp);
}

@end

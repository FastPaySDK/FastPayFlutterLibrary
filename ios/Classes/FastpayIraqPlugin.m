#import "FastpayIraqPlugin.h"
#if __has_include(<fastpay_merchant/fastpay_merchant-Swift.h>)
#import <fastpay_merchant/fastpay_merchant-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fastpay_merchant-Swift.h"
#endif

@implementation FastpayIraqPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFastpayIraqPlugin registerWithRegistrar:registrar];
}
@end

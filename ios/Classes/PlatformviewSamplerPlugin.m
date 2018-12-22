#import "PlatformviewSamplerPlugin.h"
#import <platformview_sampler/platformview_sampler-Swift.h>

@implementation PlatformviewSamplerPlugin
    + (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
[registrar registerViewFactory: [[UIActivityIndicatorFactory alloc] initWithMessenger:[registrar messenger]] withId:@"plugins/activity_indicator"];
}
@end

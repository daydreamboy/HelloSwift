//
//  IssueRemoveSubscriberCauseCrashViewController.m
//  HelloMetricKit
//
//  Created by wesley_chen on 2022/11/28.
//

#import "IssueRemoveSubscriberCauseCrashViewController.h"
#import <MetricKit/MetricKit.h>

@interface IssueRemoveSubscriberCauseCrashViewController () <MXMetricManagerSubscriber>

@end

@implementation IssueRemoveSubscriberCauseCrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[MXMetricManager sharedManager] addSubscriber:self];
}

- (void)dealloc {
    // Apple Documentation: If you call this function from a method that deallocates the object, your app might crash.
    // CRASH: removeSubscriber internally access self which was released
    [[MXMetricManager sharedManager] removeSubscriber:self];
}

#pragma mark - MXMetricManagerSubscriber

- (void)didReceiveMetricPayloads:(NSArray<MXMetricPayload *> *)payloads {
    // do nothing
}

- (void)didReceiveDiagnosticPayloads:(NSArray<MXDiagnosticPayload *> *)payloads API_AVAILABLE(ios(14.0)) {
    // do nothing
}

@end

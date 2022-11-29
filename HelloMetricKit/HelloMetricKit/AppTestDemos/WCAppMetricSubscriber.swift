//
//  WCAppMetricSubscriber.swift
//  HelloMetricKit
//
//  Created by wesley_chen on 2022/11/28.
//

import UIKit
import MetricKit

class WCAppMetricSubscriber: NSObject, MXMetricManagerSubscriber {
    func receiveReports() {
       let shared = MXMetricManager.shared
       shared.add(self)
    }

    func pauseReports() {
       let shared = MXMetricManager.shared
       shared.remove(self)
    }

    // Receive daily metrics.
    func didReceive(_ payloads: [MXMetricPayload]) {
        // Process metrics.
        for payload in payloads {
            print(payload)
        }
    }

    // Receive diagnostics immediately when available.
    @available(iOS 14.0, *)
    func didReceive(_ payloads: [MXDiagnosticPayload]) {
        // Process diagnostics.
        for payload in payloads {
            print(payload)
        }
    }
}

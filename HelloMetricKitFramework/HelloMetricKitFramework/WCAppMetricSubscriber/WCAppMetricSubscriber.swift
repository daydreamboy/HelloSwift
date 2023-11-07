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
            print("[WCAppMetricSubscriber] MXMetricPayload = \(payload)")
        }
    }

    // Receive diagnostics immediately when available.
    @available(iOS 14.0, *)
    func didReceive(_ payloads: [MXDiagnosticPayload]) {
        // Process diagnostics.
        for payload in payloads {
            //#define SignalLogFileName @"Signal_Log.txt"
            //#define SignalLogFilePath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:SignalLogFileName])
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentDirectory.appendingPathComponent("test.txt")
            do {
                try "some test text".data(using: .utf8)?.write(to: fileURL)
            } catch {
                print(error)
            }
            print("[WCAppMetricSubscriber] MXDiagnosticPayload = \(payload)")
        }
    }
}

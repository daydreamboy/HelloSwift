# HelloMetricKit

[TOC]



## 1、介绍MetricKit

MetricKit framework是iOS 13开始引入，用于获取app的度量数据，例如诊断(diagnostics)、电量(power)和性能(performance)等。系统会将24小时之前的metric report发给注册的app，基本上是一天一次的频率。在iOS 15和macOS 12之后，diagnostic report会立即发给注册的app。

官方文档描述[^1]，如下

> With MetricKit, you can receive on-device app diagnostics and power and performance metrics the system captures. The system delivers metric reports about the previous 24 hours to a registered app at most once per day, and delivers diagnostic reports immediately in iOS 15 and later and macOS 12 and later.





## References

[^1]:https://developer.apple.com/documentation/metrickit






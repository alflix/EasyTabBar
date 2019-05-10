//
//  Date+.swift
//  Ganguo
//
//  Created by John on 2019/4/9.
//  Copyright © 2019 Ganguo. All rights reserved.
//

import Foundation

public extension Date {
    private static func RFC1123DateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US") //need locale for some iOS 9 verision, will not select correct default locale
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        return dateFormatter
    }

    private static func RFC850DateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US") //need locale for some iOS 9 verision, will not select correct default locale
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        dateFormatter.dateFormat = "EEEE, dd-MMM-yy HH:mm:ss z"
        return dateFormatter
    }

    private static func asctimeDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US") //need locale for some iOS 9 verision, will not select correct default locale
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        dateFormatter.dateFormat = "EEE MMM d HH:mm:ss yyyy"
        return dateFormatter
    }

    /// 将 HTTP Header 中的时间格式转换为 Date
    ///
    /// - Parameter dateString: let header = response.response?.allHeaderFields, let dateString = header["Date"] as? String
    /// - Returns: 转换好的 Date
    static func dateFromRFC1123(dateString: String) -> Date? {
        var date: Date?
        //RFC1123
        date = Date.RFC1123DateFormatter().date(from: dateString)
        if date != nil {
            return date
        }
        //RFC850
        date = Date.RFC850DateFormatter().date(from: dateString)
        if date != nil {
            return date
        }
        //asctime-date
        date = Date.asctimeDateFormatter().date(from: dateString)
        if date != nil {
            return date
        }
        return nil
    }
}

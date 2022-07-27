//
//  DateFormatUtil.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/27.
//

import Foundation

final class DateFormatUtil {
    // MARK: 수업시간 -> 수업시간 스트링
    static func classTimeFormatter(time: Date) -> String {
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:MM"
            
            return dateFormatter
        }()
        
        return dateFormatter.string(from: time)
    }
}

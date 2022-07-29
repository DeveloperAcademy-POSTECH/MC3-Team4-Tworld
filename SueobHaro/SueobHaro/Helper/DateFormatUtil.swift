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
    
    // MARK: 수업일자 스트링 반환(ex: "15")
    static func classDateFormatter(time: Date) -> String {
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            
            return dateFormatter
        }()
        
        return dateFormatter.string(from: time)
    }
}

//
//  INT+Extension.swift
//  QuestionStack
//
//  Created by Taha Turan on 23.01.2024.
//

import Foundation

extension Int {
    func toDayMonthYearString() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
}

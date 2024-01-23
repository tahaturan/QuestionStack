//
//  Date+Extension.swift
//  QuestionStack
//
//  Created by Taha Turan on 22.01.2024.
//

import Foundation
extension Date {
    init(unixTimestamp: Int) {
        self.init(timeIntervalSince1970: TimeInterval(unixTimestamp))
    }
    func formattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyy"
        return dateFormatter.string(from: self)
    }
}

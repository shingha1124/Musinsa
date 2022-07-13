//
//  Int+Extension.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

extension Int {
    func convertToKRW(_ useSuffix: Bool) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = useSuffix ? .decimal : .currency
        numberFormatter.locale = Locale(identifier: "ko_KR")
        guard let krw = numberFormatter.string(for: self) else {
            return ""
        }
        return krw + (useSuffix ? "원" : "")
    }
}

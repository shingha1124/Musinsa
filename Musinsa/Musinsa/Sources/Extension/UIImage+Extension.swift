//
//  UIImage+Extension.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/14.
//

import UIKit

extension UIImage {
    func resizeImage(to size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

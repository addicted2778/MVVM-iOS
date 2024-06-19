//
//  UIImageView+Extensions.swift
//  MVVMExample
//
//  Created by WhyQ on 22/03/24.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(with UrlString:String) {
        guard let url = URL.init(string: UrlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: UrlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
            
    }
}

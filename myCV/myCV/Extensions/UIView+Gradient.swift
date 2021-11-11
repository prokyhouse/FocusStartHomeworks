//
//  UIColor+Gradient.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 11.11.2021.
//

import Foundation
import UIKit

extension UIView {
	func setGradientBackground(colorTop: UIColor, colorBottom: UIColor, cornerRadius: CGFloat) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = self.bounds
		gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
		gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
		gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
		gradientLayer.cornerRadius = cornerRadius
		self.layer.insertSublayer(gradientLayer, at: 0)
	}
}

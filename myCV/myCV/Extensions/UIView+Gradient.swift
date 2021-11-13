//
//  UIColor+Gradient.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 11.11.2021.
//

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

	func setGradientBackground(colorTop: UIColor, colorBottom: UIColor, startY: Double, endY: Double) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = self.bounds
		gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
		gradientLayer.startPoint = CGPoint(x: 0.0, y: startY)
		gradientLayer.endPoint = CGPoint(x: 0.0, y: endY)
		self.layer.insertSublayer(gradientLayer, at: 0)
	}
}

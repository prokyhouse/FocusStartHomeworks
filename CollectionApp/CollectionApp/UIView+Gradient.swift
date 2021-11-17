//
//  UIView+Gradient.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 17.11.2021.
//

import UIKit

extension UIView {

	func setGradientBackground(colorTop: UIColor, colorBottom: UIColor, startY: Double, endY: Double) {
		if let _ = (self.layer.sublayers?.compactMap { $0 as? CAGradientLayer })?.first {
			removeSublayer(self, layerIndex: 0)
		}
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = self.bounds
		gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
		gradientLayer.startPoint = CGPoint(x: 0.0, y: startY)
		gradientLayer.endPoint = CGPoint(x: 0.0, y: endY)
		self.layer.insertSublayer(gradientLayer, at: 0)
	}

	func removeSublayer(_ view: UIView, layerIndex index: Int) {
		guard let sublayers = view.layer.sublayers else { return }
		if sublayers.count > index {
			view.layer.sublayers?.remove(at: index)
		}
	}
}

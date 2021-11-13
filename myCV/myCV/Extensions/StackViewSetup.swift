//
//  StackViewSetup.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 12.11.2021.
//

import Foundation
import UIKit
extension UIStackView {
	func setupStackView(alignment:Alignment,distribution:Distribution,axis:NSLayoutConstraint.Axis,spacing:CGFloat,view:UIView){
		view.addSubview(self)
		self.alignment = alignment
		self.distribution = distribution
		self.axis = axis
		self.spacing = spacing

	}
	func addArrangedSubview(views:[UIView]){
		views.forEach { (view) in
			self.addArrangedSubview(view)
		}
	}
}

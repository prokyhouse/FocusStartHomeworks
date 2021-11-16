//
//  UIView+Xib.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 10.11.2021.
//

import Foundation
import UIKit

extension UIView {

	static func loadXib<T>() -> T {
		let name =  String(describing: self)
		guard let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T else {
			fatalError("Could not load view with type \(name)")
		}
		return view
	}
}

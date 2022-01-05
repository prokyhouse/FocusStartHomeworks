//
//  FontFormatter.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 10.11.2021.
//

import Foundation
import UIKit

extension UIFont {
	private static func customFont(name: String, size: CGFloat) -> UIFont {
		let font = UIFont(name: name, size: size)
		assert(font != nil, "Can't load font: \(name)")
		return font ?? UIFont.systemFont(ofSize: size)
	}

	struct Title {
		static let large = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
		static let medium = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
	}

	struct Callout {
		static let large = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
		static let medium = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
		static let small = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
	}

	struct Headline {
		static let large = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
		static let regular =  UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
		static let medium = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
		static let small = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
	}

	struct Caption2 {
		static let small = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
	}

	struct Footnote {
		static let regular = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
		static let small = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
	}

	struct Body {
		static let large =  UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
		static let medium = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
	}
}

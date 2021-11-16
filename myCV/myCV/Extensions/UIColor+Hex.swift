//
//  UIColor+Hex.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 11.11.2021.
//

import Foundation
import UIKit

extension UIColor {

	convenience init?(hex: String) {
		var hexString = hex

		if hexString.hasPrefix("#") { // Remove the '#' prefix if added.
			let start = hexString.index(hexString.startIndex, offsetBy: 1)
			hexString = String(hexString[start...])
		}

		if hexString.lowercased().hasPrefix("0x") { // Remove the '0x' prefix if added.
			let start = hexString.index(hexString.startIndex, offsetBy: 2)
			hexString = String(hexString[start...])
		}

		let red, green, blue, alpha: CGFloat
		let scanner = Scanner(string: hexString)
		var hexNumber: UInt64 = 0
		guard scanner.scanHexInt64(&hexNumber) else { return nil } // Make sure the strinng is a hex code.

		switch hexString.count {
		case 3, 4: // Color is in short hex format
			var updatedHexString = ""
			hexString.forEach { updatedHexString.append(String(repeating: String($0), count: 2)) }
			hexString = updatedHexString
			self.init(hex: hexString)

		case 6: // Color is in hex format without alpha.
			red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
			green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
			blue = CGFloat(hexNumber & 0x0000FF) / 255.0
			alpha = 1.0
			self.init(red: red, green: green, blue: blue, alpha: alpha)

		case 8: // Color is in hex format with alpha.
			red = CGFloat((hexNumber & 0xFF000000) >> 24) / 255.0
			green = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255.0
			blue = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255.0
			alpha = CGFloat(hexNumber & 0x000000FF) / 255.0
			self.init(red: red, green: green, blue: blue, alpha: alpha)

		default: // Invalid format.
			return nil
		}
	}
}

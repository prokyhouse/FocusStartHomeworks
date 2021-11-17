//
//  UIView+Layout.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 17.11.2021.
//

import Foundation
import UIKit

public struct Edge
{
	public enum YPosition
	{
		case top
		case bottom
		case center
	}

	public enum XPosition
	{
		case left
		case right
		case center
	}

	public enum Position
	{
		case left
		case right
		case top
		case bottom
		case centerX
		case centerY

		static func from(xPosition: XPosition) -> Position {
			switch xPosition {
			case .center: return .centerX
			case .left: return .left
			case .right: return .right
			}
		}

		static func from(yPosition: YPosition) -> Position {
			switch yPosition {
			case .center: return .centerY
			case .top: return .top
			case .bottom: return .bottom
			}
		}
	}

	public enum Relation
	{
		case equal
		case greaterOrEqual
		case lessOrEqual
	}

	let offset: CGFloat
	let relation: Relation
	let priority: Float
	let position: Position
	let targetEdge: Position

	public static var all: [Edge] {
		return [self.left, self.right, self.top, self.bottom]
	}

	public static var centerX: Edge {
		return centerX()
	}

	public static var centerY: Edge {
		return centerY()
	}

	public static var left: Edge {
		return left()
	}

	public static var right: Edge {
		return right()
	}

	public static var top: Edge {
		return top()
	}

	public static var bottom: Edge {
		return bottom()
	}

	public static func centerX(_ offset: CGFloat = 0,
						targetEdge: XPosition = .center,
						relation: Relation = Relation.equal,
						priority: Float = 1000) -> Edge {
		return Edge(offset: offset,
					relation: relation,
					priority: priority,
					position: .centerX,
					targetEdge: Position.from(xPosition: targetEdge))
	}

	public static func centerY(_ offset: CGFloat = 0,
						targetEdge: YPosition = .center,
						relation: Relation = Relation.equal,
						priority: Float = 1000) -> Edge {
		return Edge(offset: offset,
					relation: relation,
					priority: priority,
					position: .centerY,
					targetEdge: Position.from(yPosition: targetEdge))
	}

	public static func left(_ offset: CGFloat = 0,
					 targetEdge: XPosition = .left,
					 relation: Relation = Relation.equal,
					 priority: Float = 1000) -> Edge {
		return Edge(offset: offset,
					relation: relation,
					priority: priority,
					position: .left,
					targetEdge: Position.from(xPosition: targetEdge))
	}

	public static func right(_ offset: CGFloat = 0,
					  targetEdge: XPosition = .right,
					  relation: Relation = Relation.equal,
					  priority: Float = 1000) -> Edge {
		return Edge(offset: offset,
					relation: relation,
					priority: priority,
					position: .right,
					targetEdge: Position.from(xPosition: targetEdge))
	}

	public static func top(_ offset: CGFloat = 0,
					targetEdge: YPosition = .top,
					relation: Relation = Relation.equal,
					priority: Float = 1000) -> Edge {
		return Edge(offset: offset,
					relation: relation,
					priority: priority,
					position: .top,
					targetEdge: Position.from(yPosition: targetEdge))
	}

	public static func bottom(_ offset: CGFloat = 0,
					   targetEdge: YPosition = .bottom,
					   relation: Relation = Relation.equal,
					   priority: Float = 1000) -> Edge {
		return Edge(offset: offset,
					relation: relation,
					priority: priority,
					position: .bottom,
					targetEdge: Position.from(yPosition: targetEdge))
	}

	public static func all(_ offset: CGFloat = 0) -> [Edge] {
		return [ .left(offset), .right(offset), .top(offset), .bottom(offset) ]
	}

	public static func all(_ edgeInsets: UIEdgeInsets) -> [Edge] {
		return [.top(edgeInsets.top), .left(edgeInsets.left), .bottom(edgeInsets.bottom), .right(edgeInsets.right)]
	}
}
public extension UIView
{
	func pinToSuperviewEdges(_ offset: CGFloat = 0) {
		guard let superview = self.superview else {
			fatalError("Superview cannot be nil")
		}

		return self.pin(edges: Edge.all(offset), to: superview)
	}

	func pinToSuperviewEdges(_ edgeInsets: UIEdgeInsets) {
		guard let superview = self.superview else {
			fatalError("Superview cannot be nil")
		}

		return self.pin(edges: [
			.top(edgeInsets.top),
			.left(edgeInsets.left),
			.right(edgeInsets.right),
			.bottom(edgeInsets.bottom),
		], to: superview)
	}

	func pinToSuperviewCenter() {
		guard let superview = self.superview else {
			fatalError("Superview cannot be nil")
		}
		return self.pin(edges: [ .centerX, .centerY ], to: superview)
	}

	func pinToSuperview(edges: [Edge]) {
		guard let superview = self.superview else {
			fatalError("Superview cannot be nil")
		}
		return self.pin(edges: edges, to: superview)
	}

	@discardableResult
	func pin(edge: Edge, to view: UIView) -> NSLayoutConstraint {
		return self.pin(view: self, to: view, edge: edge)
	}

	@discardableResult
	func pin(edge: Edge, to view: UILayoutGuide) -> NSLayoutConstraint {
		return self.pin(view: self, to: view, edge: edge)
	}

	func pin(edges: [Edge], to view: UIView) {
		edges.forEach{ self.pin(view: self, to: view, edge: $0) }
	}

	func pin(edges: [Edge], to view: UILayoutGuide) {
		edges.forEach{ self.pin(view: self, to: view, edge: $0) }
	}

	@discardableResult
	func pin(view: UIView, to secondView: UIView, edge: Edge) -> NSLayoutConstraint {
		return self.pin(view: view, to: secondView as Any, edge: edge)
	}

	@discardableResult
	func pin(view: UIView, to secondView: UILayoutGuide, edge: Edge) -> NSLayoutConstraint {
		return self.pin(view: view, to: secondView as Any, edge: edge)
	}

	private func pin(view: UIView, to secondView: Any, edge: Edge) -> NSLayoutConstraint {
		func invertOffsetValueIfNeeded() -> CGFloat {
			guard edge.position == .bottom || edge.position == .right else {
				return edge.offset
			}
			return -edge.offset
		}

		view.translatesAutoresizingMaskIntoConstraints = false

		let value = invertOffsetValueIfNeeded()
		let constraint = NSLayoutConstraint(item: view,
											attribute: attribute(for: edge.position),
											relatedBy: relation(for: edge.relation, position: edge.position),
											toItem: secondView,
											attribute: attribute(for: edge.targetEdge),
											multiplier: 1.0,
											constant: value)
		constraint.priority = .init(edge.priority)
		constraint.isActive = true
		return constraint
	}

	private func relation(for edgeRelation: Edge.Relation, position: Edge.Position) -> NSLayoutConstraint.Relation {
		switch edgeRelation {
		case .equal: return .equal
		case .greaterOrEqual: return (position == .bottom || position == .right) ? .lessThanOrEqual : .greaterThanOrEqual
		case .lessOrEqual: return (position == .bottom || position == .right) ? .greaterThanOrEqual : .lessThanOrEqual
		}
	}
	private func attribute(for position: Edge.Position) -> NSLayoutConstraint.Attribute {
		switch position {
		case .bottom: return .bottom
		case .centerX: return .centerX
		case .left: return .left
		case .right: return .right
		case .top: return .top
		case .centerY: return .centerY
		}
	}
}

public extension UIView
{
	@discardableResult
	func setHeight(equalHeightTo view: UIView,
				   relation: Edge.Relation = .equal,
				   multiplier: CGFloat = 1.0,
				   constant: CGFloat = 0.0,
				   priority: Float = 1000) -> NSLayoutConstraint {

		let constraint: NSLayoutConstraint
		switch relation {
		case .equal:
			constraint = self.heightAnchor.constraint(equalTo: view.heightAnchor,
													  multiplier: multiplier,
													  constant: constant)
		case .greaterOrEqual:
			constraint = self.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor,
													  multiplier: multiplier,
													  constant: constant)
		case .lessOrEqual:
			constraint = self.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor,
													  multiplier: multiplier,
													  constant: constant)
		}
		constraint.priority = .init(priority)
		constraint.isActive = true
		return constraint
	}

	@discardableResult
	func setWidth(equalHeightTo view: UIView,
				  relation: Edge.Relation = .equal,
				  multiplier: CGFloat = 1.0,
				  constant: CGFloat = 0.0,
				  priority: Float = 1000) -> NSLayoutConstraint {

		let constraint: NSLayoutConstraint
		switch relation {
		case .equal:
			constraint = self.widthAnchor.constraint(equalTo: view.widthAnchor,
													 multiplier: multiplier,
													 constant: constant)
		case .greaterOrEqual:
			constraint = self.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor,
													 multiplier: multiplier,
													 constant: constant)
		case .lessOrEqual:
			constraint = self.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor,
													 multiplier: multiplier,
													 constant: constant)
		}
		constraint.priority = .init(priority)
		constraint.isActive = true
		return constraint
	}

	@discardableResult
	func setHeight(to height: CGFloat,
				   relation: Edge.Relation = .equal,
				   priority: Float = 1000) -> NSLayoutConstraint {

		let constraint: NSLayoutConstraint
		switch relation {
		case .equal:
			constraint = self.heightAnchor.constraint(equalToConstant: height)
		case .greaterOrEqual:
			constraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: height)
		case .lessOrEqual:
			constraint = self.heightAnchor.constraint(lessThanOrEqualToConstant: height)
		}
		constraint.priority = .init(priority)
		constraint.isActive = true
//		constraint.identifier = "MyHeight"
		return constraint
	}

	@discardableResult
	func setWidth(to width: CGFloat,
				  relation: Edge.Relation = .equal,
				  priority: Float = 1000) -> NSLayoutConstraint {

		let constraint: NSLayoutConstraint
		switch relation {
		case .equal:
			constraint = self.widthAnchor.constraint(equalToConstant: width)
		case .greaterOrEqual:
			constraint = self.widthAnchor.constraint(greaterThanOrEqualToConstant: width)
		case .lessOrEqual:
			constraint = self.widthAnchor.constraint(lessThanOrEqualToConstant: width)
		}
		constraint.priority = .init(priority)
		constraint.isActive = true
		return constraint
	}

	func setSize(to size: CGSize) {
		self.setHeight(to: size.height)
		self.setWidth(to: size.width)
	}
}

extension UIView
{
	func setSizeConstraints(size: CGSize) {
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: size.width),
			self.heightAnchor.constraint(equalToConstant: size.height),
		])
	}

	func setHuggingPriorityGreater(thanIn view: UIView, axis: NSLayoutConstraint.Axis, by value: Float) {
		let priority = view.contentHuggingPriority(for: axis).rawValue + value
		self.setContentHuggingPriority(.init(priority), for: axis)
	}

	func setResistancePriorityGreater(thanIn view: UIView, axis: NSLayoutConstraint.Axis, by value: Float) {
		let priority = view.contentCompressionResistancePriority(for: axis).rawValue + value
		self.setContentCompressionResistancePriority(.init(priority), for: axis)
	}
}

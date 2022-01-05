//
//  ThreadSafeArray.swift
//  ThreadSafeArray
//
//  Created by Кирилл Прокофьев on 03.11.2021.
//

import Foundation
import Dispatch

public final class ThreadSafeArray<T> {
	private var array = [T]()
	
	private let queue = DispatchQueue(label: "ThreadSafeArrayQueue",
									  attributes: .concurrent)
	
	public func append(_ item: T) {
		queue.async(flags: .barrier) { [weak self] in
			self?.array.append(item)
		}
	}
	
	public func remove(at index: Int) {
		queue.sync(flags: .barrier) {
			guard self.array.indices.contains(index) else {
				fatalError("index is out of range")
			}
			self.array.remove(at: index)
		}
	}
	
	public var isEmpty: Bool {
		queue.sync {
			return self.array.isEmpty
		}
	}
	
	public var count: Int {
		queue.sync {
			return self.array.count
		}
	}
	
	public subscript(index: Int) -> T {
		queue.sync {
			return self.array[index]
		}
	}
}

extension ThreadSafeArray where T: Equatable {
	public func contains(_ element: T) -> Bool {
		return queue.sync { self.array.contains(element) }
	}
}

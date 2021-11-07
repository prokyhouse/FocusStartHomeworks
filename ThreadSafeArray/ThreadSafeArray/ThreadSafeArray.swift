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
	
	func append(_ item: T) {
		queue.async(flags: .barrier) { [weak self] in
			self?.array.append(item)
		}
	}
	
	func remove(at index: Int) {
		queue.async(flags: .barrier) { [weak self] in
			self?.array.remove(at: index)
		}
	}
	
	var isEmpty: Bool {
		queue.sync {
			return self.array.isEmpty
		}
	}
	
	var count: Int {
		queue.sync {
			return self.array.count
		}
	}
	
	subscript(index: Int) -> T {
		queue.sync {
			return self.array[index]
		}
	}
}

extension ThreadSafeArray where T: Equatable {
	func contains(_ element: T) -> Bool {
		queue.sync {
			return (self.array.firstIndex(of: element) != nil) ? true : false
		}
	}
}

//
//  main.swift
//  ThreadSafeArray
//
//  Created by Кирилл Прокофьев on 03.11.2021.
//

import Foundation

var threadSafeArray = ThreadSafeArray<String>()

let queue = DispatchQueue(label: "ThreadSafeArrayQueue",
							  attributes: .concurrent)

let group = DispatchGroup.init()

queue.async(group: group) {
	for i in 0...1000 {
		threadSafeArray.append("X-\(i)")
	}
}

queue.async(group: group) {
	for i in 0...1000 {
		threadSafeArray.append("Y-\(i)")
	}
}

group.notify(queue: .main) {
	if (threadSafeArray.isEmpty) {
		print("Array is empty.")
	} else {
		print("Number of elements: \(threadSafeArray.count)")
	}
	exit(EXIT_SUCCESS)
}

dispatchMain()

//
//  CoreDataManager.swift
//  Workers
//
//  Created by Кирилл Прокофьев on 18.12.2021.
//

import UIKit
import CoreData

struct company {
	var companyName: String?
	var companyId = UUID()

	init() {
		companyName = ""
	}
	init(name: String) {
		self.companyName = name
	}
}

struct worker {
	var name: String
	var id = UUID()
	var companyId: UUID
	var experience: Int64
	var birthday: Date

	init(name: String, companyId: UUID, experience: Int64, birthday: Date) {
		self.name = name
		self.companyId = companyId
		self.experience = experience
		self.birthday = birthday
	}
}

class CoreDataManager: NSObject {

	private class func getContext() -> NSManagedObjectContext {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		return appDelegate.persistentContainer.viewContext
	}

	class func addCompany(name: String) {
		let company = Company(context: CoreDataManager.getContext())
		company.name = name
		company.id = UUID()
		saveContext()
	}

	class func addWorker(name: String, companyId: UUID, experience: Int64, birthday: Date) {
		let worker = Worker(context: CoreDataManager.getContext())
		worker.id = UUID()
		worker.name = name
		worker.company = companyId
		worker.experience = experience
		worker.birthday = birthday
		saveContext()
	}

	class func saveContext() {
		do {
			try CoreDataManager.getContext().save()
		} catch {
			print("Error saving managed objeCoreDataManager.ct context: \(error)")
		}
	}

	/// store obj into core data
	class func storeObj(name: String) {

		let company = Company(context: getContext())
		company.id = UUID()
		company.name = name
		let context = getContext()

		let entity = NSEntityDescription.entity(forEntityName: "Company", in: context)

		let managedObj = NSManagedObject(entity: entity!, insertInto: context)

		managedObj.setValue(company, forKey: "company")

		do {
			try context.save()
		} catch {
			print(error.localizedDescription)
		}
	}

	/// fetch all the objects from core data
	class func fetchObj(selectedScopeIdx: Int?=nil, targetText: String?=nil) -> [company] {
		var array = [company]()

		let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()

		if selectedScopeIdx != nil && targetText != nil {

			var filterKeyword = ""
			switch selectedScopeIdx! {
			case 0:
				filterKeyword = "name"
			case 1:
				filterKeyword = "by"
			default:
				filterKeyword = "year"
			}

			let predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", targetText!)

			fetchRequest.predicate = predicate
		}

		do {
			let fetchResult = try getContext().fetch(fetchRequest)

			for item in fetchResult {
				let cmp = company(name: item.name!)
				array.append(cmp)
			}
		} catch {
			print(error.localizedDescription)
		}

		return array
	}

	/// fetch all the objects from core data
	class func fetchWorkers(withId: UUID) -> [worker] {
		var array = [worker]()

		let fetchRequest: NSFetchRequest<Worker> = Worker.fetchRequest()

		let companyId = withId
		fetchRequest.predicate = NSPredicate(format: "company == %@", companyId as CVarArg)

		do {
			let fetchResult = try getContext().fetch(fetchRequest)

			for item in fetchResult {
				let cmp = worker(name: item.name!, companyId: item.company!, experience: item.experience, birthday: item.birthday!)
				array.append(cmp)
			}
		} catch {
			print(error.localizedDescription)
		}

		return array
	}

	class func cleanCoreData() {

		let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()

		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)

		do {
			try getContext().execute(deleteRequest)
		} catch {
			print(error.localizedDescription)
		}

	}

	class func deleteWorkerWithId(id: UUID) {

		let fetchRequest:NSFetchRequest<Worker> = Worker.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)

		do {
			try getContext().execute(deleteRequest)
		}catch {
			print(error.localizedDescription)
		}
	}

	class func deleteCompanyWithId(id: UUID) {

		let workersFetchRequest:NSFetchRequest<Worker> = Worker.fetchRequest()
		workersFetchRequest.predicate = NSPredicate(format: "company == %@", id as CVarArg)

		let workersDeleteRequest = NSBatchDeleteRequest(fetchRequest: workersFetchRequest as! NSFetchRequest<NSFetchRequestResult>)

		do {
			try getContext().execute(workersDeleteRequest)
		}catch {
			print(error.localizedDescription)
		}

		let fetchRequest:NSFetchRequest<Company> = Company.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)

		do {
			try getContext().execute(deleteRequest)
		}catch {
			print(error.localizedDescription)
		}
	}
}

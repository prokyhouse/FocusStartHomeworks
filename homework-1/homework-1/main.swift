//
//  main.swift
//  homework-1
//
//  Created by Кирилл Прокофьев on 27.10.2021.
//

enum Body:  String {
	case sedan = "Sedan"
	case coupe = "Coupe"
	case cabriolet = "Cabriolet"
	case undefined
}

enum Commands: String {
	case add = "add"
	case delete = "delete"
	case show = "show"
	case help = "help"
	case filter = "filter"
}

struct Car: Equatable {
	let manufacturer: String
	let model: String
	let body: Body
	let yearOfIssue: Int?
	let carNumber: String?
}

enum Constants: String {
	case separator = "-------------------------------------"
}

var carsList: [Car] = [Car(manufacturer: "Ford",
						   model: "Focus",
						   body: .sedan,
						   yearOfIssue: 2008,
						   carNumber: "у236ох"),
					   Car(manufacturer: "Toyota",
						   model: "Camry",
						   body: .cabriolet,
						   yearOfIssue: 2008,
						   carNumber: "у236ох")]

func show(cars: [Car]) {
	for car in cars {
		print(cars.firstIndex(of: car) ?? "*", "-",
			  "Manufacturer: ", car.manufacturer,"\n",
			  "   Body: ", car.model,"\n",
			  "   YearOfIssue: ", car.yearOfIssue ?? "-","\n",
			  "   CarNumber: ", car.carNumber ?? "-","\n"
		)
	}
}

func filter(){
	print("Выберите тип кузова для фильтрации:")
	print(" 1 - Седан \n 2 - купе \n 3 - кабриолет")
	let bodyIndex: Int = Int(readLine()!) ?? 0
	let body = bodyTypeIdentifier(bodyIndex: bodyIndex)
	let filteredData = carsList.filter { $0.body == body }
	show(cars: filteredData)
}

func bodyTypeIdentifier(bodyIndex: Int) -> Body{
	switch (bodyIndex) {
	case 1:
		return .sedan
	case 2:
		return .coupe
	case 3:
		return .cabriolet
	default:
		return .undefined
	}
}

func append(car: Car) {
	carsList.append(car)
}

func add() {
	var manufacturer: String?
	var model: String?
	var body: Body = .undefined
	var yearOfIssue: Int?
	var carNumber: String?

	print(Constants.separator)
	print("Введите марку машины:")
	manufacturer = readLine()

	print("Введите модель:")
	model = readLine()

	while (body == .undefined) {
		print("Выберите тип кузова:")
		print(" 1 - Седан \n 2 - купе \n 3 - кабриолет")
		let bodyIndex: Int = Int(readLine()!) ?? 0
		body = bodyTypeIdentifier(bodyIndex: bodyIndex)
	}


	print("Введите год:")
	yearOfIssue = Int(readLine()!)

	print("Введите номер автомобиля:")
	carNumber = readLine()

	append(car: Car(manufacturer: manufacturer!,
					model: model!,
					body: body,
					yearOfIssue: yearOfIssue!,
					carNumber: carNumber!))
	print(Constants.separator)
}

func delete() {
	print(Constants.separator)
	show(cars: carsList)
	print("Введите номер из списка на удаление: ")
	guard let indexToDelete = readLine() else { return }
	let i: Int = Int(indexToDelete) ?? -1
	if (carsList.indices.contains(i)) {
		carsList.remove(at: i)
		print("Машина под номером", i, "удалена.")
		print(Constants.separator)
	} else {
		print("Номер введен неверно.")
		delete()
	}
}

func help() {
	print("\n show - отобразить список \n add - добавить машину \n delete - удалить машину\n filter - применить фильтр\n")
}

var exitFlag: Bool = true
while (exitFlag) {
	print("\nВведите команду:\n(Введите 'help' для вывода списка команд)")

	let command = readLine()
	switch Commands(rawValue: command!) {
	case .none:
		help()
	case .some(.add):
		add()
	case .some(.delete):
		delete()
	case .some(.show):
		show(cars: carsList)
	case .some(.help):
		help()
	case .some(.filter):
		filter()
	}
}

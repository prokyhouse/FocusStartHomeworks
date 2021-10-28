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
	case test = "test"
	case add = "add"
	case delete = "delete"
	case show = "show"
	case help = "help"
	case filter = "filter"
	case exit = "exit"
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

var carsList: [Car] = []

func addTestData() {
	let testCar1: Car = Car(manufacturer: "Ford",
						model: "Focus",
						body: .sedan,
						yearOfIssue: 2008,
						carNumber: "о111оо")

	let testCar2: Car = Car(manufacturer: "Toyota",
						model: "Camry",
						body: .cabriolet,
						yearOfIssue: 2012,
						carNumber: "у236ох")
	append(car: testCar1)
	append(car: testCar2)

	print(Constants.separator.rawValue)
	print("Добавлены тестовые данные. Напишите 'show', чтобы отобразить.")
	print(Constants.separator.rawValue)
}

func show(cars: [Car]) {
	print(Constants.separator.rawValue)

	if carsList.isEmpty {
		print("Список пуст.")
		print(Constants.separator.rawValue)
		return
	}

	for car in cars {
		print(cars.firstIndex(of: car) ?? "*", "-",
			  "Производитель: ", car.manufacturer,"\n",
			  "   Модель: ", car.model,"\n",
			  "   Тип кузова: ", car.body.rawValue,"\n",
			  "   Год выпуска: ", car.yearOfIssue ?? "-")

		if (car.carNumber?.count != 0) {
			print("    Гос. номер: ", car.carNumber ?? "-", "\n")
		}
	}
	print(Constants.separator.rawValue)
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

	print(Constants.separator.rawValue)
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


	print("Введите год (или нажмите 'Enter', чтобы пропустить) :")
	yearOfIssue = Int(readLine()!)

	print("Введите номер автомобиля: (или нажмите 'Enter', чтобы пропустить) :")
	carNumber = readLine()

	append(car: Car(manufacturer: manufacturer!,
					model: model!,
					body: body,
					yearOfIssue: yearOfIssue,
					carNumber: carNumber))

	print(Constants.separator.rawValue)
}

func delete() {

	if carsList.isEmpty {
		print("Невозможно удалить. Список пуст.")
		return
	}

	print(Constants.separator.rawValue)
	show(cars: carsList)

	print("Введите номер из списка на удаление: ")
	guard let indexToDelete = readLine() else { return }
	let i: Int = Int(indexToDelete) ?? -1
	if (carsList.indices.contains(i)) {
		carsList.remove(at: i)
		print("Машина под номером", i, "удалена.")
		print(Constants.separator.rawValue)
	} else {
		print("Номер введен неверно.")
		delete()
	}
}

func help() {
	print("\n show - отобразить список \n add - добавить машину \n test - добавить тестовые данные \n delete - удалить машину\n filter - применить фильтр\n exit - выход")
}

var exitFlag: Bool = false
while (!exitFlag) {
	print("\nВведите команду:\n(Введите 'help' для вывода списка команд)")

	let command = readLine()
	switch Commands(rawValue: command!) {
	case .none:
		help()
	case .some(.test):
		addTestData()
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
	case .some(.exit):
		exitFlag = true
	}
}

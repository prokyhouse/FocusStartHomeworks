//
//  main.swift
//  homework-1
//
//  Created by Кирилл Прокофьев on 27.10.2021.
//


enum Commands: Int, CaseIterable, CustomStringConvertible {
	var description: String {
		switch self {
		case .add:
			return "\(self.rawValue) - Добавить автомобиль"
		case .test:
			return "\(self.rawValue) - Добавить тестовые данные"
		case .delete:
			return "\(self.rawValue) - Удалить автомобиль"
		case .show:
			return "\(self.rawValue) - Отобразить список автомобилей"
		case .help:
			return "\(self.rawValue) - Список команд"
		case .filter:
			return "\(self.rawValue) - Фильтрация по типу кузова"
		case .exit:
			return "\(self.rawValue) - Выход"
		}
	}

	case test = 1
	case add = 2
	case delete = 3
	case show = 4
	case help = 5
	case filter = 6
	case exit = 0
}

struct Car: CustomStringConvertible {

	var description: String {
  """

   manufacturer: \(manufacturer)
   model: \(model)
   body: \(body.rawValue)
   yearOfIssue: \(yearOfIssue?.description ?? "-")
   \(carNumber != nil ? "carNumber:  \(String(describing: carNumber))":"")

  """
	}

	let manufacturer: String
	let model: String
	let body: Body
	let yearOfIssue: Int?
	let carNumber: String?

	enum Body:  String, CaseIterable {
		case sedan = "Седан"
		case coupe = "Купе"
		case cabriolet = "Кабриолет"
		case undefined

		init?(index: Int) {
			for (indexEnumerated, value) in Self.allCases.enumerated() {
				if indexEnumerated == index {
					self = value
					return
				}
			}

			return nil
		}
	}
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
	carsList.append(testCar1)
	carsList.append(testCar2)

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

	carsList.forEach { car in
		print(car)
	}
	print(Constants.separator.rawValue)
}

func filter() {
	var bodyToFilter: Car.Body = .undefined
	while (bodyToFilter == .undefined) {
		bodyToFilter = typeBodyIdentifier()
	}
	let filteredData = carsList.filter {
		$0.body == bodyToFilter
	}
	show(cars: filteredData)
}

func add() {
	var manufacturer: String
	var model: String
	var body: Car.Body = .undefined
	var yearOfIssue: Int?
	var carNumber: String?

	print(Constants.separator.rawValue)
	print("Введите марку машины:")
	manufacturer = strongReadString()

	print("Введите модель:")
	model = strongReadString()

	while (body == .undefined) {
		body = typeBodyIdentifier()
	}

	print("Введите год (или нажмите 'Enter', чтобы пропустить) :")
	yearOfIssue = strongReadInt()

	print("Введите номер автомобиля: (или нажмите 'Enter', чтобы пропустить) :")
	carNumber = readLine()

	carsList.append(Car(manufacturer: manufacturer,
					model: model,
					body: body,
					yearOfIssue: yearOfIssue,
					carNumber: carNumber))

	print(Constants.separator.rawValue)
}

func typeBodyIdentifier() -> Car.Body {
	print("Выберите тип кузова:")
	print(" 0 - Седан \n 1 - купе \n 2 - кабриолет")
	let bodyIndex: Int = strongReadInt()
	let body = Car.Body(index: bodyIndex) ?? .undefined
	return body
}

func delete() {

	if carsList.isEmpty {
		print("Невозможно удалить. Список пуст.")
		return
	}

	print(Constants.separator.rawValue)
	show(cars: carsList)

	print("Введите номер из списка на удаление: ")
	let indexToDelete = strongReadInt()
	let i: Int = indexToDelete
	if (carsList.indices.contains(i)) {
		carsList.remove(at: i)
		print("Машина под номером", i, "удалена.")
		print(Constants.separator.rawValue)
	} else {
		print("Номер введен неверно.")
		delete()
	}
}

func strongReadInt() -> Int {
	if let input = readLine()
	{
		if let inputInt = Int(input)
		{
			return inputInt
		}
		else{
			print("Неверный ввод")
			return strongReadInt()
		}
	}
	return -1
}

func strongReadString() -> String {
	while true {
		if let string = readLine(),
		   string.isEmpty == false {
			return string
		}
		print("Повторите ввод")
	}
}

func readCommand() -> Commands {
	while true {
		let commandInt = strongReadInt()
		guard let command = Commands(rawValue: commandInt) else { return .help }
		return command
	}
}

func help() -> String {
	 return Commands.allCases.reduce(into: "\nВыберите команду") { (result: inout String, command: Commands) in
		result += "\n" + command.description
	}
}

func printHelp() {
	print(help())
}

func run() {
	printHelp()

	while true {
		let command = readCommand()
		switch command {
		case .test:
			addTestData()
		case .add:
			add()
		case .delete:
			delete()
		case .show:
			show(cars: carsList)
		case .help:
			printHelp()
		case .filter:
			filter()
		case .exit:
			return
		}
	}
}

run()

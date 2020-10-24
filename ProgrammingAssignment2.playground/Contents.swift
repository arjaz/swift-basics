
import Foundation

// Part 1

// Given string with format "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Бортнік Василь - ІВ-72; Чередніченко Владислав - ІВ-73; Гуменюк Олександр - ІВ-71; Корнійчук Ольга - ІВ-71; Киба Олег - ІВ-72; Капінус Артем - ІВ-73; Овчарова Юстіна - ІВ-72; Науменко Павло - ІВ-73; Трудов Антон - ІВ-71; Музика Олександр - ІВ-71; Давиденко Костянтин - ІВ-73; Андрющенко Данило - ІВ-71; Тимко Андрій - ІВ-72; Феофанов Іван - ІВ-71; Гончар Юрій - ІВ-73"

// Task 1
// Create dictionary:
// - key is a group name
// - value is sorted array with students

var studentsGroups: [String: [String]] = [:]

// Your code begins

for splitted in studentsStr
      .components(separatedBy: "; ")
      .map({ element in element.components(separatedBy: " - ").reversed()}) {
    let (key, value) = (splitted.first!, splitted.dropFirst().first!)
    if studentsGroups[key] != nil {
        studentsGroups[key]?.append(value)
    } else {
        studentsGroups[key] = [value]
    }
}

for (key, value) in studentsGroups {
    studentsGroups[key] = value.sorted()
}

// Your code ends

print(studentsGroups)
print()

// Given array with expected max points

let points: [Int] = [5, 8, 12, 12, 12, 12, 12, 12, 15]

// Task 2
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is array with points (fill it with random values, use function `randomValue(maxValue: Int) -> Int` )

func randomValue(maxValue: Int) -> Int {
    // NOTE: I use Linux and arc4random_uniform isn't found here, so I use Int.random instead
    // switch(arc4random_uniform(6)) {
    switch(Int.random(in: 0..<7)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Your code begins

for (group, students) in studentsGroups {
    studentPoints[group] = [:]
    for student in students {
        studentPoints[group]![student] = points.map { randomValue(maxValue: $0) }
    }
}

// Your code ends

print(studentPoints)
print()

// Task 3
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is sum of student's points

var sumPoints: [String: [String: Int]] = [:]

// Your code begins

for (group, students) in studentPoints {
    sumPoints[group] = [:]
    for (student, points) in students {
        sumPoints[group]![student] = points.reduce(0, +)
    }
}

// Your code ends

print(sumPoints)
print()

// Task 4
// Create dictionary:
// - key is group name
// - value is average of all students points

var groupAvg: [String: Float] = [:]

// Your code begins

for (group, students) in studentPoints {
    let grades: [Int] = students.map({ (k, v) in v }).reduce([], +)
    groupAvg[group] = Float(grades.reduce(0, +)) / Float(grades.count)
}

// Your code ends

print(groupAvg)
print()

// Task 5
// Create dictionary:
// - key is group name
// - value is array of students that have >= 60 points

var passedPerGroup: [String: [String]] = [:]

// Your code begins

for (group, students) in studentPoints {
    passedPerGroup[group] = []
    for (student, points) in students {
        let sum = points.reduce(0, +)
        if sum >= 60 {
            passedPerGroup[group]!.append(student)
        }
    }
}

// Your code ends

print(passedPerGroup)

// Example of output. Your results will differ because random is used to fill points.

// ["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]

// ["ІВ-72": ["Киба Олег": [5, 6, 11, 12, 0, 9, 0, 12, 0], "Овчарова Юстіна": [0, 8, 0, 9, 0, 12, 12, 0, 14], "Тимко Андрій": [0, 8, 12, 12, 9, 9, 0, 9, 15], "Бортнік Василь": [5, 8, 9, 11, 12, 11, 12, 11, 14]], "ІВ-73": ["Гончар Юрій": [0, 8, 12, 12, 12, 11, 12, 9, 14], "Чередніченко Владислав": [5, 8, 0, 11, 9, 0, 12, 0, 0], "Капінус Артем": [5, 0, 12, 12, 0, 0, 12, 9, 15], "Давиденко Костянтин": [5, 8, 9, 12, 12, 12, 0, 9, 14], "Науменко Павло": [5, 8, 11, 11, 0, 12, 0, 11, 15]], "ІВ-71": ["Трудов Антон": [0, 0, 12, 0, 12, 12, 12, 0, 15], "Феофанов Іван": [0, 0, 11, 0, 0, 12, 12, 12, 0], "Корнійчук Ольга": [0, 6, 11, 11, 12, 11, 0, 0, 0], "Андрющенко Данило": [5, 8, 11, 12, 12, 12, 12, 12, 15], "Музика Олександр": [5, 0, 0, 12, 0, 12, 11, 12, 15], "Гуменюк Олександр": [5, 8, 12, 12, 12, 0, 0, 12, 14]]]

// ["ІВ-72": ["Овчарова Юстіна": 55, "Киба Олег": 55, "Бортнік Василь": 93, "Тимко Андрій": 74], "ІВ-71": ["Музика Олександр": 67, "Трудов Антон": 63, "Гуменюк Олександр": 75, "Корнійчук Ольга": 51, "Феофанов Іван": 47, "Андрющенко Данило": 99], "ІВ-73": ["Науменко Павло": 73, "Гончар Юрій": 90, "Чередніченко Владислав": 45, "Капінус Артем": 65, "Давиденко Костянтин": 81]]

// ["ІВ-72": 7.6944447, "ІВ-73": 7.866667, "ІВ-71": 7.4444447]

// ["ІВ-72": ["Тимко Андрій", "Бортнік Василь"], "ІВ-73": ["Гончар Юрій", "Капінус Артем", "Давиденко Костянтин", "Науменко Павло"], "ІВ-71": ["Трудов Антон", "Андрющенко Данило", "Музика Олександр", "Гуменюк Олександр"]]


// Part 2
extension String: Error {}

enum Direction {
    case north
    case south
    case east
    case west
}

class CoordinateER {
    var direction: Direction

    var degree: Int
    var minute: UInt
    var second: UInt

    init(direction: Direction) {
        self.direction = direction
        self.degree = 0
        self.minute = 0
        self.second = 0
    }

    init(direction: Direction, degree: Int, minute: UInt, second: UInt) throws {
        switch direction {
        case .north, .south:
            if degree < -180 || degree > 180 {
                throw "Error"
            }
        case .east, .west:
            if degree < -90 || degree > 90 {
                throw "Error"
            }
        }
        if minute < 0 || minute >= 60 {
            throw "Error"
        }
        if second < 0 || second >= 60 {
            throw "Error"
        }
        self.direction = direction
        self.degree = degree
        self.minute = minute
        self.second = second
    }

    func toString1() -> String {
        let dir: String
          = self.direction == .north ? "N"
          : self.direction == .south ? "S"
          : self.direction == .east ? "E"
          : "W"
        return String(format: "\(self.degree)°\(self.minute)′\(self.second)″ \(dir)")
    }

    func toString2() -> String {
        let dir: String
          = self.direction == .north ? "N"
          : self.direction == .south ? "S"
          : self.direction == .east ? "E"
          : "W"
        return String(format: "%.3f° \(dir)", (Float(self.degree) + (Float(self.minute) / 60.0) + (Float(self.second) / 3600.0)))
    }

    func midpoint(another: CoordinateER) -> CoordinateER? {
        if self.direction != another.direction {
            return nil
        } else {
            let coordinate = try! CoordinateER(
              direction: self.direction,
              degree: (self.degree + another.degree) / 2,
              minute: (self.minute + another.minute) / 2,
              second: (self.second + another.second) / 2)
            return coordinate
        }
    }

    static func midpoint(one: CoordinateER, another: CoordinateER) -> CoordinateER? {
        if one.direction != another.direction {
            return nil
        } else {
            let coordinate = try! CoordinateER(
              direction: one.direction,
              degree: (one.degree + another.degree) / 2,
              minute: (one.minute + another.minute) / 2,
              second: (one.second + another.second) / 2)
            return coordinate
        }
    }
}

let c1 = CoordinateER(direction: .north)
let c2 = try! CoordinateER(direction: .north,
                           degree: 50,
                           minute: 13,
                           second: 22)
print(c1.toString1())
print(c2.toString2())
let m1 = c1.midpoint(another: c2)!
print(m1.toString1())
let m2 = try! CoordinateER.midpoint(one: c1, another: c2)!
print(m2.toString2())

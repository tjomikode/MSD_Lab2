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
var studentsWithGroupsParts = studentsStr.components(separatedBy: "; ").sorted()
for person in studentsWithGroupsParts {
    let partsOnePersonInfo = person.components(separatedBy: " ")
    if studentsGroups[partsOnePersonInfo[3]] == nil {
        studentsGroups[partsOnePersonInfo[3]] = []
    }
    studentsGroups[partsOnePersonInfo[3]]?.append("\(partsOnePersonInfo[0]) \(partsOnePersonInfo[1])")
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
    switch(arc4random_uniform(6)) {
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
    for person in students {
        studentPoints[group]![person] = points.map{ gradeMax in
            randomValue(maxValue: gradeMax)}
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
    for (person, points) in students {
        sumPoints[group]![person] = points.reduce(0) {
            $0 + $1
        }
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
    groupAvg[group] = Float(students.map({$1}).reduce([]) {
                                $0 + $1}.reduce(0){$0 + $1})/Float(students.map({$1}).reduce([]) {$0 + $1}.count)
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
    for (person, points) in students {
        if (points.reduce(0) {$0 + $1} > 59) {
            passedPerGroup[group]!.append(person)
        }
    }
}
// Your code ends

print(passedPerGroup)

// Example of output. Your results will differ because random is used to fill points.
//
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]



class TimeAS {
    var hours: UInt
    var minutes: UInt
    var seconds: UInt
    
    init() {
        self.hours = 0
        self.minutes = 0
        self.seconds = 0
    }
    
    init?(hours: UInt, minutes: UInt, seconds: UInt) {
        if hours < 0 || minutes < 0 || seconds < 0 || hours > 23 || minutes > 59 || seconds > 59 {
            return nil
        }
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    init(date: Date) {
        let calendar = Calendar.current
        self.hours = UInt(calendar.component(.hour, from: date))
        self.minutes = UInt(calendar.component(.minute, from: date))
        self.seconds = UInt(calendar.component(.second, from: date))
    }
    
    func formatOutput(temp: UInt) -> String {
        if (temp < 10) {
            return "0" + String(temp)
        }
        else{
            return String(temp)
        }
    }
    
    func description() -> String {
        if (self.hours > 12) {
            let checkDiffClockType = self.hours - 12
            if (self.hours > 12) {
                return formatOutput(temp: checkDiffClockType) + ":" + formatOutput(temp: self.minutes) + ":" + formatOutput(temp: self.seconds) + "PM"
            }
            return formatOutput(temp: checkDiffClockType) + ":" + formatOutput(temp: self.minutes) + ":" + formatOutput(temp: self.seconds) + "AM"
        }
        else {
            return formatOutput(temp: self.hours) + ":" + formatOutput(temp: self.minutes) + ":" + formatOutput(temp: self.seconds) + "AM"
        }
    }
    
    func sumAS(obj: TimeAS) -> TimeAS? {
        var sumOfSeconds: UInt = obj.seconds + self.seconds
        var sumOfMinutes: UInt = obj.minutes + self.minutes
        var sumOfHours: UInt = obj.hours + self.hours
        if (sumOfSeconds >= 60) {
            sumOfMinutes += 1
            sumOfSeconds -= 60
        }
        if (sumOfMinutes >= 60) {
            sumOfHours += 1
            sumOfMinutes -= 60
        }
        if (sumOfHours >= 24) {
            sumOfHours -= 24
        }
        return TimeAS(hours: sumOfHours, minutes: sumOfMinutes, seconds: sumOfSeconds)
    }
    
    func differenceAS(obj: TimeAS) -> TimeAS? {
        let currentSeconds: UInt = (((self.hours * 60) + self.minutes) * 60) + self.seconds
        let objSeconds: UInt = (((obj.hours * 60) + obj.minutes) * 60) + obj.seconds
        let newSeconds: UInt = currentSeconds <= objSeconds ? (objSeconds - currentSeconds) : (currentSeconds - objSeconds)
        return TimeAS(hours: newSeconds / 60 / 60, minutes: newSeconds / 60 % 60, seconds: newSeconds % 60)
    }
    
    static func sumTwoObjectsAS(obj1: TimeAS, obj2: TimeAS) -> TimeAS? {
        var sumOfSeconds: UInt = obj1.seconds + obj2.seconds
        var sumOfMinutes: UInt = obj1.minutes + obj2.minutes
        var sumOfHours: UInt = obj1.hours + obj2.hours
        if (sumOfSeconds >= 60) {
            sumOfMinutes += 1
            sumOfSeconds -= 60
        }
        if (sumOfMinutes >= 60) {
            sumOfHours += 1
            sumOfMinutes -= 60
        }
        if (sumOfHours >= 24) {
            sumOfHours -= 24
        }
        return TimeAS(hours: sumOfHours, minutes: sumOfMinutes, seconds: sumOfSeconds)
        
    }
    
    static func differenceTwoObjectsAS(obj1: TimeAS, obj2: TimeAS) -> TimeAS? {
        let obj1Seconds: UInt = (((obj1.hours * 60) + obj1.minutes) * 60) + obj1.seconds
        let obj2Seconds: UInt = (((obj2.hours * 60) + obj2.minutes) * 60) + obj2.seconds
        let newSeconds: UInt = obj1Seconds <= obj2Seconds ? (obj2Seconds - obj1Seconds) : (obj1Seconds - obj2Seconds)
        return TimeAS(hours: newSeconds / 60 / 60, minutes: newSeconds / 60 % 60, seconds: newSeconds % 60)
    }
}

print()
// default initialization
var timeObj1: TimeAS = TimeAS()
print(timeObj1.description())
// failable-initializator with hours:minutes:seconds
var timeObj2: TimeAS = TimeAS(hours: 19, minutes: 34, seconds: 56)!
print(timeObj2.description())
var timeObj3: TimeAS = TimeAS(hours: 23, minutes: 2, seconds: 6)!
print(timeObj3.description())
// sum of self object and incoming object
var timeObj4: TimeAS = timeObj2.sumAS(obj: timeObj3)!
print(timeObj4.description())
// difference of self object and incoming object
var timeObj5: TimeAS = timeObj3.differenceAS(obj: timeObj4)!
print(timeObj5.description())
// static func, sum of two different objects
var timeObj6: TimeAS = TimeAS.sumTwoObjectsAS(obj1: timeObj2, obj2: timeObj3)!
print(timeObj6.description())
// static func, difference of two different objects
var timeObj7: TimeAS = TimeAS.differenceTwoObjectsAS(obj1: timeObj3, obj2: timeObj4)!
print(timeObj7.description())

// Output
// 00:00:00 AM
// 07:34:56 PM
// 11:02:06 PM
// 06:37:02 PM
// 04:25:04 AM
// 06:37:02 PM
// 04:25:04 AM

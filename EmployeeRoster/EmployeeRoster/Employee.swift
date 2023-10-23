
import Foundation

enum EmployeeType: CaseIterable, CustomStringConvertible, Codable {
    case exempt
    case nonExempt
    case partTime
    
    var description: String {
        switch self {
        case .exempt:
            return "Exempt Full Time"
        case .nonExempt:
            return "Non-exempt Full Time"
        case .partTime:
            return "Part Time"
        }
    }
}

var documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
var archiveURL = documentDirectory.appendingPathExtension("employeeData").appendingPathExtension("json")

struct Employee: Codable {
    
    var name: String
    var dateOfBirth: Date
    var employeeType: EmployeeType
    
    static func saveToFile(employee: [Employee]) {
        let propertyListEncoder = JSONEncoder()
        let encoded = try? propertyListEncoder.encode(employee)
        try? encoded?.write(to: archiveURL)
    }
    
    static func LoadFromFiles() -> [Employee] {
        let propertyListDecoder = JSONDecoder()
        if let retrived = try? Data(contentsOf: archiveURL),
            let decoded = try? propertyListDecoder.decode([Employee].self, from: retrived) {
            return decoded
        }
        return []
    }
    
}

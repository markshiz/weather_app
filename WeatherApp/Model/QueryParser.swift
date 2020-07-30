import Foundation

extension String {
    public var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.union(CharacterSet.init(arrayLiteral: "-")).inverted) == nil
    }
}

class QueryParser {
    enum ResultType: Equatable {
        case unrecognized
        case zipCode(String)
        case latitudeLongitude(Double, Double)
        case cityName(String)
        case cityAndState(String, String)
    }
    
    func parse(term: String) -> ResultType {
        if term.count == 5, term.isNumber {
            return .zipCode(term)
        }
        
        let vals = term.split(separator: ",")
                       .compactMap { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
    
        if vals.count >= 2, let lat = Double(vals[0]), let lng = Double(vals[1]) {
            return .latitudeLongitude(lat, lng)
        }
        
        if term.trimmingCharacters(in: .whitespacesAndNewlines).rangeOfCharacter(from: CharacterSet.letters) == nil {
            return .unrecognized
        }
        
        if term.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return .unrecognized
        }
        
        return .cityName(term.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}

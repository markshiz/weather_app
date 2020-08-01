import Foundation

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
        
        if term.count == 9 || term.count == 10, term.isNumber {
            return .zipCode(term)
        }
        
        let vals = term.split(separator: ",").compactMap { String($0).trimmed }
    
        if vals.count >= 2 {
            if let lat = Double(trimmedNegativeDouble(string: vals[0])), let lng = Double(trimmedNegativeDouble(string: vals[1])) {
                return .latitudeLongitude(lat, lng)
            }
            if vals[0].trimmed.isAlphabetical, vals[1].trimmed.isAlphabetical {
                if vals[1].count == 2, let stateName = StateCodeToStateName(stateCode: vals[1]) {
                    return .cityAndState(vals[0].trimmed, stateName)
                }
                return .cityAndState(vals[0].trimmed, vals[1].trimmed)
            }
        }
        
        if term.trimmed.rangeOfCharacter(from: .letters) == nil {
            return .unrecognized
        }
        
        if term.trimmed.isEmpty {
            return .unrecognized
        }
        
        return .cityName(term.trimmed)
    }
    
    private func trimmedNegativeDouble(string: String) -> String {
        return string.trimmingCharacters(in: CharacterSet.negativeDecimals.inverted)
    }
}

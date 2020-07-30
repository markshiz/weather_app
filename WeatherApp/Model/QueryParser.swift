import Foundation

extension CharacterSet {
    static var negativeDecimals: CharacterSet {
        CharacterSet.decimalDigits.union(CharacterSet.init(arrayLiteral: "-"))
    }
}

extension String {
    public var isAlphabetical: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.letters.union(.whitespaces).union(.punctuationCharacters).inverted) == nil
    }
    public var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.negativeDecimals.inverted) == nil
    }
    public var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
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
        
        if term.count == 9 || term.count == 10, term.isNumber {
            return .zipCode(term)
        }
        
        let vals = term.split(separator: ",").compactMap { String($0).trimmed }
    
        if vals.count >= 2 {
            if let lat = Double(trimmedNegativeDouble(string: vals[0])), let lng = Double(trimmedNegativeDouble(string: vals[1])) {
                return .latitudeLongitude(lat, lng)
            }
            if vals[0].trimmed.isAlphabetical, vals[1].trimmed.isAlphabetical {
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

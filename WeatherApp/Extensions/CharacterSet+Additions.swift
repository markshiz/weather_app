import Foundation

extension CharacterSet {
    static var negativeDecimals: CharacterSet {
        CharacterSet.decimalDigits.union(CharacterSet.init(arrayLiteral: "-"))
    }
}

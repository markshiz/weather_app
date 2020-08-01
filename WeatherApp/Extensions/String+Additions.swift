import Foundation

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

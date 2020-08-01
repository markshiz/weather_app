import Foundation

class PersistedState {
    private let QUERY_KEY = "query"
    
    var query: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: QUERY_KEY)
        }
        get {
            UserDefaults.standard.string(forKey: QUERY_KEY)
        }
    }
}

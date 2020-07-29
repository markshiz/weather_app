import Foundation
import CoreLocation

struct AppState: Equatable {
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        if lhs.temperatureDegreesFarenheight == rhs.temperatureDegreesFarenheight,
           lhs.locationCoordinate.latitude == rhs.locationCoordinate.latitude,
           lhs.locationCoordinate.longitude == rhs.locationCoordinate.longitude,
           lhs.locationName == rhs.locationName,
           lhs.condition == rhs.condition {
            return true
        }
        return false
    }
    
    var temperatureDegreesFarenheight: Int? = nil
    var locationCoordinate: CLLocationCoordinate2D
    var locationName: String
    var condition: String
}

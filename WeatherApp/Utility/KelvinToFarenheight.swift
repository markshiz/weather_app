import Foundation

func KelvinToFarenheight(value: Double) -> String {
    let f = 9.0/5 * (value - 273) + 32
    return String(format:"%.0f F", f)
}

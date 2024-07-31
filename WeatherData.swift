import Foundation

struct WeatherData: Codable {
    let location: Location
    let current: Current
}

struct Location: Codable {
    let name: String
    let country: String
}

struct Current: Codable {
    let temp_c: Float
    let condition: Condition
}

struct Condition: Codable {
    let text: String
}

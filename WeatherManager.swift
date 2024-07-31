import Foundation

struct WeatherManager {
    
    var delegate: WeatherDelegate?
    
    let weatherURL: String = "https://api.weatherapi.com/v1/current.json?key=3385c322189a46ef9cc52205243107&aqi=no&q="
    let cityName: String = ""
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)+\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
//        1. Create a URL
        if let url = URL(string: urlString) {
            //        2. Create a URLSession
            let session = URLSession(configuration: .default)
            //        3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Es hab einen Fehler: \(error!)")
                    return
                }
                if let safeData = data {
                    if let dataToSend = parseJSON(weatherData: safeData){
                        delegate?.getWeatherData(weatherData: dataToSend)
                    }
                }
            }
            //        4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherData? {
        let codable = JSONDecoder()
        do {
            let decodedData = try codable.decode(WeatherData.self, from: weatherData)
            return decodedData
        } catch {
            print("error - block reached")
            print(error)
            return nil
        }
    }
}

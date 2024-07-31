import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    
    @IBOutlet weak var textField: UITextField!
    var weatherModel: WeatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        weatherModel.delegate = self
    }
    
//    Wenn man auf der Tastatur die Return-Taste drückt
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if let input = textField.text {
            weatherModel.fetchWeather(cityName: input)
        }
        textField.text = ""
        textField.placeholder = "Enter city name"
        
        return true
    }
    
//    Was soll passieren, wenn jemand die Tastatur schliessen will, also gerade draucklickt
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if checkTextField() {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func serachBtnPressed(_ sender: UIButton) {
        if (checkTextField()) {
            textField.text = ""
            textField.endEditing(true)
        }

    }
    
    func checkTextField() -> Bool {
        if (textField.text != "") {
            return true
        } else {
            return false
        }
    }
    
    func getWeatherData(weatherData: WeatherData) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = String(weatherData.current.temp_c)
            self.cityLabel.text = weatherData.location.name
        }
    }
    

//------------------------------------------------------------------------------------------------------------
    
    //    Diese Funktion wird aufgerufen, wenn die Tastatur geschlossen wird
        func textFieldDidEndEditing(_ textField: UITextField) {

        }
        
    //    Diese Funktion wird aufgerufen, wenn man auf das Textfeld klickt.
        func textFieldDidBeginEditing(_ textField: UITextField) {

        }
}


import UIKit

class ForecastCell: UICollectionViewCell {
    
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var iconLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
}

extension ForecastCell: Updatable {
    
    func update(model: Any?) {
        
        if let model = model as? Forecast {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h a"
            
            timeLabel.text = dateFormatter.string(from: model.date)
            temperatureLabel.text = String(format: "%0.2f", model.temp)
            descriptionLabel.text = model.weather?.capitalized
            
            var text = ""
            
            if let code = model.code,
                let unicode = UnicodeScalar(60000 + code) {
                
                text = String(Character(unicode))
            }
            
            iconLabel.text = text
        }
    }
}

extension ForecastCell: Resetable {
    
    func reset() {
        
        timeLabel.text = nil
        temperatureLabel.text = nil
        descriptionLabel.text = nil
        iconLabel.text = nil
    }
}

import UIKit

class DayCell: UITableViewCell {
    
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var items: [Forecast] = []
    let cellType: UICollectionViewCell.Type = ForecastCell.self
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    func config() {

        collectionView.register(identifier: cellType.className)
    }
}

extension DayCell: Resetable {
    
    func reset() {
        
        items = []
        titleLabel.text = nil
        self.collectionView.reloadData()
    }
}

extension DayCell: Updatable {
    
    func update(model: Any?) {
        
        items = model as? [Forecast] ?? []
        
        var text = ""
        
        if let forecast = items.first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            text = dateFormatter.string(from: forecast.date)
        }
        
        DispatchQueue.main.async {
            self.titleLabel.text = text
            self.collectionView.reloadData()
        }
    }
}

extension DayCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = items[indexPath.item]
        let identifier = cellType.className
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                      for: indexPath)
        
        if let updatable = cell as? Updatable {
            updatable.update(model: item)
        }
        
        return cell
    }
}

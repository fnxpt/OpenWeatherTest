import UIKit

enum Palette {
    
    case primary
    case secondary
    
    func color() -> UIColor {
        switch self {
        case .primary:
            return UIColor(rgbaValue: 0x4E4D4Aff)
        case .secondary:
            return .white
        }
    }
}

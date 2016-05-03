
import Foundation

extension Optional {

    func orElse(def:Wrapped) -> Wrapped {
        if let v = self {
            return v
        } else {
            return def
        }
    }
    
    func orElseO(defO:Wrapped?) -> Wrapped? {
        if let v = self {
            return v
        } else {
            return defO
        }
    }
}
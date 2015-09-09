
import Foundation

extension Optional {

    func orElse(def:T) -> T {
        if let v = self {
            return v
        } else {
            return def
        }
    }
    
    func orElseO(defO:T?) -> T? {
        if let v = self {
            return v
        } else {
            return defO
        }
    }
}
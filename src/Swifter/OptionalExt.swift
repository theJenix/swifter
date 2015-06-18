
import Foundation

extension Optional {

    func orElse(def:T) -> T {
        if let v = self {
            return v
        } else {
            return def
        }
    }
}
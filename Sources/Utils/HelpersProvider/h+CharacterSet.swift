import Foundation

extension CharacterSet: HelpersProvider {}

extension HelpersExtension where Base == CharacterSet {
    public static let urlQueryAllowed = CharacterSet.urlQueryAllowed.subtracting(F.returns {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        return CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
    })
}

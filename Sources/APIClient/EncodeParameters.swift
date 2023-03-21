import Foundation
import Utils

public struct EncodeParameters {
    public typealias Parameter = (key: String, value: Any)
    public typealias ParameterList = [String: Any]

    public var arrayKeyEncoding: ArrayKeyEncoding = .brackets
    public var boolValueEncoding: BoolValueEncoding = .numeric
    public let parameters: ParameterList

    public init(parameters: ParameterList = [:]) {
        self.parameters = parameters
    }

    public func apply(to components: inout URLComponents) {
        if parameters.isEmpty { return }
        components.percentEncodedQuery = percentEncodedQuery
    }

    public func apply(to request: inout URLRequest) {
        if parameters.isEmpty { return }
        request.httpBody = Data(percentEncodedQuery.utf8)
    }

    private var percentEncodedQuery: String {
        parameters
            .sorted(by: F.their(\.key, <))
            .flatMap(encode(parameter:))
            .map { "\($0)=\($1)" }
            .joined(separator: "&")
    }

    private func encode(parameter: Parameter) -> [(String, String)] {
        let (key, value) = (parameter.key, parameter.value)

        switch value {
            case let dictionary as [String: Any]:
                return dictionary.flatMap {
                    encode(parameter: ("\(key)[\($0.key)]", $0.value))
                }

            case let array as [Any]:
                return array.flatMap {
                    encode(parameter: (arrayKeyEncoding.encode(key: key), $0))
                }

            case let number as NSNumber:
                return [(
                    escape(key),
                    number.isBool
                    ? escape(boolValueEncoding.encode(value: number.boolValue))
                    : escape("\(number)")
                )]

            case let bool as Bool:
                return [(
                    escape(key),
                    escape(boolValueEncoding.encode(value: bool))
                )]

            default:
                return [(
                    escape(key),
                    escape("\(value)")
                )]
        }
    }

    private func escape(_ string: String) -> String {
        string.addingPercentEncoding(withAllowedCharacters: CharacterSet.h.urlQueryAllowed) ?? string
    }
}

public extension EncodeParameters {
    enum ArrayKeyEncoding {
        case brackets
        case noBrackets

        func encode(key: String) -> String {
            switch self {
            case .brackets: return "\(key)[]"
            case .noBrackets: return key
            }
        }
    }
    enum BoolValueEncoding {
        case numeric
        case literal

        func encode(value: Bool) -> String {
            switch self {
            case .numeric: return value ? "1" : "0"
            case .literal: return value ? "true" : "false"
            }
        }
    }
}

fileprivate extension NSNumber {
    var isBool: Bool {
        // Use Obj-C type encoding to check whether the underlying type is a `Bool`, as it's guaranteed as part of
        // swift-corelibs-foundation, per [this discussion on the Swift forums](https://forums.swift.org/t/alamofire-on-linux-possible-but-not-release-ready/34553/22).
        String(cString: objCType) == "c"
    }
}

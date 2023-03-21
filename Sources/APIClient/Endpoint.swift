import Foundation
import Environment
import Utils

public struct Endpoint {
    public var components: URLComponents
    public var method: Method
    public var headers: HeaderList = [:]
    public var cachePolicy: URLRequest.CachePolicy = Current.request.cachePolicy
    public var timeoutInterval: TimeInterval = Current.request.timeoutInterval
    public var componentsUpdate: (inout URLComponents) throws -> Void = F.id
    public var requestUpdate: (inout URLRequest) throws -> Void = F.id

    public init(components: URLComponents, method: Endpoint.Method) {
        self.components = components
        self.method = method
    }

    public init(
        url: URL?,
        method: Endpoint.Method,
        resolvingAgainstBaseURL: Bool = false
    ) throws {
        struct InvalidEndpoint: Error {}

        let components = url.flatMap {
            URLComponents(url: $0, resolvingAgainstBaseURL: resolvingAgainstBaseURL)
        }
        guard let components else { throw InvalidEndpoint() }
        self.init(components: components, method: method)
    }
}

public extension Endpoint {
    enum Header: String {
        case conentType = "Content-Type"
        case accept = "Accept"
        case auth = "Authorization"
        case totalCount = "X-Total-Count" //Custom Response Header, for example, used for paging
    }
    typealias HeaderList = [Header: String]

    enum Method: String {
        case connect = "CONNECT"
        case delete = "DELETE"
        case get = "GET"
        case head = "HEAD"
        case options = "OPTIONS"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
        case trace = "TRACE"
    }

    struct InvalidURL: Error {}
}

public extension Endpoint {
    var request: URLRequest {
        get throws {
            var components = components
            try componentsUpdate(&components)

            guard let url = components.url else {
                throw InvalidURL()
            }
            var request = URLRequest(
                url: url,
                cachePolicy: cachePolicy,
                timeoutInterval: timeoutInterval
            )
            if !headers.isEmpty {
                request.allHTTPHeaderFields = headers.reduce(into: [:]) { fields, header in
                    fields[header.key.rawValue] = header.value
                }
            }
            request.httpMethod = method.rawValue

            try requestUpdate(&request)
            return request
        }
    }
}

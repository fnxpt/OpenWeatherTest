import Foundation

protocol Requestable {
    
    static var service: String { get }
    
    static func request<T: Decodable>(path service: String,
                                      parameters: [String: String]?,
                                      completionHandler: @escaping (Response<T>) -> Void)
}

extension Requestable {
    
    internal static func request<T>(path service: String,
                                    parameters: [String : String]?,
                                    completionHandler: @escaping (Response<T>) -> Void) where T: Decodable {
        
//        "In order to proceed you need to specify your key first in API.swift"
        guard !API.key.isEmpty else {
            
            completionHandler(.error(error: ServiceError.unexpected))
            return
        }
        
        var params: [String: String] = ["APPID": API.key,
                                         "units": API.unit]
        
        if let parameters = parameters {
            params = params.merging(parameters, uniquingKeysWith: { (first, _) in first })
        }
        
        let path = API.endpoint + service
        
        var components = URLComponents()
        
        components.queryItems = params.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        let session = URLSession.shared
        if let url = components.url(relativeTo: URL(string: path)) {
            
            let task = session.dataTask(with: url) { (data, _, error) in
                
                if let error = error {
                    
                    completionHandler(.error(error: error))
                } else if let data = data {
                    
                    do {
                        
                        let object = try T.decode(data: data)
                        completionHandler(.success(object: object))
                    } catch {
                        
                        completionHandler(.error(error: error))
                    }
                } else {
                    
                    completionHandler(.error(error: ServiceError.unexpected))
                }
            }
            
            task.resume()
        }
    }
}

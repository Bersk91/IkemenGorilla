//
//  AnimalTarget.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import Moya

enum AnimalTarget {
    case getPosts(animalId: String, page: Int)
    case getAnimal(animalId: String, userId: String)
}

extension AnimalTarget: TargetType {
     var path: String {
        switch self {
        case .getPosts(let animalId, _):
            return "/animals/\(animalId)/posts"
        case .getAnimal(let animalId, _):
            return "/animals/\(animalId)"
        }
    }
    
    var method: Method {
        switch self {
        case .getPosts, .getAnimal:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPosts(_, let page):
            let parameters = [
                "page": page
            ]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getAnimal(_, let userId):
            let parameters = [
                "user_id": userId
            ]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getPosts, .getAnimal:
            return URLEncoding.queryString
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://8ca2bc8b-a8b2-432f-95c1-04b81b793ef8.mock.pstmn.io") ?? undefined("endpoint for frontend echo dose not exist")
    }
    
    var headers: [String: String]? {
        nil
    }

    var sampleData: Data {
        Data()
    }
}

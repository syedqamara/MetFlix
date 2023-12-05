//
//  MockServices.swift
//  MetFlix
//
//  Created by Apple on 05/12/2023.
//

import Foundation
import core_architecture
import Network

public class MockMindValleyServiceProtocol: Mocking<MockMindValleyServiceProtocol.Parameter, MockMindValleyServiceProtocol.Returned> {
    enum Errors: String, Error {
    case noValue, inValidReturnData
    }
    public enum Parameter {
        case image(MockFunctionArgument<String>)
        case can(MockFunctionArgument<String>)
        indirect case serve(type: MockFunctionArgument<DataModel.Type>, dataModel: MockFunctionArgument<DataModel?>, endpoint: MockFunctionArgument<Pointable>)
        case maxRequest(MockFunctionArgument<Int>)
        case none(MockFunctionArgument<String>)
        
        
        
        public var rawValue: String {
            switch self {
            case .image(_):
                return "image"
            case .serve(type: _, dataModel: _, endpoint: _):
                return "serve"
            case .maxRequest(_):
                return "maxRequest"
            case .can(_):
                return "can"
            case .none:
                return ""
            }
        }
    }
    public enum Returned {
        case episodes(MockFunctionArgument<EpisodesApiData>)
        case channels(MockFunctionArgument<ChannelsApiData>)
        case categories(MockFunctionArgument<CategoriesApiData>)
        case image(MockFunctionArgument<Data>)
        indirect case serve(MockFunctionArgument<DataModel>)
        case can(MockFunctionArgument<Bool>)
        case maxRequest(MockFunctionArgument<Int>)
        case none(MockFunctionArgument<String>)
        
        var rawValue: String {
            switch self {
            case .episodes(_):
                return "episodes"
            case .channels(_):
                return "channels"
            case .categories(_):
                return "categories"
            case .maxRequest(_):
                return "maxRequest"
            case .image(_):
                return "image"
            case .serve(_):
                return "serve"
            case .can(_):
                return "can"
            case .none:
                return ""
            }
        }
    }
}

extension MockMindValleyServiceProtocol: MindValleyServiceProtocol {
    public func serve<D>(type: D.Type, dataModel: DataModel?, endpoint: Pointable) async throws -> D where D : DataModel {
        if case .serve(type: let typeArg, dataModel: let dataModelArg, endpoint: let endpointArg) = parameter {
            typeArg.invoked(by: type)
            dataModelArg.invoked(by: dataModel)
            endpointArg.invoked(by: endpoint)
            
            
        }
        if case .serve(let arg)  = returned {
            if let value = arg.argumentLastValue as? D {
                return value
            } else {
                throw Errors.inValidReturnData
            }
        }
        throw Errors.noValue
    }
}

extension MockMindValleyServiceProtocol: EpisodeServiceProtocol {
    public func episodes() async throws -> EpisodesApiData {
        if case .none(let arg) = parameter {
            if let value = arg.argumentLastValue {
                arg.invoked(by: value)
            } else {
                arg.invoked(by: UUID().uuidString)
            }
        }
        if case .episodes(let arg)  = returned {
            if let value = arg.argumentLastValue {
                arg.invoked(by: value)
                return value
            }
        }
        throw Errors.noValue
    }
}

extension MockMindValleyServiceProtocol: ChannelServiceProtocol {
    public func channels() async throws -> ChannelsApiData {
        if case .none(let arg) = parameter {
            if let value = arg.argumentLastValue {
                arg.invoked(by: value)
            } else {
                arg.invoked(by: UUID().uuidString)
            }
        }
        if case .channels(let arg)  = returned {
            if let value = arg.argumentLastValue {
                arg.invoked(by: value)
                return value
            }
        }
        throw Errors.noValue
    }
}

extension MockMindValleyServiceProtocol: CategoriesServiceProtocol {
    public func categories() async throws -> CategoriesApiData {
        if case .none(let arg) = parameter {
            if let value = arg.argumentLastValue {
                arg.invoked(by: value)
            } else {
                arg.invoked(by: UUID().uuidString)
            }
        }
        if case .categories(let arg)  = returned {
            if let value = arg.argumentLastValue {
                arg.invoked(by: value)
                return value
            }
        }
        throw Errors.noValue
    }
}

extension MockMindValleyServiceProtocol: ImageDownloadingProtocol {
    public var maxRequest: Int {
        get {
            if case .maxRequest(let arg) = returned {
                if let value = arg.argumentLastValue {
                    arg.invoked(by: value)
                    return value
                }
            }
            return 0
        }
        set {
            if case .maxRequest(let arg) = parameter {
                arg.invoked(by: newValue)
            }
            if case .can(let arg) = returned {
                if let value = arg.argumentLastValue {
                    arg.invoked(by: value)
                }
            }
        }
    }
    
    public func can(send url: String) -> Bool {
        if case .can(let arg) = parameter {
            arg.invoked(by: url)
        }
        if case .can(let arg) = returned {
            if let value = arg.argumentLastValue {
                arg.invoked(by: value)
                return value
            }
        }
        return false
    }
    
    public func image(for url: String) async throws -> Data {
        if case .image(let arg) = parameter {
            arg.invoked(by: url)
        }
        if case .image(let arg) = returned {
            if let value = arg.argumentLastValue {
                arg.invoked(by: value)
                return value
            }
        }
        throw Errors.noValue
    }
}


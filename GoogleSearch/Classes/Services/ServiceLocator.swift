//
//  ServiceLocator.swift
//  GoogleSearch
//
//  Created by Oleg Bakatin on 16.02.2020.
//  Copyright © 2020 Oleg Bakatin. All rights reserved.
//

import Foundation

protocol ServiceLocatorProtocol {
    func getService<T>() -> T
    func getService<T>(_ type: T.Type) -> T
    func tryGetService<T>() -> T?
    func tryGetService<T>(_ type: T.Type) -> T?
    func removeService<T>(_ type: T.Type)
}

class ServiceLocator: ServiceLocatorProtocol {
    private lazy var services: [String: Any] = [:]

    private func typeName(of serviceType: Any.Type) -> String {
        return "\(serviceType)"
    }

    func registerService<T>(service: T) {
        services[typeName(of: T.self)] = service
    }

    func getService<T>() -> T {
        return getService(T.self)
    }

    func tryGetService<T>() -> T? {
        return tryGetService(T.self)
    }

    func getService<T>(_ type: T.Type) -> T {
        return tryGetService(type)!
    }

    func tryGetService<T>(_ type: T.Type) -> T? {
        return services[typeName(of: type)] as? T
    }

    func removeService<T>(_ type: T.Type) {
        services.removeValue(forKey: typeName(of: T.self))
    }

    public static let shared = ServiceLocator()
}


//
//  ObserverClass.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 21.08.2021.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T?) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T?) -> Void) {
        closure(value)
        self.listener = closure
    }
}

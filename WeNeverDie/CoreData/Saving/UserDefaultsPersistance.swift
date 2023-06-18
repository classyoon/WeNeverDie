//
//  UserDefaultsPersistance.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/8/23.
//

//
//  ResourcePoolDataDefaults.swift
//  Health
//
//  Created by Tim Yoon on 3/10/22.
//

import Foundation
import Combine

class MyUserDefaults<T : Codable> : ObservableObject {
    @Published private (set) var item : T?
    private var key : String
    
    func save(_ item: T) {
        self.item = item
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(item) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    
    func fetch(){
        if let loadedData = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedItem = try? decoder.decode(T.self, from: loadedData) {
                self.item = loadedItem
            }
        }
    }
    
    init(key: String) {
        self.key = key
        fetch()
    }
}

//Unit tests in HealthTests
class ResourcePoolDataDefaults : MyUserDefaults<ResourcePoolData> {
    @Published var data : ResourcePoolData?
    static let shared = ResourcePoolDataDefaults()
    private var cancellables = Set<AnyCancellable>()
    private init(){
        super.init(key: "savedPerson")
        $item
            .sink { storedResoureData in
                self.data = storedResoureData
            }
            .store(in: &cancellables)
    }
}

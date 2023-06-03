//
//  ProducerData.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/25/23.
//

import Foundation
struct ProducerData : Codable, Identifiable {
    var id = UUID()
    var name: String
    var workers: Int
    var workProgress: Int
    var workCost: Int
    var autoWithDrawed: Bool
    var materialCost: Int
    var constructionStarted: Bool
    
    var rate : Int
    var output = 0
    var produces : ResourceType
    
    var rateIn : Int = 0
    var input = 0
    var consumes : ResourceType = .nothing
    var isActive : Bool = true
    var isStartingBuild : Bool = false
    
    //func setValue()
    init(Producer : ResourceProducer) {
        
        self.name = Producer.name
        self.workers = Producer.workers
        self.workProgress = Producer.workProgress
        self.workCost = Producer.workCost
        self.autoWithDrawed = Producer.autoWithDrawed
        self.materialCost = Producer.materialCost
        self.constructionStarted = Producer.constructionStarted
        
        self.rate = Producer.rate
        self.output = Producer.output
        self.produces = Producer.produces
        
        self.rateIn = Producer.rateIn
        self.input = Producer.input
        self.consumes = Producer.consumes
        
        self.isActive = Producer.isActive
        self.isStartingBuild = Producer.isStartingBuild
        
        
    }
    init(name: String, workers: Int=0, workProgress: Int=0, workCost: Int, autoWithDrawed: Bool=true, materialCost: Int=0, constructionStarted: Bool=false, rate: Int, output: Int = 0, produces: ResourceType, rateIn : Int = 0, input : Int = 0, consumes: ResourceType = .nothing, isActive : Bool = true, isStartingBuild : Bool = true) {
        self.id = UUID()
        self.name = name
        self.workers = workers
        self.workProgress = workProgress
        self.workCost = workCost
        self.autoWithDrawed = autoWithDrawed
        self.materialCost = materialCost
        self.constructionStarted = constructionStarted
        
        self.rate = rate
        self.output = output
        self.produces = produces
        
        self.rateIn = rateIn
        self.input = input
        self.consumes = consumes
        
        self.isActive = isActive
        self.isStartingBuild = isStartingBuild
    }
}


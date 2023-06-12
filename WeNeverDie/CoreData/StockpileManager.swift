//
//  Stockpile.swift
//  BuildingThePain
//
//  Created by Conner Yoon on 5/25/23.
//

import Foundation
//
//  StockpileManager.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/22/23.
//CHECK

import Foundation
class Stockpile : ObservableObject {
    @Published var stockpileData : StockpileModel

    
    var survivorDefaultNumber : Int = 3
    static let shared = Stockpile()
    private init() {
        self.stockpileData = load(key: "stocks") ?? StockpileModel()
    }
    func reset(){
        stockpileData.reset()
    }
    func calcConsumption(){
        stockpileData.calcConsumption()
        save(items: stockpileData, key: "stocks")
    }
    
    func transferResourcesToResourcePool(vm : Board){
        stockpileData.transferResourcesToResourcePool(vm: vm)
    }
    func runOutOfPeople()->Bool{
        return stockpileData.runOutOfPeople()
    }
    func getNumOfPeople()->Int{
        return stockpileData.survivorNumber
    }
    func getNumOfFood()->Int{
        return stockpileData.foodStored
    }
    func getNumOfMat()->Int{
        return stockpileData.buildingResources
    }
    func killOnePerson(){
        stockpileData.survivorNumber -= 1
    }
    func isStarving()->Bool{
        return stockpileData.starving
    }
    func getSurvivorSent()->Int{
        return stockpileData.survivorSent
    }
    func getBuilders()->Int{
        print(stockpileData.builders)
        return stockpileData.builders
    }
    func setSurvivorSent(_ survivors : Int){
    stockpileData.survivorSent = survivors
    }
    func setBuilders(_ survivors : Int){
    stockpileData.builders = survivors
    }
    func getRosterOfSurvivors()->[playerUnit] {
       return stockpileData.rosterOfSurvivors
    }
    
}
struct StockpileModel : Codable, Identifiable {
    var id = UUID()
    var foodStored : Int = 0
    var survivorNumber : Int = 1
    var builders : Int = 0
    var buildingResources : Int = 0
    var survivorDefaultNumber : Int = 1
    var survivorSent : Int = 0
    var starving : Bool {
        return foodStored==0 ? true : false
    }
    var unemployed : Int {
        survivorNumber-builders-survivorSent
    }
    var graveyard: [playerUnit] = []
    var rosterOfSurvivors = [playerUnit]()
    
    func generateSurvivors(_ number : Int)->[playerUnit] {
        let firstNames = ["Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", "Heidi", "Ivan", "Jack", "Kate", "Liam", "Mia", "Noah", "Olivia", "Peter", "Quinn", "Rachel", "Sarah", "Tom", "Ursula", "Victoria", "Wendy", "Xander", "Yara", "Zoe"]
        let lastNames = ["Anderson", "Brown", "Clark", "Davis", "Evans", "Ford", "Garcia", "Hill", "Ingram", "Jackson", "Kim", "Lee", "Miller", "Nguyen", "Olsen", "Perez", "Quinn", "Reed", "Smith", "Taylor", "Upton", "Vargas", "Walker", "Xu", "Young", "Zhang"]
        let childhood = ["Shy", "Inquisitive", "Imaginative", "Scared", "Joyful", "Crafty", "Rich", "Peculiar", "Athletic", "Adventurous", "Artistic", "Studious", "Independent", "Resilient"]
        let occupations = ["University Student", "Police Officer", "Firefighter", "Doctor", "Mechanic", "Activist", "Self Employed", "Patient", "Single Parent", "Scientist", "Engineer", "Teacher", "Soldier", "Artist", "Chef", "Social Worker", "Entrepreneur", "Musician", "Journalist", "Convict", "Teenager", "Entertainer"]
        var generatedRoster = [playerUnit]()
        var stringList = [String]()
        for _ in 0..<number {
            let randomFirstName = firstNames.randomElement()!
            let randomLastName = lastNames.randomElement()!
            let randomChildhood = childhood.randomElement()!
            let randomOccupation = occupations.randomElement()!
            let fullName = "\(randomFirstName) \(randomLastName)"
            stringList.append(fullName)
            generatedRoster.append(playerUnit(childhood: randomChildhood, currentOccupation : randomOccupation, name: fullName, firstName: randomFirstName, lastName: randomLastName))
        }
   // print(stringList)
        return generatedRoster
    }
    
    func transferResourcesToResourcePool(vm : Board){
        func transferResourcesToResourcePool(vm : Board){
            foodStored += vm.foodNew
            survivorNumber+=vm.UnitsRecruited
            survivorNumber-=vm.UnitsDied
            survivorSent = 0
            
            buildingResources += vm.materialNew
            for unit in vm.survivorsLocal {
                for checker in 0..<rosterOfSurvivors.count {
                    if unit == rosterOfSurvivors[checker] {
                        rosterOfSurvivors[checker] = unit
                    }
                }
                if !rosterOfSurvivors.contains(where: { $0 == unit }) {
                    rosterOfSurvivors.append(unit)
                }
            }
           
            refreshRoster()
            survivorNumber = rosterOfSurvivors.count
            save(items: self, key: "stocks")
        }
    }
    
    mutating func reset(){
        survivorNumber = survivorDefaultNumber
        foodStored = 0
        buildingResources = 0
        survivorSent = 0
        builders = 0
        rosterOfSurvivors = generateSurvivors(survivorNumber)
        
    }
    mutating func refreshRoster (){
        var temp = [playerUnit]()
        for survivor in rosterOfSurvivors {
            if !survivor.isDeceased{
                temp.append(survivor)
            }
            else {
                print("Death registered")
                survivorNumber-=1
                graveyard.append(survivor)
            }
        }
       
        rosterOfSurvivors = temp
    }
    mutating func calcConsumption(){
        if foodStored-survivorNumber > 0{
            foodStored -= survivorNumber
            print("Is starving = \(starving)")
        }
        else {
            foodStored = 0
            print("Is starving = \(starving)")
        }
        print("Eating")
        print(foodStored)
    }
    func runOutOfPeople()->Bool{
        if survivorNumber<=0 {
            return true
        }
        return false
    }
    
}


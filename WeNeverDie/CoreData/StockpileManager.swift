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
        stockpileData.foodStored += vm.foodNew
        stockpileData.survivorNumber+=vm.UnitsRecruited
        stockpileData.survivorNumber-=vm.UnitsDied
        stockpileData.survivorSent = 0
        stockpileData.buildingResources += vm.materialNew
        print(vm.UnitsRecruited)
            save(items: stockpileData, key: "stocks")
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
    func getRandomPerson()->playerUnit {
        return stockpileData.generateSurvivors(1)[0]
    }
    func getName(index : Int)->String {
        return stockpileData.rosterOfSurvivors[index].name
    }
    func getSurvivor(index : Int)->playerUnit {
        return stockpileData.rosterOfSurvivors[index]
    }
    func swapSurvivors(index : Int, current : Int){
        stockpileData.swapSurvivors(index: index, current: current)
    }
    
}
struct StockpileModel : Codable, Identifiable {
    var id = UUID()
    var foodStored : Int = 10
    var survivorNumber : Int = 3
    var builders : Int = 0
    var buildingResources : Int = 10
    var survivorDefaultNumber : Int = 3
    var survivorSent : Int = 0
    var graveyard: [playerUnit] = []
    var rosterOfSurvivors = [playerUnit]()
    var starving : Bool {
        return foodStored==0 ? true : false
    }
    var unemployed : Int {
        survivorNumber-builders-survivorSent
    }
    
    mutating func reset(){
        survivorNumber = survivorDefaultNumber
        foodStored = 10
        buildingResources = 10
        survivorSent = 0
        builders = 0
        
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
    func generateSurvivors(_ number : Int)->[playerUnit] {
        var generatedRoster = [playerUnit]()
        for _ in 0..<number {
            generatedRoster.append(generateRandomSurvivor())
        }
        return generatedRoster
    }
    func generateRandomSurvivor()->playerUnit {
        let firstNames = ["Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", "Heidi", "Ivan", "Jack", "Kate", "Liam", "Mia", "Noah", "Olivia", "Peter", "Quinn", "Rachel", "Sarah", "Tom", "Ursula", "Victoria", "Wendy", "Xander", "Yara", "Zoe"]
        let lastNames = ["Anderson", "Brown", "Clark", "Davis", "Evans", "Ford", "Garcia", "Hill", "Ingram", "Jackson", "Kim", "Lee", "Miller", "Nguyen", "Olsen", "Perez", "Quinn", "Reed", "Smith", "Taylor", "Upton", "Vargas", "Walker", "Xu", "Young", "Zhang"]
        let childhood = ["Shy", "Inquisitive", "Imaginative", "Scared", "Joyful", "Crafty", "Rich", "Peculiar", "Athletic", "Adventurous", "Artistic", "Studious", "Independent", "Resilient"]
        let occupations = ["University Student", "Police Officer", "Firefighter", "Doctor", "Mechanic", "Activist", "Self Employed", "Patient", "Single Parent", "Scientist", "Engineer", "Teacher", "Soldier", "Artist", "Chef", "Social Worker", "Entrepreneur", "Musician", "Journalist", "Convict", "Teenager", "Entertainer"]
        let randomFirstName = firstNames.randomElement()!
        let randomLastName = lastNames.randomElement()!
        let randomChildhood = childhood.randomElement()!
        let randomOccupation = occupations.randomElement()!
        return playerUnit(childhood: randomChildhood, currentOccupation : randomOccupation, name: "\(randomFirstName) \(randomLastName)", firstName: randomFirstName, lastName: randomLastName)
    }
}


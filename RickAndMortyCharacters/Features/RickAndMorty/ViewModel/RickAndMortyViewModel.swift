//
//  RickAndMortyViewModel.swift
//  RickAndMortyCharacters
//
//  Created by İbrahim Bayram on 6.03.2023.
//

import Foundation


protocol ViewModelOutput {
    func fetchItems()
    func changeLoading()
    
    var rickAndMortyCharacters : [Results] {get set}
    var rickAndMortyService : ServiceProtocol {get}
    
    var rickMortyOutput : ViewOutput? {get}
    func setDelegate(output : ViewOutput)
}

final class RickAndMortyViewModel : ViewModelOutput {
    var rickMortyOutput: ViewOutput?
    var rickAndMortyCharacters: [Results] = []
    lazy var rickAndMortyService: ServiceProtocol = APIManager()
    
    //ViewController ile delegate initialize işlemi.
    func setDelegate(output: ViewOutput) {
        rickMortyOutput = output
    }
    
    
    
    private var isLoading = false
    
    init() {
        rickAndMortyService = APIManager()
    }
    
    func fetchItems() {
        rickAndMortyService.fetchAllData { [weak self] result in
            switch result {
            case .success(let postModel):
                self?.rickAndMortyCharacters = postModel.results
                self!.rickMortyOutput?.saveDatas(values: self?.rickAndMortyCharacters ?? [])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
   
    //Activity Indicator Function
    func changeLoading() {
        isLoading = !isLoading
        rickMortyOutput?.changeLoading(isLoad: isLoading)
    }
    
    
    
    
}

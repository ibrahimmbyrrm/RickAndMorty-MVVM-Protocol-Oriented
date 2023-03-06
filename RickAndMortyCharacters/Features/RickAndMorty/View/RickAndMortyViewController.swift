//
//  RickAndMortyViewController.swift
//  RickAndMortyCharacters
//
//  Created by İbrahim Bayram on 6.03.2023.
//

import UIKit
import SnapKit

protocol ViewOutput {
    func changeLoading(isLoad : Bool)
    func saveDatas(values : [Results])
}

final class RickAndMortyViewController: UIViewController {

    private let titleLabel : UILabel = UILabel()
    private let tableView : UITableView = UITableView()
    private let indicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    private lazy var result : [Results] = []
    lazy var viewModel : ViewModelOutput = RickAndMortyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.fetchItems()
        viewModel.setDelegate(output: self)
       
    }
    
    private func configure() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(indicator)
        drawDesign()
        makeTableView()
        makeLabel()
        makeIndicator()
    }
    
    private func drawDesign() {
        tableView.dataSource = self
        tableView.delegate = self
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.titleLabel.text = "Ceylin"
            self.indicator.color = .red
            self.indicator.startAnimating()
        }
        indicator.startAnimating()
    }
}

extension RickAndMortyViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if result.isEmpty {
            cell.textLabel?.text = ""
        }else {
            cell.textLabel?.text = result[indexPath.row].name
        }
        return cell
    }
    
    
    
    
}

extension RickAndMortyViewController : ViewOutput {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(values: [Results]) {
        self.result = values
        tableView.reloadData()
    }
    
    
}

extension RickAndMortyViewController {
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(titleLabel)
        }
    }
    private func makeLabel() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    private func makeIndicator() {
        indicator.snp.makeConstraints { make in
            make.height.equalTo(titleLabel)
            make.right.equalTo(titleLabel).offset(-5)
            make.top.equalTo(titleLabel)
        }
    }
}

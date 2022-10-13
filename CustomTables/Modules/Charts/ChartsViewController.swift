//
//  ChartsViewController.swift
//  CustomTables
//
//  Created by Arturo Ventura on 13/10/22.
//

import UIKit
import FacilCustomApp

class ChartsViewController: CustomViewController {
    
    weak var table: UITableView?
    var viewModel = ChartsViewModel()
    
    override func loadView() {
        super.loadView()
        title = "Charts"
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        ChartsCell.registerToTable(table: table)
        self.table = table
        view.addSubviewFill(table, padding: .axisSame(vertical: 16, horizontal: 8), safeArea: true)
    }
    
    override func viewDidLoad() {
        viewModel.updateData { [weak self] in
            self?.table?.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Viking]
    }
}

extension ChartsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.surveyChart?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChartsCell.reusableName) as? ChartsCell
        cell?.fillData(data: viewModel.surveyChart?[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
}

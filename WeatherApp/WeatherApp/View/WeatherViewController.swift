//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Govardhana Devi on 28/11/21.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    private let refreshControl = UIRefreshControl()
    private let viewModel: WeatherViewModelProtocol = WeatherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.appTitle
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        setUpTableView()
        refresh()
    }

    @IBAction func cityChanged(_ sender: UISegmentedControl) {
        refresh()
    }

    private func setUpTableView() {
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HoursTableViewCell.registerNib(), forCellReuseIdentifier: HoursTableViewCell.reuseIdentifier)
        tableView.addSubview(refreshControl)
    }

    @objc private func refresh() {
        guard let selectedCity = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex) else
        { return }
        viewModel.getData(city: selectedCity) { [tableView, refreshControl] in
            tableView?.reloadData()
            refreshControl.endRefreshing()
        }
    }
}

extension WeatherViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HoursTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? HoursTableViewCell,
                  let hourlyData = viewModel.hourlyData else {
                return UITableViewCell()
            }
            cell.configure(with: hourlyData)
            return cell
        }
        return UITableViewCell()
    }
    
}


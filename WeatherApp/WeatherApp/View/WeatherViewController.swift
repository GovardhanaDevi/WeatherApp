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
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.appTitle
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        activityIndicator.center = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
        view.addSubview(activityIndicator)
        setUpTableView()
        refresh()
    }

    @IBAction func cityChanged(_ sender: UISegmentedControl) {
        refresh()
    }

    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(DaysTableViewCell.registerNib(), forCellReuseIdentifier: DaysTableViewCell.reuseIdentifier)
        tableView.register(HoursTableViewCell.registerNib(), forCellReuseIdentifier: HoursTableViewCell.reuseIdentifier)
        tableView.addSubview(refreshControl)
    }

    @objc private func refresh() {
        guard let selectedCity = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex) else
        { return }
        activityIndicator.startAnimating()
        viewModel.getData(city: selectedCity) { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
            self?.activityIndicator.stopAnimating()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DaysTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? DaysTableViewCell,
              let dayData = viewModel.getDailyData(for: indexPath.row) else {
            return UITableViewCell()
        }
        cell.tag = indexPath.row
        cell.configure(with: dayData)
        
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 56))
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 16, width: tableView.frame.width, height: 40))
        titleLabel.text = viewModel.getSectionTitle(for: section)
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        titleLabel.textColor = .white
        headerView.addSubview(titleLabel)
        return headerView
    }
}

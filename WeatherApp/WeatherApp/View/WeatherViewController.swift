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
    private let viewModel: WeatherViewModelProtocol = WeatherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}


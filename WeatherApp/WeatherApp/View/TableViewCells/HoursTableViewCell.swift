//
//  HoursTableViewCell.swift
//  WeatherApp
//
//  Created by Govardhana Devi on 28/11/21.
//

import UIKit

class HoursTableViewCell: UITableViewCell {
    var dataSource: [Current]?
    static let reuseIdentifier = "HoursTableViewCell"
    @IBOutlet weak var hoursCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        hoursCollectionView.register(HourCollectionViewCell.registerNib(), forCellWithReuseIdentifier: HourCollectionViewCell.reuseIdentifier)
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }

    static func registerNib() -> UINib {
        return UINib(nibName: HoursTableViewCell.reuseIdentifier, bundle: nil)
    }

    func configure(with hourData: [Current]) {
        dataSource = hourData
        hoursCollectionView.dataSource = self
        hoursCollectionView.reloadData()
    }
}

extension HoursTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HourCollectionViewCell.reuseIdentifier,
            for: indexPath) as? HourCollectionViewCell,
        let hourData = dataSource?[indexPath.row] else {
                return UICollectionViewCell()
            }
        
        cell.configure(with: hourData)
        return cell
    }
    
    
}

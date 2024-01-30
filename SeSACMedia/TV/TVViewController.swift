//
//  TVViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 1/30/24.
//

import UIKit
import SnapKit

class TVViewController: UIViewController {

	let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .blue
		
		configureHierarchy()
		configureLayout()
		configureView()

    }

	func configureHierarchy() {
		view.addSubview(tableView)

	}

	func configureLayout() {
		tableView.snp.makeConstraints { make in
			make.edges.equalTo(view.safeAreaLayoutGuide)
		}



	}

	func configureView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(TVTableViewCell.self, forCellReuseIdentifier: "TVTableViewCell")
		tableView.register(TVSubTableViewCell.self, forCellReuseIdentifier: "TVSubTableViewCell")
		tableView.rowHeight = UITableView.automaticDimension


	}

}









extension TVViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		3
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath == [0,0] {
			let cell = tableView.dequeueReusableCell(withIdentifier: "TVTableViewCell", for: indexPath) as! TVTableViewCell

			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "TVSubTableViewCell", for: indexPath) as! TVSubTableViewCell

			cell.collectionView.dataSource = self
			cell.collectionView.delegate = self
			cell.collectionView.register(TVSubCollectionViewCell.self, forCellWithReuseIdentifier: "TVSubCollectionViewCell")

			cell.titleLabel.text = " Hi"
			return cell
		}
	}


}



extension TVViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		5
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVSubCollectionViewCell", for: indexPath) as! TVSubCollectionViewCell
		cell.posterImageView.image = UIImage(systemName: "pencil")
		return cell
	}
	

}

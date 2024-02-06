//
//  SeasonInfoViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 2/6/24.
//

import UIKit

class SeasonInfoViewController: BaseViewController {

	let mainView = SeasonInfoView()

	var seasonList: [SeasonInfo] = []

	let id = UserDefaults.standard.integer(forKey: "ID")


	override func loadView() {
		view = mainView

		TMDBAPIManager.shared.request(type: DetailTVModel.self, api: .detailInfo(id: id)) {
			self.seasonList = $0.seasons ?? []
			self.mainView.seasonTableView.reloadData()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		mainView.seasonTableView.dataSource = self
		mainView.seasonTableView.delegate = self
		mainView.seasonTableView.register(SeasonAndEpisodeTableViewCell.self, forCellReuseIdentifier: "Season")

    }
    

}


extension SeasonInfoViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		dump(seasonList)
		return seasonList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Season", for: indexPath) as! SeasonAndEpisodeTableViewCell

		if let image = seasonList[indexPath.row].poster {
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
		}

		cell.titleLabel.text = seasonList[indexPath.row].name
		cell.overviewTextView.text = seasonList[indexPath.row].overview


		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UIScreen.main.bounds.width / 3 * 1.4 + 16
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("season click")
	}


}

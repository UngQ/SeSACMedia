//
//  SeasonInfoViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 2/6/24.
//

import UIKit

final class SeasonOrEpisodeInfoViewController: BaseViewController {

	var seasonOrEpisodeView = false

	let mainView = SeasonOrEpisodeInfoView()

	var seasonList: [SeasonInfo] = []
	var episodeList: EpisodeModel = EpisodeModel(episodes: [], poster_path: "")

	let id = UserDefaults.standard.integer(forKey: "ID")


	override func loadView() {
		view = mainView

		if seasonOrEpisodeView == false {
			
			TMDBAPIManager.shared.request(type: DetailTVModel.self, api: .detailInfo(id: id)) {

				self.seasonList = $0.seasons ?? []
				self.mainView.seasonOrEpisodeTableView.reloadData()
			}
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		if seasonOrEpisodeView == false {

			let navigationBarAppearance = UINavigationBarAppearance()
			navigationBarAppearance.backgroundColor = .darkGray
			navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
			navigationController!.navigationBar.standardAppearance = navigationBarAppearance
			navigationController!.navigationBar.scrollEdgeAppearance = navigationBarAppearance
			navigationItem.title = "클릭시 시즌별 에피소드 정보 확인 가능"

			let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
			navigationItem.backBarButtonItem = backBarButton
			navigationItem.backBarButtonItem?.tintColor = .white
		} else {
			navigationItem.title = "에피소드 정보"

		}
		mainView.seasonOrEpisodeTableView.dataSource = self
		mainView.seasonOrEpisodeTableView.delegate = self
		mainView.seasonOrEpisodeTableView.register(SeasonOrEpisodeTableViewCell.self, forCellReuseIdentifier: SeasonOrEpisodeTableViewCell.identifier)

    }
    

}


extension SeasonOrEpisodeInfoViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		if seasonOrEpisodeView == false {

			return seasonList.count
		} else {
			print(episodeList.episodes?.count ?? 0)
			return episodeList.episodes?.count ?? 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: SeasonOrEpisodeTableViewCell.identifier, for: indexPath) as! SeasonOrEpisodeTableViewCell

		if seasonOrEpisodeView == false {


			if let image = seasonList[indexPath.row].poster {
				let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
				cell.posterImageView.kf.setImage(with: url)
			}
			cell.seasonNumber = seasonList[indexPath.row].seasonNumber
			cell.titleLabel.text = seasonList[indexPath.row].name
			cell.overviewTextView.text = seasonList[indexPath.row].overview


			return cell
		} else {

			if let image = episodeList.poster_path {
				let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
				cell.posterImageView.kf.setImage(with: url)
			}

			cell.titleLabel.text = "\(episodeList.episodes![indexPath.row].episodeNumber)화 \(episodeList.episodes![indexPath.row].name)"
			cell.overviewTextView.text = episodeList.episodes![indexPath.row].overview
			cell.selectionStyle = .none

			return cell
		}
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UIScreen.main.bounds.width / 3 * 1.4 + 16
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = SeasonOrEpisodeInfoViewController()
		if seasonOrEpisodeView == false {
			vc.seasonOrEpisodeView = true
			let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! SeasonOrEpisodeTableViewCell

			TMDBAPIManager.shared.request(type: EpisodeModel.self, api: .episode(id: id, season: cell.seasonNumber)) {
				vc.episodeList = $0
				vc.mainView.seasonOrEpisodeTableView.reloadData()
				self.navigationController?.pushViewController(vc, animated: true)
			}

		}

	}


}

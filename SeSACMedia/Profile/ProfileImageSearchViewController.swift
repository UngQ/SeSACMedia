//
//  ModifyProfileImageViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 2/8/24.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

final class ProfileImageSearchViewController: BaseViewController {

	let mainView = ProfileImageSearchView()

	var itemList: [Item] = []
	var itemNumber = 1
	var lastPage = 1

	var valueSpace: ((URL) -> Void)?

	override func loadView() {
		view = mainView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		mainView.searchBar.delegate = self
		mainView.resultCollectionView.delegate = self
		mainView.resultCollectionView.dataSource = self
		mainView.resultCollectionView.prefetchDataSource = self
		mainView.resultCollectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
		mainView.resultCollectionView.collectionViewLayout = mainView.configureCollectionViewCellLayout()
	}
}


//searchBar
extension ProfileImageSearchViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

		itemNumber = 1

		NaverAPIManager.shared.callRequest(text: searchBar.text!, itemNumber: itemNumber) {

			if $1 == nil {
				guard let result = $0 else { return }
				if result.items.count == 0 {
					self.mainView.totalLabel.text = "검색 결과가 없습니다"
					self.itemList = []
					self.mainView.resultCollectionView.reloadData()
				} else {
					self.itemList = result.items
					self.lastPage = result.total / 30
					self.mainView.totalLabel.text = "\(self.intNumberFormatter(number: result.total)) 개의 검색 결과"

					self.mainView.resultCollectionView.reloadData()

					self.mainView.resultCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
				}
			}
		}}
}

//collectionView
extension ProfileImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return itemList.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as! ProfileImageCollectionViewCell

		cell.url = URL(string: itemList[indexPath.row].thumbnail)
		cell.backgroundColor = .clear
		cell.imageView.kf.setImage(with: cell.url)
		cell.imageView.contentMode = .scaleAspectFill

		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: IndexPath(item: indexPath.item, section: indexPath.section)) as! ProfileImageCollectionViewCell

		alert(url: cell.url!)
	}
}

//collectionView prefetching
extension ProfileImageSearchViewController: UICollectionViewDataSourcePrefetching {

	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		for item in indexPaths {
			if itemList.count - 6 == item.row {
				itemNumber += 30

				NaverAPIManager.shared.callRequest(text: self.mainView.searchBar.text!, itemNumber: itemNumber) {

					if $1 == nil {
						guard let result = $0 else { return }
						self.itemList.append(contentsOf: result.items)
						self.mainView.resultCollectionView.reloadData()
					}
				}
			}
		}
	}
}

extension ProfileImageSearchViewController {
	func alert(url: URL) {

		let alert = UIAlertController(title: "프로필 사진", message: "변경 하시겠습니까?", preferredStyle: .alert)
		let okButton = UIAlertAction(title: "확인", style: .default) { _ in
			self.valueSpace!(url)
			self.dismiss(animated: true)
		}
		let cancelButton = UIAlertAction(title: "취소", style: .cancel)

		alert.addAction(okButton)
		alert.addAction(cancelButton)

		present(alert, animated: true)
	}
}

extension ProfileImageSearchViewController {
	func intNumberFormatter(number: Int?) -> String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		let intPrice = number
		let formattedSave = formatter.string(for: intPrice)!

		return formattedSave
	}
}

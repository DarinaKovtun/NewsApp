//
//  BusinessViewController.swift
//  NewsApp
//
//  Created by Darina Kovtun on 09.04.2024.
//

import UIKit
import SnapKit

class BusinessViewController: UIViewController, UICollectionViewDelegate {

    // MARK: - GUI Variables
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 20,
                                           left: 20,
                                           bottom: 20,
                                           right: 20)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: view.frame.width,
                                                            height: view.frame.height),
                                              collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    // MARK: - Properties
    private var viewModel: BusinessViewModelProtocol
 
    // MARK: - Life Cycle
    init(viewModel: BusinessViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupViewModel()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        collectionView.register(GeneralCollectionViewCell.self, 
                                forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        
        collectionView.register(DetailsCollectionViewCell.self, 
                                forCellWithReuseIdentifier: "DetailsCollectionViewCell")
    }
    
    // MARK: - Private Methods
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.reloadCell = { [weak self] row in
            self?.collectionView.reloadItems(at: [IndexPath(row: row,
                                                           section: 0)])
        }
        
        viewModel.showError = { error in
            // TODO: show alert with error
            print(error)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    

}

// MARK: - UICollectionViewDataSource

extension BusinessViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
       section == 0 ? 1 : viewModel.numberOfCells - 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        
        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell",
                                                       for: indexPath) as? GeneralCollectionViewCell
            
            let article = viewModel.getArticle(for: indexPath.row)
            (cell as? GeneralCollectionViewCell)?.set(article: article)
            
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell",
                                                      for: indexPath) as? DetailsCollectionViewCell
            
            let article = viewModel.getArticle(for: indexPath.row + 1)
            (cell as? DetailsCollectionViewCell)?.set(article: article)
        }

        return cell ?? UICollectionViewCell()
    }
}
// MARK: - UICollectionViewDelegate

extension BusinessViewController {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        var articleIndex: Int
        
        if indexPath.section == 0 {
            articleIndex = indexPath.row
        } else {
            articleIndex = indexPath.row + 1
        }
        
        let article = viewModel.getArticle(for: articleIndex)
        navigationController?.pushViewController(NewsViewController(viewModel: NewsViewModel(article: article)), animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BusinessViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let firstSectionItemSize = CGSize(width: width,
                                          height: width)
        let secondSectionItemSize = CGSize(width: width,
                                           height: 100)
        return indexPath.section == 0 ? firstSectionItemSize : secondSectionItemSize
    }
}


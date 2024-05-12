//
//  TechnologyViewController.swift
//  NewsApp
//
//  Created by Darina Kovtun on 09.04.2024.
//

import UIKit
import SnapKit

class TechnologyViewController: UIViewController, UICollectionViewDelegate {

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
    private var viewModel: NewsListViewModelProtocol
 
    // MARK: - Life Cycle
    init(viewModel: NewsListViewModelProtocol) {
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
        
        collectionView.register(TechnologyCollectionViewCell.self,
                                forCellWithReuseIdentifier: "TechnologyCollectionViewCell")
        
        viewModel.loadData(searchText: nil)
    }
      
    // MARK: - Private Methods
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.reloadCell = { [weak self] indexPath in
            self?.collectionView.reloadItems(at: [indexPath])
        }
        
        viewModel.showError = { error in
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Error",
                                                        message: error,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK",
                                                        style: .default,
                                                        handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
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

extension TechnologyViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as?
                ArticleCellViewModel else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell",
                                                      for: indexPath) as? GeneralCollectionViewCell
            
            cell?.set(article: article)
            return cell ?? UICollectionViewCell()
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TechnologyCollectionViewCell",
                                                          for: indexPath) as? TechnologyCollectionViewCell
            
            cell?.set(article: article)
            return cell ?? UICollectionViewCell()
        }
    }
}
// MARK: - UICollectionViewDelegate

extension TechnologyViewController {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let article = viewModel.sections[indexPath.section].items[indexPath.row] as?
                ArticleCellViewModel else { return }
        navigationController?.pushViewController(NewsViewController(viewModel: NewsViewModel(article: article)), animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if (indexPath.row == viewModel.sections[1].items.count - 15) {
            viewModel.loadData(searchText: nil)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TechnologyViewController: UICollectionViewDelegateFlowLayout {
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


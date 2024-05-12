//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Darina Kovtun on 16.04.2024.
//

    import UIKit
    import SnapKit

    final class NewsViewController: UIViewController {
    // MARK: - GUI Variables
        private lazy var scrollView: UIScrollView = {
            let view = UIScrollView()
            
            view.showsVerticalScrollIndicator = false
            return view
        }()
        private lazy var contentView: UIView = UIView()
        
        private lazy var newsImageView: UIImageView = {
            let imageView = UIImageView()
            
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()

        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.numberOfLines = 0
            return label
        }()
        
        private lazy var dateLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.italicSystemFont(ofSize: 12)
            label.textColor = .systemGray
            return label
        }()

        private lazy var descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.numberOfLines = 0
            return label
        }()

        
    // MARK: - Properties
        private let viewModel: NewsViewModelProtocol
        
    // MARK: - Life Cycle
        init(viewModel: NewsViewModelProtocol) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
            setupUI()
        }
        
    // MARK: - Private Methods
        private func setupUI() {
            view.backgroundColor = .white
            
            scrollView.isScrollEnabled = true
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
            
            contentView.addSubviews([newsImageView,
                                     titleLabel,
                                     descriptionLabel,
                                     dateLabel])
            titleLabel.text = viewModel.title
            descriptionLabel.text = viewModel.description
            dateLabel.text = viewModel.date
            
            if let data = viewModel.imageData,
               let image = UIImage(data: data) {
                newsImageView.image = image
            } else {
                newsImageView.image = UIImage(named: "Image")
            }
            
            setupConstraints()
        }
        
        private func setupConstraints() {
                scrollView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }

                contentView.snp.makeConstraints { make in
                    make.width.equalTo(view)
                    make.top.bottom.equalToSuperview()
                }

                newsImageView.snp.makeConstraints { make in
                    make.top.equalTo(contentView)
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(300)
                }
                dateLabel.snp.makeConstraints { make in
                    make.top.equalTo(newsImageView.snp.bottom).offset(5)
                    make.leading.trailing.equalToSuperview().inset(10)
                }

                titleLabel.snp.makeConstraints { make in
                    make.top.equalTo(dateLabel.snp.bottom).offset(20)
                    make.leading.trailing.equalToSuperview().inset(10)
                }

                descriptionLabel.snp.makeConstraints { make in
                    make.top.equalTo(titleLabel.snp.bottom).offset(20)
                    make.leading.trailing.equalToSuperview().inset(10)
                    make.bottom.equalTo(contentView.snp.bottomMargin).offset(-20)
                }
            }
    }




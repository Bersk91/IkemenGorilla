//
//  HomeViewController.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class HomeViewController: UIViewController, View, ViewConstructor {
    
    struct Const {
        static let scrollViewContentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    
    private let scrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
        $0.showsVerticalScrollIndicator = false
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let currentContestHeader = HomeCurrentContestHeader()
    
    private lazy var currentContestListView = HomeCurrentContestListView().then {
        $0.reactor = reactor?.createHomeCurrentContestListReactor()
    }
    
    private let pastContestHeader = HomePastContestHeader()
    
    private lazy var pastContestListView = HomePastContestListView().then {
        $0.reactor = reactor?.createHomePastContestListReactor()
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    
    func setupViews() {
        scrollView.contentInset = Const.scrollViewContentInset
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(currentContestHeader)
        stackView.addArrangedSubview(currentContestListView)
        stackView.setCustomSpacing(36, after: currentContestListView)
        stackView.addArrangedSubview(pastContestHeader)
        stackView.addArrangedSubview(pastContestListView)
    }
    
    func setupViewConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: HomeReactor) {
        // Action
        
        // State
    }
}

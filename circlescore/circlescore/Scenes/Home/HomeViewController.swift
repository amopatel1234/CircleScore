//
//  HomeViewController.swift
//  circlescore
//
//  Created by Amish Patel on 20/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel
    
    @IBOutlet weak var donutView: DonutProgressView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var retryButton: UIButton!
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        fetchData()
        // Do any additional setup after loading the view.
    }

    @IBAction func retryTapped(_ sender: Any) {
        fetchData()
    }
    
    func fetchData() {
        viewModel.getDataFromEndPoint()
    }
    
    func showLoadingView() {
        loadingView.isHidden = false
    }
    
    func hideLoadingView() {
        loadingView.isHidden = true
    }

    func updateDocuntViewProgress(creditScore: Int, maxScore: Int) {
        donutView.updateScoreAndMaxScore(score: creditScore, maxScore: maxScore)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didFailLoadingData() {
        hideLoadingView()
    }
    
    func didFinishLoadingData(creditScore: Int, maxScore: Int) {
        hideLoadingView()
        updateDocuntViewProgress(creditScore: creditScore, maxScore: maxScore)
    }
    
    func loadingDataFromEndpoint() {
        showLoadingView()
    }
}

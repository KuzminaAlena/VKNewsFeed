//
//  NewsFeedViewController.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 06.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: AnyObject {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic, NeewsFeedCellCodeDelegate {
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    
    private var titleView = TitleView()
    private var footerView = FooterView()
    
    private var feedViewModel = FeedViewModel.init(cells: [], footerTitle: nil)
    
    private var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self,
                     action: #selector(refresh),
                     for: .valueChanged)
        return rc
    }()
    
    let tableView : UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsFeedInteractor()
    let presenter             = NewsFeedPresenter()
    let router                = NewsFeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
      self.view.addSubview(tableView)
      view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
      
      setup()
      setupTableView()
      setupTabBar()
     // navigationItem.title = "News Feed"
      navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
     
      interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
      interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getUser)
  }
    
    @objc private func refresh() {
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
    }
    
    private func setupTabBar() {
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
        
    }
  
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
      switch viewModel {
      case .displayNewsFeed(feedViewModel: let feedViewModel):
          self.feedViewModel = feedViewModel
          footerView.setTitle(feedViewModel.footerTitle)
          tableView.reloadData()
          refreshControl.endRefreshing()
      case .dasplayUser(userViewModel: let userViewModel):
          titleView.set(userViewModel: userViewModel)
      case .displayFooterLoader:
          footerView.showLoader()
      }
  }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getOldNews)
        }
    }
    
    
  //MARK: NeewsFeedCellCodeDelegate
    func revealPost(for cell: NewsFeedCellCode) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.revealPostId(postId: cellViewModel.postId))
    }
}

extension NewsFeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        
        tableView.backgroundColor = .clear

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let topInset: CGFloat = 8
        tableView.contentInset.top = topInset // ИСПРАВИТЬ ОТСТУП. ОН БЕЛЫЙ!!!!
        
        //tableView.register(UINib(nibName: "NewsFeedCell", bundle: nil),  forCellReuseIdentifier: NewsFeedCell.reuseId)
        tableView.register(NewsFeedCell.self)
        tableView.register(NewsFeedCellCode.self)
        
        tableView.addSubview(refreshControl)
        tableView.tableFooterView = footerView

    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //MARK: Register xib cell
//        let cell: NewsFeedCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
//        let cellViewModel = feedViewModel.cells[indexPath.row]
//        cell.set(viewModel: cellViewModel)
        
        //MARK: Register code cell
        let cell: NewsFeedCellCode = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHight
    }
}

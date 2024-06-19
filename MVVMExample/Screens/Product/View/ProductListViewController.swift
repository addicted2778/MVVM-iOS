//
//  ProductListViewController.swift
//  MVVMExample
//
//  Created by WhyQ on 21/03/24.
//

import UIKit

class ProductListViewController: UIViewController {
    @IBOutlet weak var productTableView:UITableView!
    private var viewModel = ProductViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    // Do any additional setup after loading the view.
}

extension ProductListViewController {
    func configuration() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fatchProducts()
    }
    
    func observeEvent(){
        viewModel.eventHandler = {[weak self] event in
            guard let self else {
                return
            }
            
            switch event {
            case .loading:
                print("product loading")
            case .stopLoading:
                print("stop loading")
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}
    
extension ProductListViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
}

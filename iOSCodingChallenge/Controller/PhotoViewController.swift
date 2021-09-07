//
//  PhotoViewController.swift
//  iOSCodingChallenge
//
//  Created by Farid Afzal on 06/09/2021.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let parser = Parser()
    var photos = [Photo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photos Data"
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.beginRefreshing()
        self.tableView.separatorStyle = .none
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        parser.parse {
            data in
            self.photos = data
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.separatorStyle = .singleLine
                self.tableView.reloadData()
            }
        }
    }
}

extension PhotoViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! photoTableViewCell
        cell.title?.text = photos[indexPath.row].title
        cell.img?.sd_setImage(with: URL(string: photos[indexPath.row].thumbnailUrl!), placeholderImage: UIImage(named: "image"))
        return cell
    }
}

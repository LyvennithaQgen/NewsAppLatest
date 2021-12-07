//
//  ViewController.swift
//  NewsApp
//
//  Created by Lyvennitha on 07/12/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, NetworkConstants {
    var baseURL: String = "https://newsapi.org/v2/everything"
    
    var method: String = ""
    
    @IBOutlet weak var newsTable: UITableView!

    var newList: NewsListResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkHandler.shared.delegate = self
        getNewsList()
        // Do any additional setup after loading the view.
    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newList?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsTableCell
        let data = newList?.articles?[indexPath.row]
        cell?.authorLbl.text = data?.author
        cell?.titleLBl.text = data?.title
        cell?.content.text = data?.content
        cell?.imgView.sd_setImage(with: URL(string: data?.urlToImage ?? ""), placeholderImage: UIImage(systemName: ""), options: .continueInBackground)
        cell?.viewNews.tag = indexPath.row
        cell?.viewNews.addTarget(self, action: #selector(viewMoreAction(_:)), for: .touchUpInside)
        return cell!
    }
    
    
    
       @IBAction func viewMoreAction(_ sender: UIButton){
        let data = newList?.articles?[sender.tag]
        let vc = storyboard?.instantiateViewController(identifier: "ViewMoreNewsController") as? ViewMoreNewsController
        vc?.titleStr = data?.title ?? ""
        vc?.urlStriing = data?.url ?? ""
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension ViewController{
    
    func getNewsList(){
        NewsListViewModel.shared.getLatestNewsData(onResponse: {(result) in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self.newList = data
                    self.newsTable.reloadData()
                }
            case .failure(let error):
                print("Error", error.localizedDescription)
            }
        })
    }
}



class NewsTableCell: UITableViewCell{
    
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var titleLBl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var viewNews: UIButton!
}

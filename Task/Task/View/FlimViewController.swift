//
//  ViewController.swift
//  Task
//
//  Created by Bala on 01/07/22.
//

import UIKit

class FlimViewController: UIViewController {

    @IBOutlet weak var collectionView : UICollectionView!
    
    var viewModel = FilmViewModel()
    
    var filmsearchList = [Search]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self

        self.apiCallForGetFlimList()
        
    }
    
    func apiCallForGetFlimList(){
        self.viewModel.apiForGetFilmList { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    let listModel = try JSONDecoder().decode(FilmListModel.self, from: data)
                    if let searchlist = listModel.search{
                        self.filmsearchList = searchlist
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                } catch let error {
                    print(error)
                }
                // now use data here
            }
        }
    }
}
extension FlimViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filmsearchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlimListCollectionViewCell", for: indexPath) as! FlimListCollectionViewCell
        cell.cellConfigureForFlimList(element: self.filmsearchList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let divideValue = 2.0
        let cellWidth = collectionView.bounds.width - 10 / divideValue
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


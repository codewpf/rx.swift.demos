//
//  ViewController.swift
//  rxswiftdemo2
//
//  Created by Alex on 10/03/20.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Person>> (
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: RXDemoCell.identifier) as! RXDemoCell
            cell.name.text = element.name
            cell.gender.text = element.gender
            cell.age.text = "\(element.age)"
            return cell
        }
    )
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.register(RXDemoCell.self, forCellReuseIdentifier: RXDemoCell.identifier)
        let dataSource = self.dataSource
        
        let items = Observable.just([
            SectionModel(model: "First section", items: [
                Person(name: "Haha", gender: "male", age: 27),
                Person(name: "Hei", gender: "male", age: 23),
                Person(name: "Aeq", gender: "female", age: 54),
                Person(name: "Mad", gender: "male", age: 12),
                Person(name: "Ivs", gender: "female", age: 32),
                Person(name: "Lkf", gender: "other", age: 22)
                ])
            ])
        
        items.bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
        
        
        tableView.rx
            .itemSelected
            .map{indexPath in
                return (indexPath, dataSource[indexPath])
        }.subscribe(onNext: { p in
            print(p.0)
        })
        .disposed(by: disposeBag)
        
        tableView.rx
        .setDelegate(self)
        .disposed(by: disposeBag)
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}



class RXDemoCell: UITableViewCell, UICellReuseIdentifer {
    var name: UILabel = {
        let n = UILabel(frame: CGRect(x: 15, y: 10, width: 120, height: 30))
        n.textColor = .black
        n.font = UIFont.systemFont(ofSize: 19)
        return n
    }()
    
    var gender: UILabel = {
        let g = UILabel(frame: CGRect(x:UIScreen.main.bounds.size.width-15-60 , y: 10, width: 60, height: 30))
        g.textAlignment = .right
        g.textColor = .gray
        g.font = UIFont.systemFont(ofSize: 16)
        return g
    }()
    
    var age: UILabel = {
        let a = UILabel(frame: CGRect(x: 15, y: 40, width: 120, height: 20))
        a.textColor = .gray
        a.font = UIFont.systemFont(ofSize: 16)
        return a
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.name)
        self.contentView.addSubview(self.gender)
        self.contentView.addSubview(self.age)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}







import UIKit

let mainVTag = 11
let themeBGColor = UIColor.init(red: 32/255, green: 65/255, blue: 77/255, alpha: 1)
var top : CGFloat = 0
var left : CGFloat = 0
var popupHeightMultiplier : CGFloat = 0.65
class NoRecordFound : UIView {
    
    let mainView : UIView = {
        let viewObj = UIView()
        viewObj.backgroundColor = .clear
        viewObj.translatesAutoresizingMaskIntoConstraints = false
        return viewObj
    }()
    
    let imgView : UIImageView = {
        let imgV = UIImageView()
        imgV.image = #imageLiteral(resourceName: "sad")
        imgV.contentMode = .scaleAspectFit
        imgV.translatesAutoresizingMaskIntoConstraints = false
        return imgV
    }()
    
    let lblNoData : UILabel = {
        let lblObj = UILabel()
        lblObj.translatesAutoresizingMaskIntoConstraints = false
        lblObj.textColor = UIColor.black
        lblObj.font = UIFont.systemFont(ofSize: 12)
        lblObj.textAlignment = .center
        lblObj.numberOfLines = 2
        lblObj.text = "No Data found"
        return lblObj
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.addSubview(mainView)
        mainView.addSubview(imgView)
        mainView.addSubview(lblNoData)
        NSLayoutConstraint.activate([
            mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            mainView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            imgView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            imgView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.65),
            imgView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.65)
        ])
        
        NSLayoutConstraint.activate([
            lblNoData.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 0),
            lblNoData.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            lblNoData.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 1),
            lblNoData.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.35)
        ])
        
    }
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
}

class KGCell : UITableViewCell {
    
    let mainView : UIView = {
        let viewObj = UIView()
        viewObj.translatesAutoresizingMaskIntoConstraints = false
        return viewObj
    }()
    
    let lblTitle : UILabel = {
        let lblObj = UILabel()
        lblObj.translatesAutoresizingMaskIntoConstraints = false
        lblObj.textColor = UIColor.black
        lblObj.font = UIFont.systemFont(ofSize: 12)
        lblObj.textAlignment = .left
        lblObj.numberOfLines = 0
        return lblObj
    }()
    
    let sepLine : UIView = {
        let viewObj = UIView()
        viewObj.translatesAutoresizingMaskIntoConstraints = false
        viewObj.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        return viewObj
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "KGCell")
       
        selectionStyle = .none
        
        contentView.addSubview(mainView)
        self.mainView.addSubview(self.lblTitle)
        self.mainView.addSubview(self.sepLine)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            lblTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            lblTitle.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            lblTitle.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            sepLine.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            sepLine.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            sepLine.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            sepLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class KGTableView: UIView {

    var didTouchTheKGView: (() -> ())?
    typealias selectedTouple = ([String :Any], Int)
    var didSelectKGTableViewRow: ((selectedTouple) -> ())?
    fileprivate var arrItems : [[String : Any]?]?
    fileprivate var arrItemsCopy : [[String : Any]?]?
    private var bgColor : UIColor?
    private var displayKey : String?
    var needSearchBar: Bool? = false
    
    
    var viewObjNoData : NoRecordFound?
    
    var selectedData : selectedTouple = ([:],-1)
    let mainView : UIView = {
        let viewObj = UIView()
        viewObj.tag = mainVTag
        viewObj.translatesAutoresizingMaskIntoConstraints = false
        return viewObj
    }()
    
    let subPopupView : UIView = {
        let viewObj = UIView()
        viewObj.translatesAutoresizingMaskIntoConstraints = false
        return viewObj
    }()
    
    let titleBar : UIView = {
        let viewObj = UIView()
        viewObj.translatesAutoresizingMaskIntoConstraints = false
        viewObj.backgroundColor = themeBGColor
        return viewObj
    }()
    
    let lblTitle : UILabel = {
        let lblObj = UILabel()
        lblObj.translatesAutoresizingMaskIntoConstraints = false
        lblObj.textColor = UIColor.white
        lblObj.text = "Select Category"
        lblObj.font = UIFont.boldSystemFont(ofSize: 13)
        lblObj.textAlignment = .center
        return lblObj
    }()
    
    let btnClose : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = .white
        return button
    }()
    
    let searchBar : UISearchBar = {
        let searchObj = UISearchBar()
        searchObj.translatesAutoresizingMaskIntoConstraints = false
        searchObj.searchBarStyle = .minimal
        searchObj.clearsContextBeforeDrawing = false
        searchObj.placeholder = "Search category"
        searchObj.searchTextField.font = UIFont.systemFont(ofSize: 12)
        searchObj.autocorrectionType = .no
        searchObj.showsScopeBar = true
        return searchObj
    }()
    
    let sepLine : UIView = {
        let viewObj = UIView()
        viewObj.translatesAutoresizingMaskIntoConstraints = false
        viewObj.backgroundColor = UIColor.black
        return viewObj
    }()
    let btnDone : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = themeBGColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("DONE", for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let tableViewKG : UITableView = {
        let tableV = UITableView()
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.separatorStyle = .none
        return tableV
    }()
        
    
    init<T: Any>(withArray items : T?, backgroundColor : UIColor?, key strKey: String, needSearchBar : Bool) {
       
        super.init(frame: UIScreen.main.bounds)
        
        top = self.frame.size.height * 0.15
        left = self.frame.size.width * 0.10
        
        if items != nil {
            self.arrItems = items as? [[String : Any]]
            self.arrItemsCopy = items as? [[String : Any]]
            self.bgColor = backgroundColor
            self.needSearchBar = needSearchBar
            self.setupConstrints()
            self.setupUtilities()
            self.displayKey = strKey
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillAppear(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillDisappear(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    private func setupUtilities() {
        
        mainView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        subPopupView.backgroundColor = UIColor.white
        titleBar.backgroundColor = self.bgColor!
        btnDone.backgroundColor = self.bgColor!
        subPopupView.layer.cornerRadius = 10
        subPopupView.clipsToBounds = true
                
        self.tableViewKG.delegate = self
        self.tableViewKG.dataSource = self
        self.tableViewKG.rowHeight = UITableView.automaticDimension
        self.tableViewKG.estimatedRowHeight = 50
        self.tableViewKG.register(KGCell.self, forCellReuseIdentifier: "KGCell")
        self.tableViewKG.reloadData()
        
        self.searchBar.delegate = self
        self.btnDone.addTarget(self, action: #selector(KGTableView.btnDoneCliked(_:)), for: .touchUpInside)
        self.btnClose.addTarget(self, action: #selector(KGTableView.btnCloseClicked(_:)), for: .touchUpInside)
    }
    
    @objc func btnDoneCliked(_ sender : UIButton) {
        if selectedData.0.count == 0 {
            return
        }
        self.didSelectKGTableViewRow!(selectedData)
        self.didTouchTheKGView!()
        selectedData = ([:],-1)
        
    }
    @objc func btnCloseClicked(_ sender : UIButton) {
        self.didTouchTheKGView!()
    }
    
    private func setupConstrints() {
        
        self.addSubview(mainView)
        self.mainView.addSubview(self.subPopupView)
        self.subPopupView.addSubview(self.titleBar)
        self.titleBar.addSubview(self.lblTitle)
        self.titleBar.addSubview(self.btnClose)
        if needSearchBar == true {
            self.subPopupView.addSubview(self.searchBar)
        }
        self.subPopupView.addSubview(self.sepLine)
        self.subPopupView.addSubview(self.btnDone)
        self.subPopupView.addSubview(self.tableViewKG)
       
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subPopupView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: top),
            subPopupView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: popupHeightMultiplier),
            subPopupView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left),
            subPopupView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -left)
        ])
        
        NSLayoutConstraint.activate([
            titleBar.topAnchor.constraint(equalTo: subPopupView.topAnchor, constant: 0),
            titleBar.leadingAnchor.constraint(equalTo: subPopupView.leadingAnchor, constant: 0),
            titleBar.trailingAnchor.constraint(equalTo: subPopupView.trailingAnchor, constant: 0),
            titleBar.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: titleBar.topAnchor, constant: 5),
            lblTitle.leadingAnchor.constraint(equalTo: titleBar.leadingAnchor, constant: 5),
            lblTitle.trailingAnchor.constraint(equalTo: titleBar.trailingAnchor, constant: -5),
            lblTitle.bottomAnchor.constraint(equalTo: titleBar.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            btnClose.topAnchor.constraint(equalTo: titleBar.topAnchor, constant: 0),
            btnClose.trailingAnchor.constraint(equalTo: titleBar.trailingAnchor, constant: 0),
            btnClose.bottomAnchor.constraint(equalTo: titleBar.bottomAnchor, constant: 0),
            btnClose.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        if needSearchBar == true {
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: titleBar.bottomAnchor, constant: 8),
                searchBar.leadingAnchor.constraint(equalTo: subPopupView.leadingAnchor, constant: 0),
                searchBar.trailingAnchor.constraint(equalTo: subPopupView.trailingAnchor, constant: 0),
                searchBar.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            if let searchTextField = self.searchBar.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton")as? UIButton {
                clearButton.addTarget(self, action: #selector(KGTableView.btnClearForSearchBarClicked(_:)), for: .touchUpInside)
            }
            
            
        }
       
        if needSearchBar == true {
            NSLayoutConstraint.activate([
                tableViewKG.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
                tableViewKG.leadingAnchor.constraint(equalTo: subPopupView.leadingAnchor, constant: 0),
                tableViewKG.trailingAnchor.constraint(equalTo: subPopupView.trailingAnchor, constant: 0),
                //tableViewKG.bottomAnchor.constraint(equalTo: btnDone.topAnchor, constant: 0),
            ])
        }
        else {
            NSLayoutConstraint.activate([
                tableViewKG.topAnchor.constraint(equalTo: titleBar.bottomAnchor, constant: 8),
                tableViewKG.leadingAnchor.constraint(equalTo: subPopupView.leadingAnchor, constant: 0),
                tableViewKG.trailingAnchor.constraint(equalTo: subPopupView.trailingAnchor, constant: 0),
                //tableViewKG.bottomAnchor.constraint(equalTo: btnDone.topAnchor, constant: 0),
            ])
        }
        NSLayoutConstraint.activate([
            btnDone.topAnchor.constraint(equalTo: tableViewKG.bottomAnchor, constant: 0),
            btnDone.bottomAnchor.constraint(equalTo: subPopupView.bottomAnchor, constant: 0),
            btnDone.leadingAnchor.constraint(equalTo: subPopupView.leadingAnchor, constant: 0),
            btnDone.trailingAnchor.constraint(equalTo: subPopupView.trailingAnchor, constant: 0),
            btnDone.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        if needSearchBar == true {
            NSLayoutConstraint.activate([
                sepLine.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 7),
                sepLine.leadingAnchor.constraint(equalTo: subPopupView.leadingAnchor, constant: 0),
                sepLine.trailingAnchor.constraint(equalTo: subPopupView.trailingAnchor, constant: 0),
                sepLine.heightAnchor.constraint(equalToConstant: 1)
            ])
        }
    }
    
    fileprivate func setupNoDataViewToTable() {
        
        if self.viewObjNoData == nil {
            self.viewObjNoData = NoRecordFound()
        }
        
        self.tableViewKG.addSubview(self.viewObjNoData!)
        self.viewObjNoData!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.viewObjNoData!.centerYAnchor.constraint(equalTo: self.tableViewKG.centerYAnchor),
            self.viewObjNoData!.centerXAnchor.constraint(equalTo: self.tableViewKG.centerXAnchor),
            self.viewObjNoData!.widthAnchor.constraint(equalTo: self.tableViewKG.widthAnchor, multiplier: 0.60),
            self.viewObjNoData!.heightAnchor.constraint(equalTo: self.tableViewKG.heightAnchor, multiplier: 0.60)
        ])
        
    }
    
    fileprivate func removeNoDataViewFromSuperView() {
        if self.viewObjNoData != nil {
            self.viewObjNoData!.removeFromSuperview()
        }
    }

    override func draw(_ rect: CGRect) {
    }
    
    override class var requiresConstraintBasedLayout: Bool {
       return true
    }
    
    @objc func btnClearForSearchBarClicked(_ sender : UIButton) {
        if self.arrItemsCopy != nil {
            
            self.arrItems?.removeAll()
            self.arrItems = self.arrItemsCopy
            self.removeNoDataViewFromSuperView()
           
            self.searchBar.resignFirstResponder()
            self.endEditing(true)

            NSLayoutConstraint.activate([
                mainView.topAnchor.constraint(equalTo: self.topAnchor),
                mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
                mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
            
            NSLayoutConstraint.activate([
                subPopupView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: top),
                subPopupView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: popupHeightMultiplier),
                subPopupView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left),
                subPopupView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -left)
            ])
            
        }
    }
    
}

extension KGTableView : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrItems!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.tableViewKG.dequeueReusableCell(withIdentifier: "KGCell") as? KGCell
        if let dict = arrItems![indexPath.row] {
            if let name = dict[self.displayKey!] as? String {
                cell?.lblTitle.text = name
            }
        }
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.searchBar.resignFirstResponder()
        self.endEditing(true)

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subPopupView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: top),
            subPopupView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: popupHeightMultiplier),
            subPopupView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left),
            subPopupView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -left)
        ])
        guard let items = self.arrItems else { return }
        if let dictObj = items[indexPath.row] {
            selectedData.0 = dictObj
            selectedData.1 = indexPath.row
        }
        
    }
    
}

extension KGTableView : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        self.searchBar.resignFirstResponder()
        self.endEditing(true)

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subPopupView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: top),
            subPopupView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.70),
            subPopupView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left),
            subPopupView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -left)
        ])
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            
            if self.arrItemsCopy != nil {
                self.arrItems?.removeAll()
                self.arrItems = self.arrItemsCopy
                self.removeNoDataViewFromSuperView()
                self.selectedData = ([:],-1)
            }
        }
        else {
            
            if self.arrItemsCopy != nil {
                let filteredArray = arrItemsCopy!.filter( {($0!["name"]! as! String).contains(searchText)} )
                if filteredArray.count > 0 {
                    self.arrItems?.removeAll()
                    self.arrItems = filteredArray
                    self.removeNoDataViewFromSuperView()
                }
                else {
                    if self.arrItemsCopy != nil {
                        self.arrItems?.removeAll()
                        self.setupNoDataViewToTable()
                        self.selectedData = ([:],-1)
                    }
                }
            }
        }
         self.tableViewKG.reloadData()
        
    }

    
}

extension KGTableView {
    
    
    @objc
    func keyboardWillAppear(notification: NSNotification?) {

        guard let _ = notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        NSLayoutConstraint.activate([
            subPopupView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: top),
            subPopupView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.45),
            subPopupView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left),
            subPopupView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -left)
        ])
        
    }

    @objc
    func keyboardWillDisappear(notification: NSNotification?) {
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            subPopupView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: top),
            subPopupView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: popupHeightMultiplier),
            subPopupView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left),
            subPopupView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -left)
        ])
        
    }
}

extension KGTableView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            guard let view = touch.view else { return }
            if view.tag == mainVTag {
                self.didTouchTheKGView!()
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            guard let view = touch.view else { return }
            if view.tag == mainVTag {
                self.didTouchTheKGView!()
            }
        }
    }
    
}

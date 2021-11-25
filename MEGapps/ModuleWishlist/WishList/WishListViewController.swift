//
//  WishListViewController.swift
//  MEGapps
//
//  Created by Arya Ilham on 27/10/21.
//

import UIKit
import Combine

class WishListViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var wishlistTableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    // MARK: - ViewModel
    private let wishListViewModel = WishListViewModel()
    var anyCancellable = Set<AnyCancellable>()
    
    // MARK: - Variable
    var segments = ["Ready to Accept", "---", "On Wait"]
        
    // MARK: - State
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        NotificationService.shared.requestAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribe()
        fetchData()
        print("view will appear")
    }
    
    // MARK: - Function
    private func fetchData() {
        wishListViewModel.fetchData()
    }

    private func subscribe() {
        wishListViewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.wishlistTableView.reloadData()
                }
            }.store(in: &anyCancellable)
        
        wishListViewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.setupNoDataView()
            }.store(in: &anyCancellable)
    }
    
    private func setupNoDataView() {
        if wishListViewModel.hasItem {
            wishlistTableView.backgroundView = nil
        } else {
            wishlistTableView.backgroundView = noDataView
        }
    }
    
    // MARK: - IBAction
    @IBAction func addNewWishlist(_ sender: Any) {
        let storyboard = UIStoryboard(name: "WishlistAdd", bundle: nil)
        guard let storyboardWL = storyboard.instantiateViewController(withIdentifier: "wishlistAddSB") as? WishlistAddView
        else {
            fatalError("VC not found")
        }
        navigationController?.pushViewController(storyboardWL, animated: true)
        
    }
}

// MARK: - TableView
extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    private func registerNib() {
        wishlistTableView.rowHeight = UITableView.automaticDimension
        wishlistTableView.estimatedRowHeight = 135
        wishlistTableView.register(UITableViewCell.self, forCellReuseIdentifier: "HeaderCell")
        wishlistTableView.register(ReadyToAcceptTableViewCell.self, forCellReuseIdentifier: ReadyToAcceptTableViewCell.identifier)
        wishlistTableView.register(UINib.init(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "wishlistTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishListViewModel.items.count + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 3 {
            if indexPath.row == 0 || indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath as IndexPath)
                cell.textLabel!.text = "\(self.segments[indexPath.row])"
                cell.textLabel!.font = .systemFont(ofSize: 20, weight: .semibold)
                cell.backgroundColor = UIColor(named: "BackgroundColor")
                cell.textLabel!.translatesAutoresizingMaskIntoConstraints = false
                cell.textLabel!.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0).isActive = true
                cell.textLabel!.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0).isActive = true
                cell.textLabel!.topAnchor.constraint(equalTo: cell.topAnchor, constant: 16).isActive = true
                return cell
            } else {
                // MARK: - Collection view
                let cell = tableView.dequeueReusableCell(withIdentifier: ReadyToAcceptTableViewCell.identifier, for: indexPath)
//                cell.isUserInteractionEnabled = false
//                print("Heeee\(cell.isUserInteractionEnabled)")
                return cell
            }
        } else {
            guard let cell = wishlistTableView.dequeueReusableCell(withIdentifier: "wishlistTableViewCell", for: indexPath) as? WishlistTableViewCell else {
                fatalError("no cell")
            }
            cell.newData = wishListViewModel.items[indexPath.row-3]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        wishlistTableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row >= 3 {
            let wishlistDetailVC = WishlistDetailViewController()
            wishlistDetailVC.container = wishListViewModel.items[indexPath.row-3]
            navigationController?.pushViewController(wishlistDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class ReadyToAcceptTableViewCell: UITableViewCell {
    static let identifier = "ReadyToAcceptTableViewCell"
    var collectionView: UICollectionView!
    
    // MARK: - Func init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemRed
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(ReadyToAcceptCollectionViewCell.self, forCellWithReuseIdentifier: ReadyToAcceptCollectionViewCell.identifier)
        self.collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        self.addSubview(self.collectionView)
        
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.heightAnchor.constraint(equalToConstant: 135),
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData() {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
    }
    func setupUI() {
    }
}

extension ReadyToAcceptTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.collectionView.dequeueReusableCell(withReuseIdentifier: ReadyToAcceptCollectionViewCell.identifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 243, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15
    }
}

extension ReadyToAcceptTableViewCell {
    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        sendSubviewToBack(contentView)
    }
}

class ReadyToAcceptCollectionViewCell: UICollectionViewCell {
    static let identifier = "ReadyToAcceptCollectionViewCell"
    
    // MARK: - IBOutlet
    let containerView = UIView()
    let statusIconImage = UIImageView()
    let itemNameLabel = UILabel()
    let waitingPeriodOverLabel = UILabel()
    let waitingDate = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addViews()
        self.setupUI()
    }

    func addViews() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.statusIconImage)
        self.containerView.addSubview(self.itemNameLabel)
        self.containerView.addSubview(self.waitingPeriodOverLabel)
        self.containerView.addSubview(self.waitingDate)
        
        self.containerView.backgroundColor = UIColor(named: "OnProgressCellColor")
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
        self.containerView.layer.cornerRadius = 15
        
        self.statusIconImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.statusIconImage.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16),
            self.statusIconImage.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 19),
            self.statusIconImage.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        self.itemNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        self.itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.itemNameLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16),
            self.itemNameLabel.leadingAnchor.constraint(equalTo: self.statusIconImage.trailingAnchor, constant: 4),
            self.itemNameLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.statusIconImage.image = UIImage(systemName: "checkmark.circle")
        self.statusIconImage.tintColor = .black
        self.itemNameLabel.text = "ItemName"
        self.waitingPeriodOverLabel.text = "Waiting Period Over"
        self.waitingDate.text = "19 August, 2021 06:51"
    }

}

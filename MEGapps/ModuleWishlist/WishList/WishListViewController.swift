//
//  WishListViewController.swift
//  MEGapps
//
//  Created by Arya Ilham on 27/10/21.
//

import UIKit
import Combine

protocol WishListDetailProtocol {
    func pushView(itemData: Items)
}

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
        setupNoDataView()
        print("view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
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
        
        wishListViewModel.$readyToAcceptItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.wishlistTableView.reloadData()
                    for cell in self?.wishlistTableView.visibleCells ?? [] {
                        guard let tempCell = cell as? ReadyToAcceptTableViewCell else {
                            return
                        }
                        tempCell.collectionView.reloadData()
                        print("xi success")
                    }
//                    if let cell = self?.wishlistTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? ReadyToAcceptTableViewCell {
//                        cell.collectionView.reloadData()
//                        print("refreshed xi")
//                    }
                }
            }.store(in: &anyCancellable)
    }
    
    private func setupNoDataView() {
        if !noDataView.isDescendant(of: wishlistTableView) {
            wishlistTableView.addSubview(noDataView)
        }
        
        if wishListViewModel.hasItem || wishListViewModel.hasReadyToAcceptItems {
            noDataView.isHidden = true
            print("wishlist has data")
        } else {
            noDataView.isHidden = false
            print("wishlist no data")
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
        var tempCounter = 0
        if wishListViewModel.hasReadyToAcceptItems {
            tempCounter += 2
        }
        if wishListViewModel.hasItem {
            tempCounter += 1
        }
        return wishListViewModel.items.count + tempCounter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tempCounter = 0
        if wishListViewModel.hasItem || wishListViewModel.hasReadyToAcceptItems {
            if wishListViewModel.hasReadyToAcceptItems {
                tempCounter+=2
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath as IndexPath)
                    cell.textLabel!.text = "\(self.segments[0])"
                    cell.textLabel!.font = .systemFont(ofSize: 20, weight: .semibold)
                    cell.backgroundColor = UIColor(named: "BackgroundColor")
                    cell.textLabel!.translatesAutoresizingMaskIntoConstraints = false
                    cell.textLabel!.textAlignment = .left
                    cell.textLabel!.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0).isActive = true
                    cell.textLabel!.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0).isActive = true
                    cell.textLabel!.topAnchor.constraint(equalTo: cell.topAnchor, constant: 16).isActive = true
                    return cell
                } else if indexPath.row == 1 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: ReadyToAcceptTableViewCell.identifier, for: indexPath) as? ReadyToAcceptTableViewCell else {
                        fatalError("no cell")
                    }
                    cell.wishListVCDelegate = self
                    cell.viewModel = wishListViewModel
                    return cell
                }
            }
            if wishListViewModel.hasItem {
                tempCounter+=1
                if indexPath.row == tempCounter-1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath as IndexPath)
                    cell.textLabel!.text = "\(self.segments[2])"
                    cell.textLabel!.font = .systemFont(ofSize: 20, weight: .semibold)
                    cell.backgroundColor = UIColor(named: "BackgroundColor")
                    cell.textLabel!.translatesAutoresizingMaskIntoConstraints = false
                    cell.textLabel!.textAlignment = .left
                    cell.textLabel!.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0).isActive = true
                    cell.textLabel!.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0).isActive = true
                    cell.textLabel!.topAnchor.constraint(equalTo: cell.topAnchor, constant: 16).isActive = true
                    return cell
                } else {
                    guard let cell = wishlistTableView.dequeueReusableCell(withIdentifier: "wishlistTableViewCell", for: indexPath) as? WishlistTableViewCell else {
                        fatalError("no cell")
                    }
                    cell.newData = wishListViewModel.items[indexPath.row-tempCounter]
                    return cell
                }
            } else {
                // MARK: if no both array of item have no data
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath as IndexPath)
                cell.textLabel!.text = "No data available"
                cell.textLabel!.font = .systemFont(ofSize: 20, weight: .semibold)
                cell.backgroundColor = UIColor(named: "BackgroundColor")
                cell.textLabel!.translatesAutoresizingMaskIntoConstraints = false
                cell.textLabel!.textAlignment = .center
                cell.textLabel!.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0).isActive = true
                cell.textLabel!.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0).isActive = true
                cell.textLabel!.topAnchor.constraint(equalTo: cell.topAnchor, constant: 16).isActive = true
                return cell
            }
        } else {
            // MARK: if no both array of item have no data
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath as IndexPath)
            cell.textLabel!.text = "No data available"
            cell.textLabel!.font = .systemFont(ofSize: 20, weight: .semibold)
            cell.backgroundColor = UIColor(named: "BackgroundColor")
            cell.textLabel!.translatesAutoresizingMaskIntoConstraints = false
            cell.textLabel!.textAlignment = .center
            cell.textLabel!.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0).isActive = true
            cell.textLabel!.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0).isActive = true
            cell.textLabel!.topAnchor.constraint(equalTo: cell.topAnchor, constant: 16).isActive = true
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var tempCounter = 0
        if wishListViewModel.hasReadyToAcceptItems {
            tempCounter += 2
        }
        if wishListViewModel.hasItem {
            tempCounter += 1
        }
        wishlistTableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row >= tempCounter {
            self.pushView(itemData: wishListViewModel.items[indexPath.row-tempCounter])
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Protocol
extension WishListViewController: WishListDetailProtocol {
    func pushView(itemData: Items) {
        let wishlistDetailVC = WishlistDetailViewController()
        wishlistDetailVC.hidesBottomBarWhenPushed = true
        wishlistDetailVC.container = itemData
        self.navigationController?.pushViewController(wishlistDetailVC, animated: true)
    }
}

// MARK: - Custom table view cell for collection view
class ReadyToAcceptTableViewCell: UITableViewCell {
    static let identifier = "ReadyToAcceptTableViewCell"
    var collectionView: UICollectionView!
    var viewModel: WishListViewModel?
    weak var wishListVCDelegate: WishListViewController?
    
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
}

extension ReadyToAcceptTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.readyToAcceptItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: ReadyToAcceptCollectionViewCell.identifier, for: indexPath) as? ReadyToAcceptCollectionViewCell else {
            fatalError("no view")
        }
        cell.data = self.viewModel?.readyToAcceptItems[indexPath.row]
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCollectionView)))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 243, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15
    }
    
    @objc func tapCollectionView(sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.collectionView)
        guard let indexPath = self.collectionView.indexPathForItem(at: location) else {
            return
        }
        guard let item = self.viewModel?.readyToAcceptItems[indexPath.row] else {
            return
        }
        wishListVCDelegate?.pushView(itemData: item)
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
    var data: Items? {
        didSet {
            setData()
        }
    }
    
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
        
        self.waitingPeriodOverLabel.font = .systemFont(ofSize: 12, weight: .medium)
        self.waitingPeriodOverLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.waitingPeriodOverLabel.topAnchor.constraint(equalTo: self.itemNameLabel.bottomAnchor, constant: 9),
            self.waitingPeriodOverLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 22),
            self.waitingPeriodOverLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: 22)
        ])
        
        self.waitingDate.font = .systemFont(ofSize: 15, weight: .medium)
        self.waitingDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.waitingDate.topAnchor.constraint(equalTo: self.waitingPeriodOverLabel.bottomAnchor, constant: 5),
            self.waitingDate.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 22),
            self.waitingDate.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: 22)
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
        
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.masksToBounds = false
    }
    
    func setData() {
        self.itemNameLabel.text = "\(self.data?.name ?? "Item name")"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy hh:mm"
        self.waitingDate.text = dateFormatter.string(from: self.data?.deadline ?? Date.distantPast)
    }
}

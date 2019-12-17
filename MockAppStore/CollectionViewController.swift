//
//  CollectionViewController.swift
//  MockAppStore
//
//  Created by Ashish Bansal on 06/12/19.
//  Copyright © 2019 Ashish Bansal. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    static let sectionHeader = "section-header"
    static let itemTrailer = "item-trailer"
    
    var sectionsList = [Section]()
    var diffableDataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionsList = decodeAppStoreData(from: "appstore.json")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Apps"
        
        // Register cell classes
        collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
        collectionView.register(MediumCell.self, forCellWithReuseIdentifier: MediumCell.reuseIdentifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: CollectionViewController.sectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        collectionView.register(ItemTrailingView.self, forSupplementaryViewOfKind: CollectionViewController.itemTrailer, withReuseIdentifier: ItemTrailingView.reuseIdentififer)
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        diffableDataSource = createDiffableDataSource(for: collectionView)
        loadDataViaSnapshot()
    }
    
    func decodeAppStoreData(from jsonFile: String) -> [Section] {
        guard let dataUrl = Bundle.main.url(forResource: jsonFile, withExtension: nil) else {
            fatalError("Unable to get url of json file")
        }

        guard let jsonData = try? Data(contentsOf: dataUrl) else {
            fatalError("Unable to get data from json file url")
        }

        do {
            let sectionList = try JSONDecoder().decode(Array<Section>.self, from: jsonData)
            return sectionList
        }
        catch let error {
            fatalError("Failed to decode json data. Error \(error)")
        }
    }
    
    func loadDataViaSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sectionsList)
        for section in sectionsList {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        diffableDataSource?.apply(snapshot)
    }
    
    private func createFeaturedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.75))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    private func createMediumSection() -> NSCollectionLayoutSection {
        let insetValue = CGFloat(12)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.33))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let itemWithSupplementary = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [getItemSupplementaryView(withOffset: insetValue)])
        item.contentInsets = NSDirectionalEdgeInsets(top: insetValue, leading: insetValue, bottom: insetValue, trailing: insetValue)
        itemWithSupplementary.contentInsets = NSDirectionalEdgeInsets(top: insetValue, leading: insetValue, bottom: insetValue, trailing: insetValue)

        let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.66)), subitem: itemWithSupplementary, count: 2)
        
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.75))
        let outerGroup = NSCollectionLayoutGroup.vertical(layoutSize: outerGroupSize, subitems: [innerGroup, item])

        let section = NSCollectionLayoutSection(group: outerGroup)
        
        section.boundarySupplementaryItems = [getSectionHeaderItem()]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func createSmallSection() -> NSCollectionLayoutSection {
        
        //Small section should ideally have it's own cell design, but here the cell for medium section has been shoehorned into for testing purpose.
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let insetValue = CGFloat(10)
        item.contentInsets = NSDirectionalEdgeInsets(top: insetValue, leading: insetValue, bottom: insetValue, trailing: insetValue)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.7))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)

        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [getSectionHeaderItem()]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func getSectionHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
        let sectionHeaderItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: CollectionViewController.sectionHeader, alignment: .top)
        let insetValue = CGFloat(7)
        sectionHeaderItem.contentInsets = NSDirectionalEdgeInsets(top: insetValue, leading: insetValue, bottom: insetValue, trailing: insetValue)
        return sectionHeaderItem
    }
    
    private func getItemSupplementaryView(withOffset yOffset: CGFloat) -> NSCollectionLayoutSupplementaryItem {
        let itemTrailerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(1))
        let itemTrailerAnchor = NSCollectionLayoutAnchor(edges: [.bottom], absoluteOffset: CGPoint(x: 0.0, y: yOffset + 0.5))
        let itemTrailerItem = NSCollectionLayoutSupplementaryItem(layoutSize: itemTrailerSize, elementKind: CollectionViewController.itemTrailer, containerAnchor: itemTrailerAnchor)
        return itemTrailerItem
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let compositionalLayout = UICollectionViewCompositionalLayout{ [unowned self] sectionIndex, layoutEnvironment in
            let sectionType = self.sectionsList[sectionIndex].type
            
            switch sectionType {
            case .smallTable:
                return self.createSmallSection()
            case .mediumTable:
                return self.createMediumSection()
            case .featured:
                return self.createFeaturedSection()
            }
        }
        
        let layoutConfig = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfig.interSectionSpacing = 15
        compositionalLayout.configuration = layoutConfig
        return compositionalLayout
    }
    
    private func getFeaturedCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ item: Item) -> UICollectionViewCell? {
        let featuredCell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCell.reuseIdentifier, for: indexPath) as! FeaturedCell
        featuredCell.configure(to: item)
        return featuredCell
    }
    
    private func getMediumCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ item: Item) -> UICollectionViewCell? {
        let mediumCell = collectionView.dequeueReusableCell(withReuseIdentifier: MediumCell.reuseIdentifier, for: indexPath) as! MediumCell
        mediumCell.configure(to: item)
        return mediumCell
    }
    
    fileprivate func createDiffableDataSource(for collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Section, Item> {
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [unowned self] collectionView, indexPath, item in
            let sectionType = self.sectionsList[indexPath.section].type
            
            switch sectionType {
            case .smallTable:
                fallthrough
            case .mediumTable:
                return self.getMediumCell(collectionView, indexPath, item)
            case .featured:
                return self.getFeaturedCell(collectionView, indexPath, item)
            }
        }
        
        dataSource.supplementaryViewProvider = { [unowned self] collectionView, elementKind, indexPath in
            switch elementKind {
            case CollectionViewController.sectionHeader:
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
                sectionHeader.configure(with: self.sectionsList[indexPath.section])
                return sectionHeader
                
            case CollectionViewController.itemTrailer:
                let itemTrailer = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: ItemTrailingView.reuseIdentififer, for: indexPath) as! ItemTrailingView
                return itemTrailer
                
            default:
                fatalError("Unsupported elementKind")
            }
        }
        
        return dataSource
    }
}

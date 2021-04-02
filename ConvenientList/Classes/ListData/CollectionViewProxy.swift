//
//  CollectionViewProxy.swift
//  ConvenientList
//
//  Created by ty.Chen on 2021/4/2.
//

import Foundation

// MARK: - UICollectionViewDataSource

extension CollectionViewData: UICollectionViewDataSource {
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listSections?.count ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self[section]?.listRows?.count ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = self[indexPath] else {
            assertionFailure("CollectionViewData finds item Error!")
            collectionView.register(cellType: UICollectionViewCell.self)
            return collectionView.dequeueReusableCell(cellType: UICollectionViewCell.self, for: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(cellType: item.rowViewType, for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CollectionViewData: UICollectionViewDelegate {
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let row = self[indexPath] else { return }
        
        if let protocolCell = cell as? UpdateDataProtocol {
            protocolCell.update(rowData: row.rowData)
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionViewDidSlectedClosure?(collectionView, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let section = self[indexPath.section],
                  let header = section.header else { return UICollectionReusableView() }
            let headerView = collectionView .dequeueReusableSupplementaryView(supplementaryViewType: header.viewType, ofKind: kind, for: indexPath)
            
            if let headerViewProtocol = headerView as? UpdateDataProtocol {
                headerViewProtocol.update(rowData: header.viewData)
            }
            
            return headerView
        } else {
            guard let section = self[indexPath.section],
                  let footer = section.footer else { return UICollectionReusableView() }
            let footerView = collectionView .dequeueReusableSupplementaryView(supplementaryViewType: footer.viewType, ofKind: kind, for: indexPath)
            
            if let footerViewProtocol = footerView as? UpdateDataProtocol {
                footerViewProtocol.update(rowData: footer.viewData)
            }
            
            return footerView
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let section = self[section],
              let header = section.header else { return .zero }
        return CGSize(width: collectionView.frame.width, height: header.viewHeight)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let section = self[section],
              let footer = section.footer else { return .zero }
        return CGSize(width: collectionView.frame.width, height: footer.viewHeight)
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listDidScrollClosure?(scrollView)
    }
    
    open func scrollViewDidZoom(_ scrollView: UIScrollView) {
        listDidZoomClosure?(scrollView)
    }
    
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        listWillBeginDraggingClosure?(scrollView)
    }
    
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        listWillEndDraggingClosure?(scrollView, velocity, targetContentOffset)
    }
    
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        listDidEndDraggingClosure?(scrollView, decelerate)
    }
    
    open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        listWillBeginDeceleratingClosure?(scrollView)
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        listDidEndDeceleratingClosure?(scrollView)
    }
    
    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        listDidEndScrollingAnimationClosure?(scrollView)
    }
    
    open func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        guard let closure = listShouldScrollToTopClosure else { return false }
        return closure(scrollView)
    }
    
    open func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        listDidScrollToTopClosure?(scrollView)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewData: UICollectionViewDelegateFlowLayout {
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self[indexPath]?.itemSize ?? CGSize(width: 44, height: 44)
    }
}

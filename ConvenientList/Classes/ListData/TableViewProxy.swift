//
//  TableViewProxy.swift
//  ConvenientList
//
//  Created by ty.Chen on 2021/4/2.
//

import Foundation

// MARK: - UITableViewDataSource

extension TableViewData: UITableViewDataSource {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return listSections?.count ?? 0
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self[section]?.listRows?.count ?? 0
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = self[indexPath] else {
            return tableViewCell(tableView, for: indexPath)
        }
        
        let cell = tableViewCell(tableView, for: indexPath, cellType: row.rowViewType)
        return cell
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = self[section],
              let header = section.header else { return 0}
        return header.viewHeight
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = self[section],
              let header = section.header else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(viewType: header.viewType)
        if let headerProtocol = headerView as? UpdateDataProtocol {
            headerProtocol.update(rowData: header.viewData)
        }
        
        if headerView.frame == .zero {
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: header.viewHeight)
        }
        
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let section = self[section],
              let footer = section.footer else { return 0}
        return footer.viewHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let section = self[section],
              let footer = section.footer else { return nil }
        let footerView = tableView.dequeueReusableHeaderFooterView(viewType: footer.viewType)
        if let footerProtocol = footerView as? UpdateDataProtocol {
            footerProtocol.update(rowData: footer.viewData)
        }
        
        if footerView.frame == .zero {
            footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: footer.viewHeight)
        }
        
        return footerView
    }
    
    private func tableViewCell(_ tableView: UITableView, for indexPath: IndexPath, cellType: UITableViewCell.Type = UITableViewCell.self) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(cellType: cellType) else {
            let finalCell = cellType.init(style: .default, reuseIdentifier: cellType.identifier)
            return finalCell
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TableViewData: UITableViewDelegate {
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self[indexPath]?.rowHeight ?? 0
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let row = self[indexPath] else { return }
        if let protocolCell = cell as? UpdateDataProtocol {
            protocolCell.update(rowData: row.rowData)
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewDidSelectedClosure?(tableView, indexPath)
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


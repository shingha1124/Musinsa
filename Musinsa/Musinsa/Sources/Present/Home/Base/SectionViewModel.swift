//
//  SectionViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

protocol SectionViewModel {
    var header: HomeSectionHeaderViewModel? { get }
    var footer: HomeSectionFooterViewModel? { get }
    var type: Contents.`Type` { get }
    var count: Int { get }
}

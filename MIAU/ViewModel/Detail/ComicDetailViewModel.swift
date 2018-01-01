//
//  ComicDetailViewModel.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import Foundation


class ComicDetailViewModel: EntityDetailViewModel {
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter();
        dateFormatter.dateStyle = .medium;
        dateFormatter.timeStyle = .none;
        return dateFormatter;
    }();
    
    private lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter();
        formatter.numberStyle = .currency;
        formatter.locale = Locale(identifier: "en_US");
        return formatter;
    }();
    
    var imageURL: URL? {
        return (self.entity as? MarvelComic)?.imagePortraitURL;
    }
    
    var name: String {
        guard let name = (self.entity as? MarvelComic)?.title else { return ""; }
        
        return name;
    }
    
    var description: String {
        guard let description = (self.entity as? MarvelComic)?.description, !description.isEmpty else {
            return "No info available";
        }
        
        return description;
    }
    
    var isDetailHidden: Bool {
        return (self.entity as? MarvelComic)?.detailURL?.isEmpty ?? true;
    }
    
    var detailURL: String? {
        return (self.entity as? MarvelComic)?.detailURL;
    }
    
    var date: String {
        guard let date = (self.entity as? MarvelComic)?.date else { return ""; }
        return self.dateFormatter.string(from: date);
    }
    
    var isPriceHidden: Bool {
        return (self.entity as? MarvelComic)?.price == nil;
    }
    
    var price: String {
        guard let price = (self.entity as? MarvelComic)?.price else { return ""; }
        let number = NSNumber(value: price);
        return self.currencyFormatter.string(from: number) ?? "";
    }
    
    var isPagesHidden: Bool {
        guard let value = (self.entity as? MarvelComic)?.pageCount, value != 0 else { return true; }
        return false;
    }
    
    var pages: String {
        guard let value = (self.entity as? MarvelComic)?.pageCount, value != 0 else { return ""; }
        
        return "\(value) pages";
    }
}

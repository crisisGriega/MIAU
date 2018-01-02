//
//  StoryDetailViewModel.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import Foundation


class StoryDetailViewModel: EntityDetailViewModel {
    
    var type: String {
        guard let storyType: String = (self.entity as? MarvelStory)?.storyType?.rawValue else {
            return "";
        }
        
        return storyType;
    }
    
    var description: String? {
        return (self.entity as? MarvelStory)?.title;
    }
    
    var isOriginalIssueHidden: Bool {
        return (self.entity as? MarvelStory)?.originalIssue == nil;
    }
    
    var originalIssueTitle: String? {
        return (self.entity as? MarvelStory)?.originalIssue?.name;
    }
    
    var originalIssueURL: String? {
        return (self.entity as? MarvelStory)?.originalIssue?.resourceURI;
    }
}

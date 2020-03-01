//
//  CommentViewModel.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 1/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
protocol CommentViewModelDelegate {
    func didFinishFetchingComments(comments: [Comment] )
}
class CommentViewModel {
    
    var user :String!
  
    var comment :String!
   
    var time :String!

    var eventDataService : EventDataService = EventDataService()
    
    var commentVMDelegate:CommentViewModelDelegate?
    
    private let is_loading = Variable(false)
    var isLoading :Observable<Bool>{
        return is_loading.asObservable()
    }
    init(){}
    
    init(user :String,comment : String,date_time :String ) {
        self.user = user
        self.comment = comment
        self.time = date_time
        
    }
    
    
    
    func fetchAllComments(eventID :String){
        
        self.eventDataService.fetchAllCommentsBelongsToEvent(eventID:eventID) { comments in
            self.commentVMDelegate?.didFinishFetchingComments(comments: comments)
        }
    }
    
   
    
}

class CommentsListViewModel {
    
    var commentsListViewModel : [CommentListViewModel] = [CommentListViewModel]()
    var eventDataService : EventDataService = EventDataService()
    

    func populateComments(_comments : [Comment])  {
        self.commentsListViewModel = _comments.map(CommentListViewModel.init)
    }
    
    
}

class CommentListViewModel {
    
    var user :String!
    var comment :String!
    var datetime :String!
    init(cModel : Comment) {
        self.user = cModel.user
        self.comment = cModel.comment
        self.datetime = cModel.time
       
    }
    
    
}

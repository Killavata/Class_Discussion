//
//  StudentCell.h
//  Class_Discussion
//
//  Created by sseverov on 4/29/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;

@property (nonatomic, copy) void (^actionBlock)(void);

@end

//
//  StudentCell.m
//  Class_Discussion
//
//  Created by sseverov on 4/29/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "StudentCell.h"

@implementation StudentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showImage:(id)sender{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end

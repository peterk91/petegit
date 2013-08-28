//
//  LU_cell_labelCell.m
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_cell_labelCell.h"

@implementation LU_cell_labelCell

@synthesize imageView;
@synthesize label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

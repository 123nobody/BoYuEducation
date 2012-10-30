//
//  ZYTableViewCell.m
//  BoYuEducation
//
//  Created by Wei on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZYTableViewCell.h"

@implementation ZYTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithMenuIndex:(NSInteger)index
{
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZYCell"];
    if (self) {
        switch (index) {
            case 0:
            {
                ;
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

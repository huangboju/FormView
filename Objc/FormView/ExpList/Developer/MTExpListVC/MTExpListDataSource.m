//
//  MTExpListDataSource.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/22.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//


#import "MTExpListDataSource.h"

#import "MTExpListCell.h"
#import "MTExpStorage.h"

// MTExpListDataSource
@implementation MTExpListDataSource

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    MTExpListCellItem *item = [self modelAtIndexPath:indexPath];
    return item.expState == 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    MTExpListCellItem *item = [self modelAtIndexPath:indexPath];
    [self.form[indexPath.section] removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    [MTExpStorage.sharedInstance removeExpItem:item];
}

@end

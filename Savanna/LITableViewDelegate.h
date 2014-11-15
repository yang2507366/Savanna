//
//  LITableViewDelegate.h
//  Savanna
//
//  Created by yangzexin on 3/10/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"
#import "LIScrollViewDelegate.h"

@interface LITableViewDelegate : LIScrollViewDelegate <UITableViewDelegate>

@property(nonatomic, copy)NSString *willDisplayCell;
@property(nonatomic, copy)NSString *willDisplayHeaderView;
@property(nonatomic, copy)NSString *willDisplayFooterView;
@property(nonatomic, copy)NSString *didEndDisplayingCell;
@property(nonatomic, copy)NSString *didEndDisplayingHeaderView;
@property(nonatomic, copy)NSString *didEndDisplayingFooterView;
@property(nonatomic, copy)NSString *heightForRowAtIndexPath;
@property(nonatomic, copy)NSString *heightForHeaderInSection;
@property(nonatomic, copy)NSString *heightForFooterInSection;
@property(nonatomic, copy)NSString *viewForHeaderInSection;
@property(nonatomic, copy)NSString *viewForFooterInSection;
@property(nonatomic, copy)NSString *accessoryTypeForRowWithIndexPath;
@property(nonatomic, copy)NSString *accessoryButtonTappedForRowWithIndexPath;
@property(nonatomic, copy)NSString *shouldHighlightRowAtIndexPath;
@property(nonatomic, copy)NSString *didHighlightRowAtIndexPath;
@property(nonatomic, copy)NSString *didUnhighlightRowAtIndexPath;
@property(nonatomic, copy)NSString *willSelectRowAtIndexPath;
@property(nonatomic, copy)NSString *willDeselectRowAtIndexPath;
@property(nonatomic, copy)NSString *didSelectRowAtIndexPath;
@property(nonatomic, copy)NSString *didDeselectRowAtIndexPath;
@property(nonatomic, copy)NSString *editingStyleForRowAtIndexPath;
@property(nonatomic, copy)NSString *titleForDeleteConfirmationButtonForRowAtIndexPath;
@property(nonatomic, copy)NSString *shouldIndentWhileEditingRowAtIndexPath;
@property(nonatomic, copy)NSString *willBeginEditingRowAtIndexPath;
@property(nonatomic, copy)NSString *didEndEditingRowAtIndexPath;
@property(nonatomic, copy)NSString *targetIndexPathForMoveFromRowAtIndexPath;
@property(nonatomic, copy)NSString *indentationLevelForRowAtIndexPath;
@property(nonatomic, copy)NSString *shouldShowMenuForRowAtIndexPath;
@property(nonatomic, copy)NSString *canPerformAction;
@property(nonatomic, copy)NSString *performAction;

@end

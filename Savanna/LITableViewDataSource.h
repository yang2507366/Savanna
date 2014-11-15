//
//  LITableViewDataSource.h
//  Savanna
//
//  Created by yangzexin on 13-3-11.
//  Copyright (c) 2013年 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVLuaImplentatable.h"

@interface LITableViewDataSource : NSObject <SVLuaImplentatable>

@property(nonatomic, copy)NSString *numberOfRowsInSection;
@property(nonatomic, copy)NSString *cellForRowAtIndexPath;
@property(nonatomic, copy)NSString *numberOfSections;
@property(nonatomic, copy)NSString *titleForHeaderInSection;
@property(nonatomic, copy)NSString *titleForFooterInSection;
@property(nonatomic, copy)NSString *canEditRowAtIndexPath;
@property(nonatomic, copy)NSString *canMoveRowAtIndexPath;
@property(nonatomic, copy)NSString *sectionIndexTitles;
@property(nonatomic, copy)NSString *sectionForSectionIndexTitle;
@property(nonatomic, copy)NSString *commitEditingStyle;
@property(nonatomic, copy)NSString *moveRowAtIndexPath;

@end

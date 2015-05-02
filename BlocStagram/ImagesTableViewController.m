//
//  ImagesTableViewController.m
//  BlocStagram
//
//  Created by Coby West on 4/17/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ImagesTableViewController.h"
#import "BLCDatasource.h"
#import "BLCMedia.h"
#import "BLCUser.h"
#import "BLCComment.h"
#import "BLCMediaTableViewCell.h"

@interface ImagesTableViewController ()


@end

@implementation ImagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[BLCMediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
}

-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //customize init
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfItems];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    static NSInteger imageViewTag = 1234;
//    UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:imageViewTag];
//    
//    if(!imageView)
//    {
//        imageView = [[UIImageView alloc]init];
//        imageView.contentMode = UIViewContentModeScaleToFill;
//        
//        imageView.frame = cell.contentView.bounds;
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        
//        imageView.tag = imageViewTag;
//        [cell.contentView addSubview:imageView];
//    }
//    
//    BLCMedia *item = [self items][indexPath.row];
//    imageView.image = item.image;
    
    
    BLCMediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
    cell.mediaItem = [self items][indexPath.row];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLCMedia *item = [self items][indexPath.row];
    UIImage *image = item.image;
    CGFloat scaledHeight  = 300 +((CGRectGetWidth(self.view.frame) / image.size.width) * image.size.height);
    return scaledHeight;
}

- (NSInteger) numberOfItems
{
    NSInteger numberOfItems = [self items].count;
    return numberOfItems;
}


- (NSArray *) items
{
    return [BLCDatasource sharedInstace].mediaItems;
    //doesn't work, not sure why
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        /*
        NSInteger rowNumber = indexPath.row;
        [[BLCDatasource sharedInstace].mediaItems removeObjectAtIndex:rowNumber];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        */
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

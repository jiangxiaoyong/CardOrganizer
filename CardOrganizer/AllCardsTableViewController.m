//
//  AllCardsTableViewController.m
//  CardOrganizer
//
//  Created by Jiang on 2014-09-23.
//  Copyright (c) 2014 Jet&JXY. All rights reserved.
//

#import "AllCardsTableViewController.h"
#import "createNewCardViewController.h"
#import "CardInfoViewController.h"

@interface AllCardsTableViewController ()

@end

@implementation AllCardsTableViewController

//refresh table view
- (IBAction)refresh
{
    [self.refreshControl beginRefreshing];
    [self.refreshControl endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSMutableArray *)cardPath
{
    if (!_cardPath) {
        _cardPath = [[NSMutableArray alloc]init];
    }
    return _cardPath;
}

//reconstruct table when go back

-(void)setcardPath:(NSMutableArray *)cardPath
{
    _cardPath = cardPath;
    [self.tableView reloadData];
}

-(NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

-(void)setcards:(NSMutableArray *)cards
{
    _cards = cards;
}


//pass the array which store all file path about a new card, including text and image file path
- (IBAction)createNewCardDone:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[createNewCardViewController class]]) {
        createNewCardViewController *cncVC = (createNewCardViewController *)segue.sourceViewController;
        self.cardPath = cncVC.cardFilePathArray;
        if (self.cardPath) {
            NSLog(@"success added card");
            [self.cards addObject:self.cardPath];
            NSLog(@"cards # = %ld", [self.cards count]);
            
        }else{
            NSLog(@"Failed to added new card");
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.cards count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Card Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                            forIndexPath:indexPath];
    for (NSMutableArray *oneCardInfo in self.cardPath) {
        if (oneCardInfo) {
            
            NSString *cardTextPath = [oneCardInfo objectAtIndex:0];
            NSArray *data = [[NSArray alloc] initWithContentsOfFile:cardTextPath];
            cell.textLabel.text = [data objectAtIndex:0];
            cell.detailTextLabel.text = [data objectAtIndex:1];

        }
    }
    return cell;
}


- (void)prepareCardInfoViewController:(CardInfoViewController *)civc toDisplayCardInfo:(NSMutableArray *)cardInfo
{
    civc.cardPath = cardInfo;
    
    for (NSString *str in cardInfo) {
        if(str){
            NSLog(@"str = %@", str);
        }
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        // find out which row in which section we're seguing from
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            // found it ... are we doing the Display Photo segue?
            if ([segue.identifier isEqualToString:@"Display Card"]) {
                // yes ... is the destination an ImageViewController?
                if ([segue.destinationViewController isKindOfClass:[CardInfoViewController class]]) {
                    [self prepareCardInfoViewController:segue.destinationViewController
                                      toDisplayCardInfo:self.cards[indexPath.row]];
                }
            }
        }
    }
    
}


@end

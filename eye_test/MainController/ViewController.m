
//Define value
#define playTime 60
#define CollectionItemSpace 10
//#define level 20


#import "ViewController.h"
#import "CollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultViewConstraint;

@property (weak, nonatomic) IBOutlet UIView *startView;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIView *resultView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController
{
    CGFloat screenWidth;
    
    NSArray *arrItem,*arrTitle;
    NSInteger correntCollectionItem;
    NSInteger currentLevel;
    NSInteger CollectionItemWidth;
    NSInteger collectionItemCount;
    
    UIColor *incorrect;
    UIColor *correct;
    
    NSTimer *timer;
    NSInteger currentTime;
    BOOL pauseTimer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self updateScreenWidth];
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"reuseCell"];
    
    [_collectionView setContentInset:UIEdgeInsetsMake(CollectionItemSpace, CollectionItemSpace, CollectionItemSpace, CollectionItemSpace)];
    arrItem = @[@4,@9,@16,@25,@36,@49];
    arrTitle = @[@"A",@"B",@"C"];
}


-(void)updateLabel {
    if(!pauseTimer)
    {
        if (currentTime == 0) {
            [self endGame];
            [timer invalidate];
            
        } else {
            currentTime = currentTime - 1;
            _timeLabel.text = [NSString stringWithFormat:@"%ld",(long)currentTime];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateScreenWidth
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
}

- (IBAction)returnMenu:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Start Game View
- (IBAction)startGame:(id)sender
{
    [self resetAllSetting];
    [self startGame];
}

- (void)startGame
{
    
    _startViewConstraint.constant = 0;
    [self.view updateConstraints];
    _startViewConstraint.constant = -(screenWidth);
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:1.0f animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        currentTime = playTime;
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    }];
}

#pragma mark - Game View
- (IBAction)pause:(id)sender
{
    pauseTimer = (pauseTimer)?FALSE:TRUE;
    //should be start
}

- (void)endGame
{
    if(currentLevel >= arrTitle.count)
        //Max title
        _resultLabel.text = [NSString stringWithFormat:@"%@： %ld",[arrTitle objectAtIndex:arrTitle.count-1],(long)currentLevel];
    else
        //set title
        _resultLabel.text = [NSString stringWithFormat:@"%@： %ld",[arrTitle objectAtIndex:currentLevel - 1],(long)currentLevel];
    _resultViewConstraint.constant = 0;
    [self.view updateConstraints];
    _resultViewConstraint.constant = -screenWidth;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:1.0f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(currentLevel == 0)
        return 0;
    else if(currentLevel >= arrItem.count)
        return [[arrItem objectAtIndex:arrItem.count - 1] integerValue];
    else
        return [[arrItem objectAtIndex:currentLevel - 1] integerValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseCell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    if(correntCollectionItem == indexPath.row)
        [cell setcolors:correct];
    else
        [cell setcolors:incorrect];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(!pauseTimer)
    {
        if(correntCollectionItem == indexPath.row)
        {
            NSLog(@"Select TRUE");
            currentLevel+=1;
            _scoreLabel.text = [NSString stringWithFormat:@"Score： %ld",(long)currentLevel];
            [self generateColor];
            [collectionView reloadData];
        }
        else
            NSLog(@"Select FALSE");
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int count = (int)sqrt([_collectionView numberOfItemsInSection:0]);
    CollectionItemWidth = (screenWidth - CollectionItemSpace * (count+1))/count;
    
    return CGSizeMake(CollectionItemWidth, CollectionItemWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CollectionItemSpace;
}

#pragma mark - End Game View
- (IBAction)restart:(id)sender
{
    [self restartGame];
}

- (void)restartGame
{
    [self resetAllSetting];
    
    _resultViewConstraint.constant = -screenWidth;
    [self.view updateConstraints];
    _resultViewConstraint.constant = 0;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:1.0f animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        currentTime = playTime;
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    }];
}

- (void)resetAllSetting
{
    _timeLabel.text = [NSString stringWithFormat:@"%d",playTime];
    currentLevel = 1;
    _scoreLabel.text = [NSString stringWithFormat:@"Score： %ld",(long)currentLevel];
    [self generateColor];
    [_collectionView reloadData];
}

- (void)generateColor
{
    if(currentLevel >= arrItem.count)
        collectionItemCount = [[arrItem objectAtIndex:arrItem.count - 1] integerValue];
    else
        collectionItemCount = [[arrItem objectAtIndex:currentLevel - 1] integerValue];
    

    int r = 100 + arc4random() % 196;
    int g = 100 + arc4random() % 196;
    int b = 100 + arc4random() % 196;
    
    int minus;
    if(currentLevel <6)
        minus = 60;
    else if(currentLevel <11)
        minus = 45;
    else if(currentLevel <16)
        minus = 30;
    else if(currentLevel <21)
        minus = 15;
    else if(currentLevel <25)
        minus = 10;
    else
        minus = 5;
    
    if(minus - (int)currentLevel < 0)
        minus--;
    else
        minus = minus - (int)currentLevel;
        
    int correct_r = (r - minus < 0)?r + minus:r - minus;
    int correct_g = (g - minus < 0)?g + minus:g - minus;
    int correct_b = (b - minus < 0)?b + minus :b - minus;
    
    incorrect = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f];
    correct = [UIColor colorWithRed:correct_r/255.0f green:correct_g/255.0f blue:correct_b/255.0f alpha:1.0f];
    
    correntCollectionItem = arc4random() % collectionItemCount;
}

@end

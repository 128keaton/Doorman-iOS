//
// This Software (the "Software") is supplied to you by Openmind Networks
// Limited ("Openmind") your use, installation, modification or
// redistribution of this Software constitutes acceptance of this disclaimer.
// If you do not agree with the terms of this disclaimer, please do not use,
// install, modify or redistribute this Software.
//
// TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED ON AN
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER
// EXPRESS OR IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR
// CONDITIONS OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A
// PARTICULAR PURPOSE.
//
// Each user of the Software is solely responsible for determining the
// appropriateness of using and distributing the Software and assumes all
// risks associated with use of the Software, including but not limited to
// the risks and costs of Software errors, compliance with applicable laws,
// damage to or loss of data, programs or equipment, and unavailability or
// interruption of operations.
//
// TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW OPENMIND SHALL NOT
// HAVE ANY LIABILITY FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, WITHOUT LIMITATION,
// LOST PROFITS, LOSS OF BUSINESS, LOSS OF USE, OR LOSS OF DATA), HOWSOEVER
// CAUSED UNDER ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
// LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
// WAY OUT OF THE USE OR DISTRIBUTION OF THE SOFTWARE, EVEN IF ADVISED OF
// THE POSSIBILITY OF SUCH DAMAGES.
//

//
//  keyViewController.m
//  Doorman
//
//  Created by Ian Harris on 30/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import "keyViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@interface keyViewController ()
@property (nonatomic, retain) ABPeoplePickerNavigationController *addressBookController;

@end

@implementation keyViewController

@synthesize granterTextField, requesterTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    requesterTextField.delegate = self;
    granterTextField.delegate = self;
    // Do any additional setup after loading the view.
    
    UIToolbar* assignToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    assignToolbar.barStyle = UIBarStyleBlackTranslucent;
    assignToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Use Contact" style:UIBarButtonItemStyleDone target:self action:@selector(showAddressBook)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         
                           nil];
    [assignToolbar sizeToFit];
    

    
    for (UITextView *subview in self.view.subviews) {
        
        // Do what you want to do with the subview
        NSLog(@"%@", subview);
        
        // List the subviews of subview
        if([subview isKindOfClass:[UITextField class]]){
            subview.inputAccessoryView = assignToolbar;
        }
    }

    
}
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{

    
    CFTypeRef generalCFObject;
    generalCFObject = ABRecordCopyValue(person, kABPersonEmailProperty);

    NSString *email = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonEmailProperty);
    
    ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
    if(emails){
        email = (__bridge NSString *) ABMultiValueCopyValueAtIndex(emails,0);
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Use Email?"
                                          message:[NSString stringWithFormat:@"Would you like to assign email %@ to requester or keyholder field?", email]
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Keyholder", @"Cancel action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       for (UITextView *subview in self.view.subviews) {
                                           
                                           // Do what you want to do with the subview
                                           NSLog(@"%@", subview);
                                           
                                           // List the subviews of subview
                                           if([subview isKindOfClass:[UITextField class]]){
                                               if(subview.tag == 0){
                                                   subview.text = email;
                                                   
                                               }
                                           }
                                       }
                                       
                                       
                                       
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Requester", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   for (UITextView *subview in self.view.subviews) {
                                       
                                       // Do what you want to do with the subview
                                       NSLog(@"%@", subview);
                                       
                                       // List the subviews of subview
                                       if([subview isKindOfClass:[UITextField class]]){
                                           if(subview.tag == 1){
                                               subview.text = email;
                                               
                                           }
                                       }
                                   }
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
    [self presentViewController:alertController animated:YES completion:nil];

        
    }else{
        UIAlertController *oopsController = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"The selected contact doesn't have an email." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self presentViewController:_addressBookController animated:YES completion:nil];
        }];
        [oopsController addAction:okAction];
        [_addressBookController dismissViewControllerAnimated:YES completion:nil];
        [self presentViewController:oopsController animated:YES completion:nil];
    }
   

    
    
}
-(void)showAddressBook{
    _addressBookController = [ABPeoplePickerNavigationController new];
    
    [_addressBookController setPeoplePickerDelegate:self];
    [self presentViewController:_addressBookController animated:YES completion:nil];
}
-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    CFTypeRef generalCFObject;
    generalCFObject = ABRecordCopyValue(person, kABPersonEmailProperty);
    [defaults setObject:[(__bridge id _Nullable)(generalCFObject) stringValue] forKey:@"email"];
    [defaults synchronize];
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Use Email?"
                                          message:[NSString stringWithFormat:@"Would you like to assign email %@ to requester or keyholder field?", [(__bridge id _Nullable)(generalCFObject) stringValue]]
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Keyholder", @"Cancel action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       for (UITextView *subview in self.view.subviews) {
                                           
                                           // Do what you want to do with the subview
                                           NSLog(@"%@", subview);
                                           
                                           // List the subviews of subview
                                           if([subview isKindOfClass:[UITextField class]]){
                                               if(subview.tag == 0){
                                                   subview.text = [(__bridge id _Nullable)(generalCFObject) stringValue];
                                               }
                                           }
                                       }
                                       

                                       
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Requester", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   for (UITextView *subview in self.view.subviews) {
                                       
                                       // Do what you want to do with the subview
                                       NSLog(@"%@", subview);
                                       
                                       // List the subviews of subview
                                       if([subview isKindOfClass:[UITextField class]]){
                                           if(subview.tag == 1){
                                               subview.text = [(__bridge id _Nullable)(generalCFObject) stringValue];
                                           }
                                       }
                                   }
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    
    
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 160; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

// Hides Keyboard when return is pressed in a Textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)dismiss:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loadDestinationVC:(id)sender {
    // check the granter e-mail address
    NSString *granter = granterTextField.text;
    NSString *requester = requesterTextField.text;
    NSString *usernameKey = @"username_preference";
    NSString *granterKey = @"granter_preference";
    GolgiWrapper *golgiWrapper;
    NSLog(@"Next button pushed");
    // check that they are both set
    if([granter isEqualToString:@""] || [requester isEqualToString:@""]){
        // don't proceed need more info
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Missing information"
                                                          message:@"Please complete all fields"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        NSArray *subviews = [self.view subviews];
        
        // Return if there are no subviews
        if ([subviews count] == 0) return; // COUNT CHECK LINE
        
        for (UITextView *subview in subviews) {
            
            // Do what you want to do with the subview
            NSLog(@"%@", subview);
            
            // List the subviews of subview
            if([subview isKindOfClass:[UITextField class]]){
                if ([(UITextField*)subview.text  isEqual: @""]) {
                    subview.layer.cornerRadius=8.0f;
                    subview.layer.masksToBounds=YES;
                    subview.layer.borderColor=[[UIColor redColor]CGColor];
                    subview.layer.borderWidth= 1.0f;
                }
            }
        }
        
        return;
    }else{
        NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
        [preferences setObject:requester forKey:usernameKey];
        [preferences setObject:granter forKey:granterKey];
        [preferences synchronize];
        NSLog(@"Attempting to allocate golgiWrapper");
        golgiWrapper = [[GolgiWrapper alloc] init];
        NSLog(@"Allocated golgiWrapper");
    }
    
    // check if this is a staff request
    if([granter isEqualToString:@"pastor@hh-umc.org"]){
        [self performSegueWithIdentifier:@"StaffSegue" sender:nil];
    }
    else{
        [self performSegueWithIdentifier:@"VisitorSegue" sender:nil];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

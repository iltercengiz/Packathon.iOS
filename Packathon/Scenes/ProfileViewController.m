//
//  ProfileViewController.m
//  Packathon
//
//  Created by Ilter Cengiz on 23/01/2016.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIView *authenticationView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIView *userView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic) User *user;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.authenticationView.hidden = [RemoteProcedureProxy sharedInstance].isLoggedIn;
    self.userView.hidden = ![RemoteProcedureProxy sharedInstance].isLoggedIn;
    
    self.user = [RemoteProcedureProxy sharedInstance].user;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark - Setter

- (void)setUser:(User *)user {
    _user = user;
    if (user) {
        self.usernameLabel.text = user.username;
        self.nameLabel.text = user.name;
    }
}

#pragma mark - IBAction

- (IBAction)didTapDoneBarButton:(id)sender {
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapLoginButton:(id)sender {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    self.loginButton.hidden = YES;
    [self.activityIndicator startAnimating];
    [[RemoteProcedureProxy sharedInstance] loginWithUsername:self.usernameTextField.text password:self.passwordTextField.text completion:^(NSError *error) {
        if (!error) {
            [[RemoteProcedureProxy sharedInstance] userWithCompletion:^(User *user, NSError *error) {
                if (!error) {
                    self.user = user;
                    self.userView.hidden = NO;
                    self.authenticationView.hidden = YES;
                } else {
                    [self alertLoginError:error];
                }
                [self.activityIndicator stopAnimating];
                self.loginButton.hidden = NO;
            }];
        } else {
            [self alertLoginError:error];
            [self.activityIndicator stopAnimating];
            self.loginButton.hidden = NO;
        }
    }];
}

- (IBAction)didTapLogoutButton:(id)sender {
    [[RemoteProcedureProxy sharedInstance] logout];
    self.usernameLabel.text = nil;
    self.nameLabel.text = nil;
    self.userView.hidden = YES;
    self.authenticationView.hidden = NO;
}

- (IBAction)usernameTextFieldDidReturn:(id)sender {
    [self.passwordTextField becomeFirstResponder];
}

- (IBAction)passwordTextFieldDidReturn:(id)sender {
    [self.passwordTextField resignFirstResponder];
    [self didTapLoginButton:self.loginButton];
}

#pragma mark - Private method

- (void)alertLoginError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Network error", @"")
                                                                   message:error.localizedDescription ?: NSLocalizedString(@"Failed to login", @"")
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Dismiss", @"") style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:dismissAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end

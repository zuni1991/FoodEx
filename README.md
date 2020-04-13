Group Project - README Template
===

# FOODEX

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Have you ever had too much food in your house that is about to spoil? Have you
ever over bought groceries without noticing? You don’t know what to do with that
extra food? FoodEx is your solution. FoodEx is a community of giving away food
and not wasting it. In the US, 30-40% of food supply in the household is being
wasted. FoodEx is here to try to reduce the percentage of food being wasted.

### App Evaluation
- **Category:** Food
- **Mobile:** App
- **Story:** People may be hungry and/or in need of food. Other people may have extra food and willing to share. 
- **Market:** Young adults to Elderly
- **Habit:** People who would like free food. 
- **Scope:** Around town. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* To create this app we will use Xcode, and Apple Maps API, and we will create a
MySQL database to store all the contents such as profile, and food. We will have a
tab bar in the bottom of the screen that will give the option of screens. It will have the
food, add, and the user screen. In the food screen it will show the timeline of food
being given out and in the top corner it will have a map button that when clicked it
will show the map with pin points of the location where the food is located. The
second screen will have the option to add the picture of food to the timeline. The third
screen will be the user profile with its information. 

**Optional Nice-to-have Stories**

* Since we don’t want our user to be scammed we would like to make a rating system to know how truthworthy is the person.

### 2. Screen Archetypes

* Sign In/Log In Screen
   * Two text fields, for username and password
   * Two buttons, one to log in and the other to sign up
* Feed page, if user entered correct credentials and clicked log in. 
   * Cell Table showing recent posts of food. 
   * Log out button
   * Map button
   * Three button tab navigation bar at the bottom.
* Sign up page, if user clicked on sign up button
   * Two labels, for username and password
   * One buttons to sign up
* Map button will open up a map page
   * map
   * back button

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* The first tab is the the feed tab, which will display the most recent posts. 
* The second tab allows the user to add/create a post to display on the feed tab
* The third tab allows the user to see their profil and update their information. 

**Flow Navigation** (Screen to Screen)

* Posts Tab
   * User can scroll down to see up to twenty recent posts
   * User can see posts and touch one to see more information
* Add Post Tab
   * User uploads a picture. 
   * User enters information about post/food/picture.
   * User sends post to appear on feed. 
* Profile Tab
   * User can see their information.
   * User can edit their information.

## Wireframes
<img src="https://i.ibb.co/WVv60xK/IMG-3814.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models
#### Post
   | Property      | Type            | Description                                         | 
   | ------------- | --------------  | --------------------------------------------------- |
   | objectId      | String          | unique id for the user post (default field)         |
   | author        | Pointer to User | image author                                        |
   | image         | File            | image that user posts                               |
   | caption       | String          | image caption by author                             |
   | location      | String          | location that the user posts
   | createdAt     | DateTime        | date when post is created (default field)           |


### Networking
#### List of network requests by screen
   - Login Screen
       ```swift
          @IBAction func onSignIn(_ sender: Any) {
            let username = usernameField.text!
            let password = passwordField.text!

            PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
              if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
              } else {
                print("Error: \(error?.localizedDescription)")
              }
            }
          }
       ```
       
   - Sign Up Screen 
      ```swift
        @IBAction func onSignup(_ sender: Any) {
          let user = PFUser()
          user.username = usernameField.text
          user.password = passwordField.text
          user.email = emailField.text

          user.signUpInBackground { (success, error) in
            if success {
              self.performSegue(withIdentifier: "signupSegue", sender: nil)
            } else {
              print("Error: \(error?.localizedDescription)")
            }
          }
        }
      ```

### Existing API Endpoints
##### Apple Maps
- Base URL - [https://developer.apple.com/maps/](https://developer.apple.com/maps/)

## GIF Walkthrough
Here's a walkthrough of implemented user stories:<br>
<img src='http://g.recordit.co/LnV4WpW7tr.gif' title='GIF Walkthrough' width='' alt='GIF Walkthrough' />

### Other
-  parse-dashboard --appId Foodx --masterKey myMasterKey --serverURL "https://foodxx.herokuapp.com/parse"










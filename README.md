# Stay in touch app with Ruby on Rails

This milestone 5 presents the Friendships functionality for a social media application.

<!--
*** Thanks for checking out this README Template. If you have a suggestion that would
*** make this better, please fork the repo and create a pull request or simply open
*** an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
-->

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/ericmbouwe/Stay-in-touch">
    <img src="app/assets/images/microverse.png" alt="Microverse Logo" width="80" height="80">
  </a>
  
  <h3 align="center">Stay In Touch Application</h3>
  
  <p align="center">
    This project is part of the Microverse curriculum in Ruby On Rails course!
    <br />
    <a href="https://github.com/ericmbouwe/Stay-in-touch"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/ericmbouwe/Stay-in-touch/issues">Report Bug</a>
    <a href="https://github.com/ericmbouwe/Stay-in-touch/issues">Request Feature</a>
  </p>
</p>

Stay in touch allows users to create posts and invite other users for friendship.  
Invited user can accept or reject invitations.  
Logged in users can see and comment posts created by their selves or by their friends.  

<hr />

## Application Screen Shots

## Log In

<img src="app/assets/images/sign-in.png" alt="program interface">
<hr />

## Users List

<img src="app/assets/images/users-index.png" alt="program interface">
<hr />

## User show

<img src="app/assets/images/user-show.png" alt="program interface">
<hr />

## Timeline

<img src="app/assets/images/timeline.png" alt="program interface">
<hr />

<!-- TABLE OF CONTENTS -->

## Table of Contents

- [About the Project](#about-the-project)
- [Application Instructions](#application-instructions)
- [System Requierments](#system-requierments)
- [Dependencies](#dependencies)
- [Configuration](#configuration)
- [Development](#development)
- [Testing](#testing)
- [Built With](#built-with)
- [Contributors](#contributors)
- [Acknowledgements](#acknowledgements)

<!-- ABOUT THE PROJECT -->

## About The Project

The project creates a database which holds 5 tables:

    - Users : Is the table containing the users' data  
      - Fields :  
        - string:   name  
        - datetime: created_at  
        - datetime: update_at  

    - Posts : is the table containing the posts' data  
      - Fields:  
        - text:     content  
        - integer:  user_id  
        - datetime: created_at  
        - datetime: update_at  

    - Comments : Is the table that contains the comments created about posts  
      - Fields  
        - text:     content  
        - integer:  post_id  
        - integer:  user_id  
        - datetime: created_at  
        - datetime: update_at  

    - Friendships : Is the table that connects users for a friendship  
      - Fields  
        - integer: user_id  
        - integer: friend_id  
        - integer: status  
      * The user_id is the id of the user who invites the user with friend_id as an id  
      * The status field denotes  
        -  0 initially for pending  
        -  1 for an acceptance by the friend_id user  
        - -1 for a rejection by the friend_id user  

    - Likes : Is the table that contains the users' likes on the Posts  
      - Fields  
        - integer: post_id  
        - integer: user_id  

<hr/>

<!-- ABOUT THE PROJECT -->

## Application Instructions

- New users must sign up and give a name, an email and a password  
- Using their email and password they can log in  
- A logged in user can create posts and invite other users for friendship  
- Invitations can be accepted or rejected by the user who is invited  
- The Timeline shows Posts created by the user or their friends  

<hr/>

## System Requierments

- Ruby
- Rails
- Yarn
- RSpec

## Dependencies

- rspec-rails gem
- capybara gem
- selenium-webdriver gem
- chromedriver-helper gem

## Configuration

- first, clone the project
  Run

```
  git clone https://github.com/ericmbouwe/Stay-in-touch.git
```

- Install the necessary dependancies
  Run

```
  bundle install
  rails generate rspec:install
  yarn install
```

<hr/>

## Development

- Clone the project

```
  https://github.com/ericmbouwe/Stay-in-touch.git
```

<hr/>

## Testing

- Tests have been included using RSpec for controllers, views and models
- Location /spec/
- 5 test files
  - comments_spec.rb  
  - friendships_spec.rb  
  - menu_spec.rb  
  - posts_spec.rb  
  - users_spec.rb    

### Controller test files implement the views tests as well.

<hr/>

## Built With

This project was built using these technologies.

- Ruby version 2.6
- Ruby On Rails version 6.0
- rspec
- capybara

<hr/>

<!-- CONTACT -->

## Contributors

:bust_in_silhouette: **Author_1**

## Eric Mbouwe

- Github: [@ericmbouwe](https://github.com/ericmbouwe)
- Twitter: [@ericmbouwe](https://twitter.com/ericmbouwe)
- Linkedin: [Eric Mbouwe](https://www.linkedin.com/in/ericmbouwe/)
- E-mail: ericmbouwe@gmail.com

:bust_in_silhouette: **Author_2**

## Ioannis Kousis

- Github: [@ioanniskousis](https://github.com/ioanniskousis)
- Twitter: [@ioanniskousis](https://twitter.com/ioanniskousis)
- Linkedin: [Ioannis Kousis](https://www.linkedin.com/in/jgkousis)
- E-mail: jgkousis@gmail.com


<hr/>
<!-- ACKNOWLEDGEMENTS -->

## Acknowledgements

- [Microverse](https://www.microverse.org/)
- [The Odin Project](https://www.theodinproject.com/)
- [Ruby Documentation](https://www.ruby-lang.org/en/documentation/)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/ericmbouwe/Stay-in-touch.svg?style=flat-square
[contributors-url]: https://github.com/ericmbouwe/Stay-in-touch/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/ericmbouwe/Stay-in-touch.svg?style=flat-square
[forks-url]: https://github.com/ericmbouwe/Stay-in-touch/network/members
[stars-shield]: https://img.shields.io/github/stars/ericmbouwe/Stay-in-touch.svg?style=flat-square
[stars-url]: https://github.com/ericmbouwe/Stay-in-touch/stargazers
[issues-shield]: https://img.shields.io/github/issues/ericmbouwe/Stay-in-touch.svg?style=flat-square
[issues-url]: https://github.com/ericmbouwe/Stay-in-touch/issues

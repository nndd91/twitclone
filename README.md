# README

## AC Project Sample

This is an app for us to practice on our ruby on rails skill. We are creating a twitter clone that contains all the features as describe by the following user stories:

### Project Timeline

**Week 1**

* As a user, I can view a homepage with a list of latest tweets
* As a user, I can create an account
* As a user, I can log in to and log out of my account
* As a user, I can delete my account
* As a user, I can edit my own profile
* As a user, I can post a tweet (that is not more than 140 characters)
* As a user, I can delete a tweet
* As a user, I can visit another user's profile (including my own) to view all of their tweets
* As a user, I can navigate around on a navbar, links : Home, Notification and Messages
* Beautify Homepage
* Beautify Profile

**Week 2**

* As a user, I can 'like' a tweet
* As a user, I can reply to other tweets
* As a user, I can upload photo with a tweet
* As a user, I can search for another user 
* As an admin, I can edit/delete user
* As an admin, I can view a list of user
* As an admin, I can delete all tweet
* As an admin, I can view a list of active users (last login < 7 days)
* Beautify Admin
* Beautify Message

**Week 3**

* As a user, I will receive a notification when another user interacts with one of my tweets
* As a user, I can follow and unfollow other users
* As a user, I can view tweets posted by the users I am following, on my dashboard
* As a user, I can private message another user
* As a user, I can set background/theme
* As a user, I can make my account private or public
* As a user, I can tag my tweets
* As a user, I can mentioned another user in my tweet
* As a user, I can share my tweet
* As a user, I can view a list of messages

## Getting Started

1. Get the code base

```bash
git clone https://github.com/nndd91/twitclone.git
```

2. Install Gem Dependencies

```bash
cd twitclone
bundle install
```

3. Setup Database

```bash
rake db:create db:migrate
```

4. Start the application

```bash
# Start the web server
rails s
```

## Branch Policy

We follow the [Github Flow](https://guides.github.com/introduction/flow) when developing the application, and name our branches as follow:

- `master` is the active development branch

Local development branch naming

- `feature/<your-branch-name>`  for substantial new feature or function
- `enhance/<your-branch-name>` for minor feature or function enhancement
- `bugfix/<your-branch-name>` for bug fixes

## Testing

We use [Rspec](https://github.com/rspec/rspec-rails) as our testing framework. So, during development, run these regularly.

```bash
# Run the specs
rspec
```

## Deployment

We deploy our application directly to heroku. Automatic deployment has been setup for our production environment as documented [here](https://devcenter.heroku.com/articles/github-integration#automatic-deploys). To manually deploy to heroku with Git, you need to:

1. Register a heroku account and request access to production app
2. Install [heroku toolbelt](https://toolbelt.heroku.com/) which is a CLI tool for creating and managing Heroku apps
3. Setup Heroku remote

```bash
# Setup heroku remote for production
git remote add heroku https://git.heroku.com/ac-project-sample.git
```

## ERD

![ERD Diagram](https://github.com/nndd91/twitclone/blob/master/ERD.png?raw=true "Logo Title Text 1")

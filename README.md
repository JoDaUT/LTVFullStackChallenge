# NOTE: YOU HAVE TO RUN THESE STEPS BECAUSE I ADDED CHANGES TO GENERATE MIGRATIONS.

# Intial Setup

    docker-compose build
    docker-compose up mariadb
    # Once mariadb says it's ready for connections, you can use ctrl + c to stop it
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml build

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc

# Solution

## Git conventions
I've been using a variation from Conventional Commit Convention
https://www.conventionalcommits.org/en/v1.0.0/

Structure:
type(branch):descriptive message
Ex. feat(dev):short url redirection


# Git branches
For simplicity I'm only using two branches, dev and main.

# Resources
I found these implementations. I liked because they contemplate the maximum number of characters required to represent an enough amount of URLs.

[How to design a tiny URL or URL shortener? - GeeksforGeeks](https://www.geeksforgeeks.org/how-to-design-a-tiny-url-or-url-shortener/)

[Designing URL Shortening Service like TinyURL - enjoy algorithms](https://www.enjoyalgorithms.com/blog/design-a-url-shortening-service-like-tiny-url)

[Create a URL shortener with Ruby on Rails - zauberware - SIMON FRANZEN](https://www.zauberware.com/en/articles/2019/create-a-url-shortener-with-ruby-on-rails)

Here is a little explanation of the solution:

1. A lower case alphabet [‘a’ to ‘z’], total 26 characters 
2. An upper case alphabet [‘A’ to ‘Z’], total 26 characters 
3. A digit [‘0’ to ‘9’], total 10 characters
There are total 26 + 26 + 10 = 62 possible characters.
Thus, its a good idea to use base 62 encoding. I used [base62-rb](https://github.com/steventen/base62-rb) because it is very simple to use.

## Problems of this solution
- It has a pattern in the short URL codes generation. It would be better to add a little randomness to hide this pattern.
- It depends on the row ID, instead of the full URL, to generate the short code.

## Problems encountered solving the challenge
I had a problem the first day, starting the project. The main container exited with error 1, and I didn't know why. I took me a day to find the solution. Sometimes, rails generates garbage when stops abruptly. The solution was to delete the tem/server.pid file.
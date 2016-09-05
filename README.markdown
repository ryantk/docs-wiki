# docs-wiki

[![Build Status](https://semaphoreci.com/api/v1/ryantk/docs-wiki/branches/master/badge.svg)](https://semaphoreci.com/ryantk/docs-wiki)

### Installation

#### Install Postgres

Use homebrew to install Postgres

    $ brew install postgresql

Start the database service

    $ brew services start postgresql

#### Install the app

    $ git clone https://github.com/ryantk/docs-wiki.git && cd docs-wiki
    $ bundle install
    $ rails db:create
    $ rails db:migrate

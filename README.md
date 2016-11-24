# README

* note about how is structured in git this application  
  The following branch are created:  
  01-behaviour-scenarios  
    bin/cucumber will failed in the 1fst scenario but green in the 2 others  
  02-add-button-apocalypse-and-coffee  
    bin/cucumber will failed in the three scenarios  
  03-route_to_delete  
    bin/cucumber will failed in the 3 scenarios  
    bin/rspec pass the routing test  
  04-controller-delete  
    bin/rspec will pass the request spec  
    bin/cucumber will pass in the first scenario but fail in the other 2  
  05-filter-in-view  
    all green  

  you can pass to one branch to another with:
  <pre>
    git checkout <branch>
  </pre>

* note about configuration

* * Gemfile
    <pre>
      group :development, :test do
        # Call 'byebug' anywhere in the code to stop execution and get a debugger console
        gem 'byebug', platform: :mri
        # we need these 2 gems in dev too for the generators
        gem "rspec-rails", require: false
        gem "cucumber-rails", require: false
      end
    </pre>
    <pre>
      group :development do
        # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
        gem 'spring'
        gem 'spring-watcher-listen', '~> 2.0.0'
        # these two are for launching the test quicker
        gem "spring-commands-rspec"
        gem "spring-commands-cucumber"
      end
    </pre>
    <pre>
      group :test do
        gem "database_cleaner", require: false
        gem "factory_girl_rails", require: false
        # for behaviour with cucumber
        gem "capybara", require: false
        gem "poltergeist", require: false
        gem "launchy", require: false
      end
    </pre>
* * preparation for factory girl

    In config/environment/test.rb

    <pre>
      config.gem 'factory_girl'
    </pre>

* * preparation for rspec

    We will use rspec only for testing code, so we need to add to the stack only factory girls.

    <pre>
      rails generate rspec:install
    </pre>

    This generates (among other stuff) the spec/rails_helper.rb. We add :

    <pre>
      require 'factory_girl_rails'
    </pre>

    And for using factory girls in the block RSpec.configure :

    <pre>
      config.fixture_path = "#{::Rails.root}/spec/factories"
      config.include FactoryGirl::Syntax::Methods
    </pre>

    We add in spec/support/warden.rb to have access to the warden test helpers and in spec/rails_helper.rb
    <pre>
      require 'support/warden'
    </pre>

* * preparation for cucumber

   <pre>
     rails generate cucumber:install
   </pre>

   Cucumber has then to be configured to test with javascript.  
   We use capybara, poltergeist/phantomjs (poltergeist is the client and phantomjs is the server).  
   We have installed phantomjs with 'npm install phantomjs' but there are other choices; a good one is the gem [phantomjs](https://github.com/colszowka/phantomjs-gem).  
   **NB**: in config/environments/test.rb we type 'config.assets.compile = true' for phantomjs because our javascript is in assets (as a coffeescript).  
   In features/support/env.rb
   <pre>
     require "capybara/poltergeist"
 
     require 'factory_girl_rails'
 
     Capybara.register_driver :poltergeist do |app|
       Capybara::Poltergeist::Driver.new(app,
         :debug       => false,
         :window_size => [1680, 1050],
         :timeout     => 120,
       )
     end
 
     Capybara.current_driver    = :poltergeist
     Capybara.javascript_driver = :poltergeist
   </pre>

   In order to have a quicker login process, we cheat with [warden](https://github.com/hassox/warden/wiki/Testing). It gives us access to methods 'login_as' and 'logout'.
   In features/support/warden.rb

   <pre>
     Warden.test_mode!
     World Warden::Test::Helpers
     After { Warden.test_reset! }
   </pre>

* pre-commit for git

  These indications come from [tips-for-using-a-git-pre-commit-hook](http://codeinthehole.com/writing/tips-for-using-a-git-pre-commit-hook/).

  When we run a commit, this script will be run to get the assurance that our commit is 'clean'.
  We verify if there is no string forgotten or space at the end of line (except the 'md' files) and our test suites run softly.  
  We could run the suites test there but with bdd/tdd discipline is not usefull.

  This script lays in the 'script' directory of our application.  
  In order to install it, we have to run (on the root of our application):
  <pre>
  chmod 755 script/pre-commit.sh
  ln -s ../../script/pre-commit.sh .git/hooks/pre-commit
  </pre>
  NB: symlinks are resolved by git as relative

  In the case we don't want the pre-hook to be trigger, we have to run our commit with the option '--no-verify':
  <pre>
  git commit --no-verify <files>
  </pre>



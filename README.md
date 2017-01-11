# MyVagrantPlugin

A step by step walkthrough to understanding how to create a plugin for Vagrant

## Create project skeleton with bundler

    $ bundle gem my_vagrant_plugin
    $ cd my_vagrant_plugin
    $ git add .
    $ git commit -m "Create initial commit"

## Update Gemspec so you can run "bundle"

    # this fails
    $ bundle
    You have one or more invalid gemspecs that need to be fixed.
    The gemspec at </path/of/my_vagrant_plugin.gemspec> is not valid. Please fix this gemspec.
    The validation error was '"FIXME" or "TODO" is not an author'

    # after updating gemspec, this works
    $ bundle
    Fetching gem metadata from https://rubygems.org/..........
    Fetching version metadata from https://rubygems.org/.
    Resolving dependencies...
    Using rake 10.5.0
    Using bundler 1.13.6
    Using diff-lcs 1.2.5
    Using my_vagrant_plugin 0.1.0 from source at `.`
    Using rspec-support 3.5.0
    Using rspec-core 3.5.4
    Using rspec-expectations 3.5.0
    Using rspec-mocks 3.5.0
    Using rspec 3.5.0
    Bundle complete! 4 Gemfile dependencies, 9 gems now installed.
    Use `bundle show [gemname]` to see where a bundled gem is installed.

## Update Gemfile w/ Vagrant-specifc format

    # Gemfile
    source "https://rubygems.org"

    group :development do
      gem "vagrant", git: "https://github.com/mitchellh/vagrant.git"
    end

    group :plugins do
      gem "my_vagrant_plugin", path: "."
    end

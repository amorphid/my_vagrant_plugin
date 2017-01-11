# MyVagrantPlugin

A step by step walkthrough to understanding how to create a plugin for Vagrant

## WARNING

* This walkthrough may corrupt your Vagrant install (I accidentally nuked mine)
* You'll be installing the [development gem on GitHub](I accidentally nuked mine), as mentioned in the [Vagrant plugin docs](https://www.vagrantup.com/docs/plugins/development-basics.html)
* The development gem installs a vagrant executable, which blows away the executable created by the standard vagrant installer
* You may also encounter conflicts with the vagrant data cached in `$HOME/.vagrant.d/`
* For your development pleasure, I recommend developing your plugin in a Vagrant-less VM

## Create project skeleton with bundler

    $ bundle gem my_vagrant_plugin --test=rspec
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

## Move development dependencies to Gemfile

    # remove from Gemspec
    spec.add_development_dependency "bundler", "~> 1.13"
    spec.add_development_dependency "rake", "~> 10.0"
    spec.add_development_dependency "rspec", "~> 3.0"

    # add to ':plugins' group in Gemfile
    group :plugins do
      # existing plugins
      gem "my_vagrant_plugin", path: "."

      # new plugins
      gem "bundler", "~> 1.13"
      gem "rake", "~> 10.0"
      gem "rspec", "~> 3.0"
    end

## Verify Rspec working properly (and delete failing test)

    # run tests
    $ bundle exec rspec
    MyVagrantPlugin
      has a version number
      does something useful (FAILED - 1)

    Failures:

      1) MyVagrantPlugin does something useful
         Failure/Error: expect(false).to eq(true)

           expected: true
                got: false

           (compared using ==)
         # ./spec/my_vagrant_plugin_spec.rb:9:in \`block (2 levels) in <top (required)>'

    Finished in 0.01383 seconds (files took 0.08105 seconds to load)
    2 examples, 1 failure

    Failed examples:

    rspec ./spec/my_vagrant_plugin_spec.rb:8 # MyVagrantPlugin does something useful

    # spec/my_vagrant_plugin_spec.rb (after deleting failing test)
    require "spec_helper"

    describe MyVagrantPlugin do
      it "has a version number" do
        expect(MyVagrantPlugin::VERSION).not_to be nil
      end
    end

## Move gem version into Gemspec

The default method for setting the gem version is not compatible with Vagrant conventions, and will create problems later when we call `Vagrant.plugin("2")`.

* Delete `lib/my_vagrant_plugin/version.rb`
* From `lib/my_vagrant_plugin.rb`, remove `require "my_vagrant_plugin/version"`
* From `my_vagrant_plugin.gemspec`, remove `require "my_vagrant_plugin/version"`
* From `spec/spec_helper.rb`, remote `"has a version number"` test
* Change version in `my_vagrant_plugin.gemspec`

    # Change from this
    spec.version       = MyVagrantPlugin::VERSION

    # To this
    spec.version       = "0.1.0"

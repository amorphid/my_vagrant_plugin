require "vagrant"

class MyVagrantPlugin < Vagrant.plugin("2")
  name "My Vagrant Plugin"

  command "declare-self-potato" do
    require "my_vagrant_plugin/declare_self_potato"
    MyVagrantPlugin::DeclareSelfPotato
  end
end

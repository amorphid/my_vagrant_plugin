class MyVagrantPlugin
  class DeclareSelfPotato < Vagrant.plugin("2", :command)
    class << self
      def synopsis
        "Declares self a potato"
      end
    end
  end
end

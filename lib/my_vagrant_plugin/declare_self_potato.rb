class MyVagrantPlugin
  class DeclareSelfPotato < Vagrant.plugin("2", :command)
    include Vagrant::Util::SafePuts

    def execute
      safe_puts("I am a proper potato")
      0
    end

    class << self
      def synopsis
        "Declares self a potato"
      end
    end
  end
end

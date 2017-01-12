class MyVagrantPlugin
  class DeclareSelfPotato < Vagrant.plugin("2", :command)
    def execute
      # you don't wanna use puts, which we'll explore in next section
      puts "Because I used 'puts', I am a naughty potato"

      # exit code 1 (cuz puts bad in vagrant command)
      1
    end

    class << self
      def synopsis
        "Declares self a potato"
      end
    end
  end
end

require 'fable_js/patches'
require 'fable_js/options'


module FableJS::Exec

    class Program

        def initialize(args)
            @options = FableJS::Options.new
            @options.parse! args
        end


        def run
            FableJS.show_version if @options.verbose?
        end

    end

end
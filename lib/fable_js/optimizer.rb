require 'fable_js/lexer'


class FableJS::Optimizer

    def initialize(file, output, opts)
        @file       = file
        @output     = output
        @options    = opts
    end


    def run
        source = IO.read @file, 'r'
        lexer = FableJS::Lexer.new source
    end

end

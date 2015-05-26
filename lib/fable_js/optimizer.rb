class FableJS::Optimizer

    def initialize(file, output, opts)
        @file       = file
        @output     = output
        @options    = opts
    end


    def run
        @output.puts "// #{@file}"
    end

end
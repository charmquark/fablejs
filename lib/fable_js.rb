require 'fable_js/patches'


module FableJS

    NAME           = 'FableJS'
    VERSION        = [0, 0, 15]
    VERSION_SUFFIX = 'alpha'


    @@version_str   = nil


    def self.optimize_files(files, outparam, options)
        output = param_to_output outparam
        files.each do |f|
            optimizer = Optimizer.new f, output, options
            optimizer.run
        end
    end


    def self.show_version
        print NAME, ' ', version_str, "\n"
    end


    def self.version_str
        if @@version_str.nil? then
            @@version_str = VERSION.join '.'
            unless VERSION_SUFFIX.nil? then
                @@version_str += '-'
                @@version_str += VERSION_SUFFIX
            end
        end
        @@version_str
    end


    private


    def self.param_to_output(param)
        if param.nil? then
            $stdout
        elsif param.is_a? String
            f = File.new param, 'w'
            f.autoclose = true
            f
        elsif param.is_a? IO
            param
        else
            raise ArgumentError, "Invalid output parameter"
        end
    end

end


%w(optimizer verbosity).each {|lib| require "fable_js/#{lib}" }
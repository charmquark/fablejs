module FableJS


    NAME           = 'FableJS'
    VERSION        = [0, 0, 1]
    VERSION_TAG    = [:alpha, 10]


    @@version_str = nil


    def self.show_version
        puts "#{NAME} #{version_str}"
    end


    def self.version_str
        if @@version_str.nil? then
            @@version_str = FableJS::VERSION.join '.'
            unless FableJS::VERSION_TAG.empty? then
                @@version_str += '-'
                @@version_str += FableJS::VERSION_TAG.join '-'
            end
        end
        @@version_str
    end


end
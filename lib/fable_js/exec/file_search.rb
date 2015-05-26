module FableJS::Exec::FileSearch

    def self.search(options)
        ambiguous = []
        found     = []
        missing   = []
        options.files.each do |f|
            result = options.dirs.map {|d| File.alt_join d, f } .keep_if {|path| File.exist? path }
            if result.empty? then
                missing << f
            elsif result.length == 1 then
                found << result.first
            else
                ambiguous << [f, result]
            end
        end
        exit false if show_ambiguous(ambiguous) or show_missing(missing)
        show_found found
        found
    end


    def self.show_ambiguous(ambiguous)
        unless ambiguous.empty? then
            FableJS::Verbosity.quietly do
                puts "The following filenames were ambiguous:"
                ambiguous.each do |entry|
                    f, paths = entry
                    puts "    #{f}:"
                    paths.each {|p| puts "        #{p}" }
                end
            end
            return true
        end
        false
    end


    def self.show_found(found)
        unless found.empty? then
            FableJS::Verbosity.verbosely do
                puts "Found these files:"
                found.each {|path| puts "    #{path}" }
            end
        end
    end


    def self.show_missing(missing)
        unless missing.empty? then
            FableJS::Verbosity.quietly do
                puts "The following files could not be found:"
                missing.each {|f| puts "    #{f}" }
            end
            return true
        end
        false
    end

end
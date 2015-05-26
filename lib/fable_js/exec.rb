module FableJS::Exec

    def self.run(args)
        options = parse_options args
        FableJS.show_version if options.verbose?
        files = FileSearch.search options
        begin
            FableJS.optimize_files files, options.output, options.to_h
        rescue StandardError => err
            $stderr.puts err
            exit false
        rescue Exception => exc
            $stderr.puts exc
            exit false
        end
    end


    def self.parse_options(args)
        options = FableJS::Exec::Options.new
        options.parse! args

        FableJS::Verbosity.quiet = options.quiet?
        FableJS::Verbosity.verbose = options.verbose?

        options.show_help if options.help_wanted?
        (FableJS.show_version ; exit) if options.version_wanted?
        validate_options options
    end


    def self.validate_options(options)
        if options.files.empty? then
            options.show_mistake 'Need at least one file to process.'
        elsif options.quiet? and options.verbose? then
            options.show_mistake 'Cannot specify both quiet and verbose at once.'
        end
        unless options.output.nil? then
            if File.exist?(options.output) and not options.force? then
                FableJS::Verbosity.quiet_puts "Output file #{options.output} already exists (use --force to overwrite)."
                exit false
            end
        end
        options
    end

end


%w(file_search options).each {|lib| require "fable_js/exec/#{lib}" }
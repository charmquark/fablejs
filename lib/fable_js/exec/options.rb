class FableJS::Exec::Options

    def initialize
        @dirs           = ['.']
        @files          = nil
        @force          = false
        @help_wanted    = false
        @output         = nil
        @quiet          = false
        @verbose        = false
        @version_wanted = false
        @wrap           = false
    end


    attr        :dirs, :files, :output
    bool_attr   :force, :help_wanted, :quiet, :verbose, :version_wanted, :wrap


    def parse!(args)
        parser.parse! args
        @files = args
    end


    def parser
        create_parser if @parser.nil?
        @parser
    end


    def set(opts)
        opts.each_pair do |key, value|
            writer = (key.to_s + '=').to_sym
            self.__send__ writer, value if self.respond_to? writer
        end
    end


    def show_help(msg = nil, then_exit = true, with_status = true)
        puts msg, '' unless msg.nil?
        FableJS.show_version if @version_wanted
        puts parser
        if @verbose and not @files.empty? then
            puts '', "Would have processed files: #{@files.join ', '}"
        end
        exit with_status if then_exit
    end


    def show_mistake(msg)
        unless @quiet then
            show_help msg, true, false
        else
            exit false
        end
    end


    def to_h
        result = {}
        instance_variables.each do |varsym|
            key = (varsym.slice 1, varsym.length).to_sym
            result[key] = instance_variable_get varsym
        end
        result
    end


    private


    def create_parser
        require 'optparse'

        @parser = OptionParser.new do |op|
            op.banner = "Usage: #{$0} [options] file1 [file2 ... fileN]"

            op.on('-f', '--[no-]force', 'Will overwrite output file') do |b|
                @force = b
            end

            op.on('-I', '--include DIR', 'Include directory DIR') do |dir|
                @dirs << dir
            end

            op.on('-o', '--output FILE', 'Output will be written to FILE') do |file|
                @output = file
            end

            op.on('-q', '--[no-]quiet', 'Suppress output aside from results.') do |b|
                @quiet = b
            end

            op.on('-v', '--[no-]verbose', 'Run verbosely') do |b|
                @verbose = b
            end

            op.on('-W', '--[no-]wrap', 'Wrap source files in anonymous function calls') do |b|
                @wrap = b
            end

            op.on_tail('-h', '--help', 'Show usage information and exit') do
                @help_wanted = true
            end

            op.on_tail('--version', 'Show version and exit') do
                @version_wanted = true
            end
        end
    end

end
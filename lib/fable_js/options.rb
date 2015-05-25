require 'optparse'


class FableJS::Options

    def initialize
        @dirs           = ['.']
        @files          = nil
        @help_wanted    = false
        @verbose        = false
        @version_wanted = false
        @wrap           = false
        
        create_parser
    end

    attr        :dirs, :files
    bool_attr   :help_wanted, :verbose, :version_wanted


    def parse!(args)
        @parser.parse! args
        @files = args
        show_help if @help_wanted
        (FableJS.show_version ; exit) if @version_wanted
        show_help('Need at least one file to process.') if @files.empty?
    end


    def show_help(msg = nil, then_exit = true)
        (puts msg ; puts) unless msg.nil?
        FableJS.show_version if @version_wanted
        puts @parser
        if @verbose and not @files.empty? then
            puts
            puts "Would have processed files: #{@files.join ', '}"
        end
        exit if then_exit
    end


    private


    def create_parser
        @parser = OptionParser.new do |op|
            op.banner = "Usage: #{$0} [options] file1 [file2 ... fileN]"

            op.on('-I', '--include DIR', 'Include directory DIR') do |dir|
                @dirs << dir
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
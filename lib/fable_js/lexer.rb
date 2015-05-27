class FableJS::Lexer

    RX_WHITESPACE = /[\t\v ]/ #TODO: add <NBSP>, <BOM>, and <USP>


    def initialize(source)
        @source     = source
        @position   = 0
        @final      = source.length
        @start      = 0
        @line       = 1
        @column     = 1
        @token      = nil
    end


    def current_token
        @token
    end


    def empty?
        @position >= @final
    end


    def next_token

    end


    class Token

        def initialize(src_text, src_line, src_column)
            @text   = src_text
            @line   = src_line
            @column = src_column
        end


        attr :text, :line, :column

    end


private


    def begin_token
        @start = @position
        @token = nil
    end


    def complete_token
        Token.new ctext, @line, @column
    end

end
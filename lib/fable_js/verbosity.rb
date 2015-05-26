module FableJS

    module Verbosity

        @@quiet         = false
        @@verbose       = false


        def self.quiet?     ; @@quiet    ; end
        def self.verbose?   ; @@verbose  ; end


        def self.quiet=(b)  ; @@quiet   = !! b ; end
        def self.verbose=(b); @@verbose = !! b ; end


        def self.quiet_print(*args)
            print *args unless @@quiet
        end


        def self.quiet_puts(*args)
            puts *args unless @@quiet
        end


        def self.quietly(*args, &blk)
            yield *args unless @@quiet
        end


        def self.verbose_print(*args)
            print *args if @@verbose
        end


        def self.verbose_puts(*args)
            puts *args if @@verbose
        end


        def self.verbosely(*args, &blk)
            yield *args if @@verbose
        end

    end

end
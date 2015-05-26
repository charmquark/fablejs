module FableJS::Patches

    module File_Extend

        module AltJoin

            def alt_join(*strings)
                if File::ALT_SEPARATOR.nil? then
                    join *strings
                else
                    strings.join File::ALT_SEPARATOR
                end
            end

        end

    end


    patch ::File, File_Extend

end
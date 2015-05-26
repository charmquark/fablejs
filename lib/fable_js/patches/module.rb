module FableJS::Patches

    module Module

        module BoolAttr

            def bool_attr(*attrs)
                attrs.each do |attr_sym|
                    method_name = (attr_sym.to_s + '?').to_sym
                    var_name = '@' + attr_sym.to_s
                    define_method(method_name) do
                        !! instance_variable_get(var_name)
                    end
                end
            end


            def bool_attr_reader(*attrs)
                bool_attr *attrs
            end


            def bool_attr_accessor(*attrs)
                bool_attr_reader *attrs
                attr_writer *attrs
            end

        end
    
    end


    patch ::Module, Module

end
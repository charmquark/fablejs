module FableJS

    module Patches

        BASEPATH = File.join 'fable_js', 'patches'
        EXTEND_SUFFIX = '_Extend'


        def self.patch(entity, patch_mod)
            patches = patch_mod.constants(false).map {|sym| patch_mod.const_get sym }
            if patch_mod.to_s.end_with? EXTEND_SUFFIX then
                entity.extend *patches
            else
                entity.include *patches
            end
        end

    end

end


Dir[File.join File.dirname(__FILE__), 'patches', '*'].each do |lib|
    require File.join FableJS::Patches::BASEPATH, File.basename(lib)
end
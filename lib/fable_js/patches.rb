module FableJS::Patches

    def self.patch(entity, patch_mod)
        patches = patch_mod.constants(false).map {|sym| patch_mod.const_get sym }
        if patch_mod.to_s.end_with? 'Extend' then
            entity.extend *patches
        else
            entity.include *patches
        end
    end


    Dir[File.join File.dirname(__FILE__), 'patches', '*'].each do |lib|
        require "fable_js/patches/#{File.basename lib}"
    end

end
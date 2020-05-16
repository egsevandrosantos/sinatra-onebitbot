class Secret
    def self.[](key)
        root = Pathname.new('./config').expand_path
        sec_key = File.read(root.join('.master.key')).strip
        
        Sekrets.settings_for('./config/credentials.yml.enc', key: sec_key)[key]
    end
end
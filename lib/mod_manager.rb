require 'pry'

class ModMangerConfig
  def initialize(config_file)
    
  end
end

class SPTModManager
  attr_accessor :spt_dir, :spt_version
  
  def initialize(spt_dir)
    @spt_dir = spt_dir
    @spt_version = detect_spt_version(spt_dir)
    @installed_mods = detect_installed_mods(spt_dir)
  end

  def detect_installed_mods(spt_dir)
    
  end

  # This only works for 3.y.z, 4.0.0 no longer ships this json file
  # TODO: pull version information from SPT.Server.Linux.dll or SPT.Server.dll exif data instead
  # TODO: see TODO[0]
  def detect_spt_version(spt_dir) 
    core = JSON.load_file("#{spt_dir}/SPT_Data/Server/configs/core.json", symbolize_names: true)
    version = core[:sptVersion]

    raise "could not auto-detect SPT version, please set `spt-version` in config.toml" if version.nil?

    version
  end
end

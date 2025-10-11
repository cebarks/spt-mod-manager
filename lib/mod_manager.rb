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
  end

  def detect_spt_version(spt_dir) # TODO: pull version from SPT.Server.Linux.dll exif data
    core = JSON.load_file("#{spt_dir}/SPT_Data/Server/configs/core.json", symbolize_names: true)
    version = core[:sptVersion]

    raise "could not auto-detect SPT version, please set `spt-version` in config.toml" if version.nil?

    version
  end
end

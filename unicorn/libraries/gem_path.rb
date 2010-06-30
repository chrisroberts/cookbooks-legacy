# i despise this code. please accept my apologies.

module GemPath
  def gem_bin_path 
    # ruby enterprise edition
    if File.exists? "/usr/local/bin/ruby"
      "/usr/local/bin"
    
    # ubuntu default
    else
      "/var/lib/gems/1.8/bin"
    end
  end
  
  def gem_home_path
    # ruby enterprise edition
    if File.exists? "/usr/local/bin/ruby"
      "/usr/local/lib/ruby/gems/1.8"
      
    # ubuntu default
    else
      "/var/lib/gems/1.8"
    end
  end
end

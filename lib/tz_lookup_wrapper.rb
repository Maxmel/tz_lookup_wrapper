require "tz_lookup_wrapper/version"
require "tz_lookup_wrapper/active_support"
require "tz_lookup_wrapper/detect_node"
require 'tz_lookup_wrapper/exception'

module TzLookupWrapper

  TZ_LOOKUP_PATH="#{File.dirname(__FILE__)}/../vendor/tz-lookup/index.js"


  # Lookup a timezone
  # 
  # Example:
  #   >> TzLookupWrapper.lookup(43.7, -79.4)
  #   => "America/Toronto"
  #
  # Arguments:
  #   latitude: (Float)
  #   longitude: (Float)
 
  def self.lookup(lat_r,lng_r)
    lat =   Float lat_r
    lng =   Float lng_r
    script = <<-HEREDOC
      try {
        process.stdout.write(require("#{TZ_LOOKUP_PATH}")(#{lat}, #{lng}));
      } catch (ex) {
        process.stdout.write(ex.message);
        process.exit(code=1)
      }
    HEREDOC
    result = nil
    IO.popen(node_bin, 'r+') do |io|
      io.puts(script)
      io.close_write
      result = io.gets
    end
    if $?.success?
      result
    else
      raise WrapperException.new result || "Empty output"
    end
  end

  private

  def self.node_bin
    @node_bin ||= TzLookupWrapper::DetectNode.detect
  end
end

require "tz_lookup_wrapper/version"

module TzLookupWrapper
  class TzLookupWrapperException < Exception;end

  TZ_LOOKUP_PATH="#{File.dirname(__FILE__)}/../vendor/tz-lookup/index.js"

  def self.lookup(lat_r,lng_r)
    lat =   Float lat_r
    lng =   Float lng_r
    script = <<HEREDOC
try {
  process.stdout.write(require("#{TZ_LOOKUP_PATH}")(#{lat}, #{lng}));
} catch (ex) {
  process.stdout.write(ex.message);
  process.exit(code=1)
}
HEREDOC
    result = nil
    IO.popen('node', 'r+') do |io|
      io.puts(script)
      io.close_write
      result = io.gets
    end
    if $?.success?
      result
    else
      raise TzLookupWrapperException.new result || "Empty output"
    end
  end

end

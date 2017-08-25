module TzLookupWrapper
  class DetectNode
    MIN_VER = "0.10.0"

    def self.detect
      valid = false
      node_bins.each do |node|
        detected_version = (`#{node} --version`)[1..-1] rescue "0.0.0"
        if Gem::Version.new(detected_version) >= Gem::Version.new(MIN_VER)
              valid = true
              return node
        end
      end
      raise TzLookupWrapper::NodeOutdatedException.new MIN_VER unless valid
    end


    private

    def self.node_bins
      node_binaries = [ 'node', 'nodejs' ]
      detected = []
      exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
      ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
          node_binaries.each do |cmd|
            bin = File.join(path, "#{cmd}#{ext}")
            detected << bin if File.executable?(bin) && !File.directory?(bin)
          end
        }
      end
      return detected
    end
  end
end

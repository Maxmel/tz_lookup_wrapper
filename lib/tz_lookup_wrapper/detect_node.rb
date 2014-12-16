module TzLookupWrapper
  class DetectNode
    MIN_VER = [0, 10, 0]

    def self.detect
      node_bins.each do |node|
        detected_version = (`#{node} --version`)[1..-1].split(".") rescue "v0.0.0"
        if detected_version[0].to_i >= MIN_VER[0] and
            detected_version[1].to_i >= MIN_VER[1] and
            detected_version[2].to_i >= MIN_VER[2]
              return node
        end
      end
      raise TzLookupWrapper::NodeOutdatedException.new MIN_VER
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
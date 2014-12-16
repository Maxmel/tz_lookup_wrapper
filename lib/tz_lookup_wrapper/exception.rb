module TzLookupWrapper
  class BaseTzLookupWrapperException < Exception;end
  class WrapperException < BaseTzLookupWrapperException;end

  class NodeOutdatedException < BaseTzLookupWrapperException
    def initialize(min_ver)
      super "Cannot find a supported NodeJS installation. Minimum required version (v#{min_ver.join(".") || ""})"
    end
  end

end
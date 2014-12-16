require 'spec_helper'

describe TzLookupWrapper do
  it "should lookup coordinates" do
    expect(TzLookupWrapper.lookup(43.7, -79.4)).to eq("America/Toronto")
  end

  it "should format tzinfo to long timezone" do
    expect(TzLookupWrapper::ActiveSupport.format("America/Toronto")).to eq("Eastern Time (US & Canada)")
  end
end

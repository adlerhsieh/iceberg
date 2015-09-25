require "./spec_helper"

App = Iceberg::App.new
App.get "/app" do
  "this is app page"
end

describe Iceberg::App do
  describe "#new" do
    it "- no error" do
      App.should be_truthy
    end
  end
  describe "#get" do
    it "setup routes" do
      App.route.map["/app"].should be_truthy
    end
  end
end

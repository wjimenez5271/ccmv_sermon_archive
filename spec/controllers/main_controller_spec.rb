require 'spec_helper'

describe MainController do
  it "renders with application layout" do
    get 'index'
    should render_with_layout :application
  end

  it { should route(:get, "/").to( action: :index ) }

  it { root_path.should == '/' }

  describe "page parameter is verified" do
    { 23 => 23,
      1 => 1,
      nil => 1,
      "abc" => 1,
      ";abjksdf" => 1 }.each do |value, expected|
      it do 
        controller.stub!(:params) { { page: value } }
        controller.page.should == expected
      end
    end
  end

  describe "service parameter is verified" do
    { "Sunday" => "Sunday",
      "sunday" => "Sunday",
      "Thursday" => "Thursday",
      "thursday" => "Thursday",
      "All" => "All",
      "monday" => "All",
      nil => "All",
      "Sunday;" => "All" }.each do |value, expected|
      it do
        controller.stub!(:service_names) { [ "sunday", "thursday" ] }
        controller.stub!(:params) { { service: value } }
        get 'index'
        controller.service.should == expected
      end
    end
  end

  describe "sort behavior" do
    pending "Test sorting behavior"
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it do
      get 'index'
      should assign_to :sermons
      should assign_to :service_names
    end
  end

  pending "Test invalid values for page and sort"
end

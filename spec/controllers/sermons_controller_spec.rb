require 'spec_helper'

describe SermonsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

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

  describe "service parameter" do
    { "Sunday" => "Sunday",
      "sunday" => "Sunday",
      "Thursday" => "Thursday",
      "thursday" => "Thursday",
      "All" => "All",
      "monday" => "All",
      nil => "All",
      "Sunday;" => "All" }.each do |value, expected|
      describe "value #{value} expects #{expected}" do
        before(:each) do
          controller.stub!(:service_names) { [ "sunday", "thursday" ] }
          controller.stub!(:params) { { service: value } }
          get 'index'
        end

        it "verifies the service parameter" do
          controller.service.should == expected
        end

        it "assigns show_field correctly" do
          assigns(:show_field).should == { "service" => expected == "All" }
        end
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

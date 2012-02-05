require 'spec_helper'

describe MainController do
  it "renders with application layout" do
    get 'index'
    should render_with_layout :application
  end

  it { should route(:get, "/").to( action: :index, page: 1, sort: "-date" ) }
  it { should route(:get, "/23").to( action: :index, page: 23, sort: "-date" ) }

  it { root_path.should == '' }
  it { root_path(5).should == '/5' }

  describe "page method sanitizes correctly" do
    { 23 => 23,
      1 => 1,
      nil => 1,
      "a" => 1,
      "abjksdf" => 1 }.each do |value, expected|
      it do 
        controller.stub!(:params) { { page: value } }
        controller.page.should == expected
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
    end
  end

  pending "Test invalid values for page and sort"
end

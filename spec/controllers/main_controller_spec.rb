require 'spec_helper'

describe MainController do
  it "renders with application layout" do
    get 'index'
    should render_with_layout :application
  end

  it { should route(:get, "/").to( action: :index, page: 1 ) }
  it { should route(:get, "/23").to( action: :index, page: 23 ) }

  it { root_path.should == '' }
  it { root_path(5).should == '/5' }

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
end

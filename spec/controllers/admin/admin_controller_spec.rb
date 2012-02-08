require 'spec_helper'

describe Admin::AdminController do
  it { should route(:get, "/admin").to( action: :index ) }
  it { admin_root_path.should == '/admin' }
  it "renders admin layout" do 
    get 'index'
    should render_with_layout 'admin'
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end

require 'spec_helper'

describe Admin::MainController do
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

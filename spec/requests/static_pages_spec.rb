require 'spec_helper'

describe "Static Pages" do

  let(:base_title) { "Sample App" }

  describe "Home Page" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      page.should have_content('Sample App')
    end

    it "should have the right title" do
      visit '/static_pages/home'
      page.should have_selector('title',
                                :text => "#{base_title} | Home" )
    end
  end

  describe "Help Page" do
    it 'should have the content "Help"' do
       visit '/static_pages/help'
       page.should have_content('Help')
    end
    it "should have the right title" do
      visit '/static_pages/help'
      page.should have_selector('title',
                                :text => "#{base_title} | Help" )
    end
  end

  describe "About Page" do
    it 'should have the content "About Us"' do
      visit '/static_pages/about'
      page.should have_content('About')
    end

    it "should have the right title" do
      visit '/static_pages/about'
      page.should have_selector('title',
                                :text => "#{base_title} | About" )
    end
  end

  
end


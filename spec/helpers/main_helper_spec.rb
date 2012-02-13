require 'spec_helper'

describe MainHelper do
  describe "full_title" do
    before { helper.stub!(:service) { "All" } }
    it { helper.full_title('').should == 'CCMV Sermon Archive' }
    it { helper.full_title('AbCd').should == 'CCMV Sermon Archive | AbCd' }
    it do
      helper.stub!(:service) { 'service b' }
      helper.full_title('').should == 'CCMV Sermon Archive | Service B'
    end
    it do
      helper.stub!(:service) { 'service 1' }
      helper.full_title('AbCd').should == 'CCMV Sermon Archive | AbCd | Service 1' 
    end
  end
  describe "service_link" do
    services = [ "All", "all", "service 1", "service 2",
      "Service 1", "a b c" ]

    services.each do |selected_service|
      services.each do |service_name|
        describe "service #{service_name} with selected=#{selected_service}" do
          before do 
            helper.stub!(:params) { {} }
            helper.stub!(:service) { selected_service }
          end
          subject { helper.service_link(service_name) }
          let(:selected) { selected_service.downcase == service_name.downcase }
          selected = selected_service.downcase == service_name.downcase

          it { should match /service_link/ }
          it { should match \
               /id="#{service_name.downcase.parameterize('_')}_service_link"/ }
          
          if selected
            it { should match /^<span/ }
            it { should_not match /<a/ }
            it { should match /service_current/ }
          else
            it { should_not match /service_current/ }
            it { should_not match /<span/ }
            it { should match /^<a/ }
            it { should_not match /page=/ }
            if service_name.downcase != "all"
              it { should include "#{service_name.to_query('service')}" }
            else
              it { should_not match /service=/ }
            end
          end
        end
      end
    end
  end
end

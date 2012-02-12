require 'spec_helper'

describe "Sermon List" do

  before(:all) do
    @speakers = Array.new(2) { FactoryGirl.create(:speaker) }
    @services = Array.new(2) { FactoryGirl.create(:service) }
    @sermons = []
    @speakers.each do |speaker|
      @services.each do |service|
        10.times do
          @sermons << 
              FactoryGirl.create(:sermon, service:service, speaker:speaker)
        end
      end
    end
  end

  after(:all) do
    Sermon.delete_all
    Service.delete_all
    Speaker.delete_all
  end

  subject { page }
   
  describe "sorting links" do
    it do
      visit root_path
      
      should have_css('#date_sort a.sort_desc')
      should have_link('Date', href: '/?page=1&sort=date' )

      click_link 'Date'
      should have_css('#date_sort a.sort_asc')
      should have_link('Date', href: '/?page=1&sort=-date' )
      should have_link('Speaker', href: '/?page=1&sort=speaker' )
      should have_link('Service', href: '/?page=1&sort=service' )
      
      click_link 'Date'
      should have_css('#date_sort a.sort_desc')
      should have_link('Date', href: '/?page=1&sort=date' )
      should have_link('Speaker', href: '/?page=1&sort=speaker' )
      should have_link('Service', href: '/?page=1&sort=service' )

      click_link 'Speaker'
      should have_css('#speaker_sort a.sort_asc')
      should have_link('Date', href: '/?page=1&sort=-date' )
      should have_link('Speaker', href: '/?page=1&sort=-speaker' )
      should have_link('Service', href: '/?page=1&sort=service' )

      click_link 'Speaker'
      should have_css('#speaker_sort a.sort_desc')
      should have_link('Speaker', href: '/?page=1&sort=speaker' )

      click_link 'Service'
      should have_css('#service_sort a.sort_asc')
      should have_link('Service', href: '/?page=1&sort=-service' )
      should have_link('Date', href: '/?page=1&sort=-date' )

      click_link 'Date'
      should have_css('#date_sort a.sort_desc')
      should have_link('Date', href: '/?page=1&sort=date' )
    end

    it "should go to 1 when changing the sort" do
      visit root_path( page: 2 )
      should have_css('#date_sort a.sort_desc')
      should have_link('Date', href: '/?page=1&sort=date')
      should have_css('div.pagination em.current',
                           text:'2')
      click_link 'Service'
      should have_css('#service_sort a.sort_asc')
      should have_link('Service', href: '/?page=1&sort=-service')
      should have_css('div.pagination em.current',
                           text:'1')
    end

    it "should go to 1 when changing the sort order on the same field" do
      visit root_path( page: 2 )
      click_link 'Date'
      should have_css('#date_sort a.sort_asc')
      should have_link('Date', href: '/?page=1&sort=-date')
      should have_css('div.pagination em.current', text:'1')
    end
  end

  describe "service selectors" do
    it "should change services correctly" do
      visit root_path
      should_not have_link('All')
      should have_link('Service 1', href: '/?service=Service+1&sort=-date')
      should have_css('#all_service_link.service_current', text: 'All' )
      should have_css('#service_1_service_link.service_link')
      should_not have_css('#service_1_service_link.service_current')
      should have_css('a.service_link', text: 'Service 1' )
      should have_css('a.service_link', text: 'Service 2' )
      
      click_link 'Service 1'
      print page.html
      should have_link('All', href: '/?sort=-date')
      should_not have_link('Service 1')
      should have_css('#service_1_service_link.service_current', 'Service 1')
      should have_css('#service_1_service_link.service_link')
      should_not have_css('#all_service_link.service_current')
      should have_css('a.service_link', text: 'Service 1' )
      should_not have_css('a.service_link', text: 'Service 2' )

      click_link 'All'
      should_not have_link('All')
      should have_link('Service 1', href: '/?service=Service+1&sort=-date')
      should have_css('#all_service_link.service_current', 'All')
      should_not have_css('#service_1_service_link.service_current')
      should have_css('a.service_link', text: 'Service 1' )
      should have_css('a.service_link', text: 'Service 2' )
    end

    it "should switch to page 1 and keep sort when selecting a service" do
      visit root_path(page: 2, sort:'speaker')
      click_link 'Thursday'
      should have_css('div.pagination em.current', text:'1')
      should have_css('#speaker_sort a.sort_asc')
    end
  end

  describe "paginate links" do
    it "should paginate correctly" do
      visit root_path
      first_date = @sermons.first.date.to_date
      paginate_amount = 30
      should have_content(first_date)
      should have_content(first_date - paginate_amount + 1)
      should_not have_content(first_date - paginate_amount)

      click_link '2'
      should_not have_content(first_date.to_s)
      should_not have_content(first_date - paginate_amount + 1)
      should have_content(first_date - paginate_amount)
    end

  end
end


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
   
  describe "Sorting Links" do
    subject { page }
    it do
      visit root_path
      
      should have_css('#date_sort a.sort_desc')
      should have_link('Date', href: '/1?sort=date' )

      click_link 'Date'
      should have_css('#date_sort a.sort_asc')
      should have_link('Date', href: '/1?sort=-date' )
      should have_link('Speaker', href: '/1?sort=speaker' )
      should have_link('Service', href: '/1?sort=service' )
      
      click_link 'Date'
      should have_css('#date_sort a.sort_desc')
      should have_link('Date', href: '/1?sort=date' )
      should have_link('Speaker', href: '/1?sort=speaker' )
      should have_link('Service', href: '/1?sort=service' )

      click_link 'Speaker'
      should have_css('#speaker_sort a.sort_asc')
      should have_link('Date', href: '/1?sort=-date' )
      should have_link('Speaker', href: '/1?sort=-speaker' )
      should have_link('Service', href: '/1?sort=service' )

      click_link 'Speaker'
      should have_css('#speaker_sort a.sort_desc')
      should have_link('Speaker', href: '/1?sort=speaker' )

      click_link 'Service'
      should have_css('#service_sort a.sort_asc')
      should have_link('Service', href: '/1?sort=-service' )
      should have_link('Date', href: '/1?sort=-date' )

      click_link 'Date'
      should have_css('#date_sort a.sort_desc')
      should have_link('Date', href: '/1?sort=date' )
    end

    it "should go to 1 when changing the sort" do
      visit root_path(2)
      should have_css('#date_sort a.sort_desc')
      should have_link('Date', href: '/1?sort=date')
      should have_css('div.pagination em.current',
                           text:'2')
      click_link 'Service'
      should have_css('#service_sort a.sort_asc')
      should have_link('Service', href: '/1?sort=-service')
      should have_css('div.pagination em.current',
                           text:'1')
    end

    it "should go to 1 when changing the sort order on the same field" do
      visit root_path(2)
      click_link 'Date'
      should have_css('#date_sort a.sort_asc')
      should have_link('Date', href: '/1?sort=-date')
      should have_css('div.pagination em.current',
                           text:'1')
    end
    
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


class MainController < ApplicationController
  def index
    @sermons = Sermon.paginate( page: params[ :page ],
                                order: 'date DESC' )
  end
end

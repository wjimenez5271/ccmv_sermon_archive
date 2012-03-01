class SermonsController < ApplicationController
  helper_method :service
  helper_method :show_field
  helper_method :sermons_per_book
  layout :domain_specific_layout

  handles_sortable_columns do |conf|
    conf.indicator_class = { asc: "sort_asc", desc: "sort_desc" }
  end

  # TODO Add a function that calculates the defaults for variou things based on the
  # parameters passed in.

  def index
    # TODO Find a better way to do this that doesn't tack -date on to the
    # default URL? Probably have to modify handles_sortable_columns to do this
    params[:sort] ||= '-date'
    
    if params[:tfth]
      show_field.merge( { service: false, speaker: false } )
    else
      show_field[:service] = service == "All"
      show_field[:speaker] = service != 'Sunday'
    end
    @sermons = Sermon.prefetch_refs.order(sort_order).paginate(page: page)
    @sermons = where_clause(@sermons)
      
  end

  def show
    @sermon = Sermon.find(params[:id])
    # Other text lookup or whatever needs to be done here
  end

  def main
    show_field.merge( { service: false, speaker: false } )
    @latest_sermon = Sermon.order("date DESC").limit(1)
    @latest_sermon = where_clause(@latest_sermon)
  end

  def where_clause(obj)
    obj = obj.where("services.name = ?", service) unless show_field[:service]
    obj = obj.where("speaker.name = ?", speaker) unless show_field[:speaker]
    obj = obj.where("book.name = ?", book.name) unless book == nil
  end


  def show_field
    if not defined? @show_field
      @show_field = Hash.new(true)
    end
    @show_field
  end

  def sort_order
    sortable_column_order do |column, direction|
      case column
      when "date"
        "#{column} #{direction}"
      when "speaker", "service"
        "#{column.pluralize}.name #{direction}, date DESC"
      when "passage"
        "book_id #{direction}, start_chapter #{direction}, " + \
          "start_verse #{direction}, date #{direction""
      else
        "date DESC"
      end
    end
  end

  def where_clause(object)
    if service != @default_service
      object = object.where("services.name=?", service)
    end

    if book != nil
      object = object.where("book_id=?", book.id)
    end

    if speaker != nil

  end

  def page
    Integer(params[:page])
  rescue
    1
  end

  def book
    # TODO Do some abbreviation parsing here.
    if not defined? @book
      if params.include? :book
        @book = Book.where("name=?", params[:book]).first
      else
        @book = nil
      end
    end
    @book
  end

  def service
    if not defined? @service
      # TODO default should be nil, helper should handle it
      @default_service = "All"

      begin
        # TODO Do this with a simple where statement instead?
        # Or maybe not since we often need to get the service names anyway
        if service_names.include?(params[:service].downcase)
          @service = params[:service].titleize
        else
          @service = @default_service
        end
      rescue
        @service = @default_service
      end

    end
    @service
  end

  def service_names
    if not defined? @service_names
      @service_names = Service.order("name ASC").collect(&:name).each do |name|
        name.downcase!
      end
    end
    @service_names
  end

  def active_books
    if not defined? @active_books
      sermons = Sermon.group(:book_id).includes(:book).joins(:book).order(:book_id)
      @active_books = sermons.each_with_object([]) { |l, s| l << s.book }
    end
    @active_books
  end
end

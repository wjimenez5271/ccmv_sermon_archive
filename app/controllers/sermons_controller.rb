class SermonsController < ApplicationController
  helper_method :service
  helper_method :speaker
  helper_method :book
  helper_method :show_field
  helper_method :active_books
  helper_method :domain_search_restrictions
  layout :domain_specific_layout

  handles_sortable_columns(:only => [:index]) do |conf|
    conf.indicator_class = { asc: "sort_asc", desc: "sort_desc" }
    conf.default_sort_value = '-date'
  end

  handles_sortable_columns(:only => [:book_index]) do |conf|
    conf.indicator_class = { asc: "sort_asc", desc: "sort_desc" }
    conf.default_sort_value = 'passage'
  end

  # TODO Add a function that calculates the defaults for variou things based on the
  # parameters passed in.

  def index
    show_field[:service] = service == nil
    show_field[:speaker] = speaker == nil
    @sermons = Sermon.prefetch_refs.order(sort_order).paginate(page: page)
    @sermons = where_clause(@sermons)
      
  end

  def book_index
    # This is a hack so I can use a different handles_sortable_columns
    # configuration. There's probably a cleaner way to do this.
    index
    render :index
  end


  def show
    @sermon = Sermon.find(params[:id])
    # Other text lookup or whatever needs to be done here
    if not @sermon
      # TODO return a 404 or something instead?
      redirect_to root_path
    end
  end

  def main
    show_field.merge( { service: false, speaker: false } )
    @latest_sermon = Sermon.order("date DESC").limit(1)
    @latest_sermon = where_clause(@latest_sermon)
    @latest_sermon = @latest_sermon.first
  end

  def where_clause(obj)
    if service
      obj = obj.where("services.name = ?", service)
    end

    if speaker
      obj = obj.where("speaker.name = ?", speaker)
    end

    if book
      obj = obj.where("books.name = ?", book.name)
    end

    obj
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
          "start_verse #{direction}, end_chapter #{direction}, " + \
          "end_verse #{direction}, date #{direction}"
      else
        "date DESC"
      end
    end
  end

  def page
    Integer(params[:page])
  rescue
    1
  end

  def speaker
    if not defined? @speaker
      @speaker = domain_search_restrictions[:speaker]
      @speaker ||= params[:speaker]
    end
    @speaker
  end

  def book
    # TODO Do some abbreviation parsing on params[:book]
    if not defined? @book
      # TODO Sanitize params[:book]
      b = domain_search_restrictions[:book] || params[:book]
      if b
        @book = Book.where("name=?", b).first
      else
        @book = nil
      end
    end
    @book
  end

  def service
    if not defined? @service
      @service = domain_search_restrictions[:service]
      if not @service
        begin
          # TODO Do this with a simple where statement instead?
          # Or maybe not since we often need to get the service names anyway
          if service_names.include?(params[:service].downcase)
            @service = params[:service]
          else
            @service = nil
          end
        rescue
          @service = nil
        end
      end

      @service = @service.titleize if @service
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
      @active_books = sermons.each_with_object([]) { |s, l| l << s.book }
    end
    @active_books
  end
end

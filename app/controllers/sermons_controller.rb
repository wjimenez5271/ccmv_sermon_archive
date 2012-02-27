class SermonsController < ApplicationController
  helper_method :books
  helper_method :service
  helper_method :show_field
  before_filter :setup_services

  handles_sortable_columns do |conf|
    conf.indicator_class = { asc: "sort_asc", desc: "sort_desc" }
  end

  def index
    # TODO Find a better way to do this that doesn't tack -date on to the
    # default URL? Probably have to modify handles_sortable_columns to do this
    params[:sort] ||= '-date'
    
    selected_service = service

    @show_field = { service: selected_service == "All",
      speaker: selected_service != 'Sunday' }
    @sermons = Sermon.prefetch_refs.order(sort_order).paginate(page: page)
    @sermons = @sermons.where("services.name = ?", selected_service) \
      unless @show_field[:service]
      
  end

  def main
    @show_field = { service: false, speaker: false }
    @latest_sermon = Sermon.where("services.name = ?", selected_service).order("date DESC").limit(1)
    @books = Book.all
  end

  def show_field(field)
    if @show_field.include?(field)
      @show_field[field]
    else
      true
    end
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

  def page
    Integer(params[:page])
  rescue
    1
  end

  def books
    @books
  end

  def service
    @service
  end

  def service_names
    @service_names
  end

  def setup_services(default_service="Sunday")
    @service_names = Service.order("name ASC").collect(&:name).each do |name|
      name.downcase!
    end

    begin
      if service_names.include?(params[:service].downcase)
        @service = params[:service].titleize
      else
        @service = default_service
      end
    rescue
      @service = default_service
    end
  end
end

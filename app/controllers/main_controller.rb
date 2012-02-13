class MainController < ApplicationController
  helper_method :service
  before_filter :setup_services

  handles_sortable_columns do |conf|
    conf.indicator_class = { asc: "sort_asc", desc: "sort_desc" }
  end

  def index
    # TODO Find a better way to do this that doesn't tack -date on to the
    # default URL? Probably have to modify handles_sortable_columns to do this
    params[:sort] ||= '-date'
    
    selected_service = service

    order = sortable_column_order do |column, direction|
      case column
      when "date"
        "#{column} #{direction}"
      when "speaker", "service"
        "#{column.pluralize}.name #{direction}, date DESC"
      else
        "date DESC"
      end
    end

    # TODO Make this more efficient. Don't include service column if
    # selected_service has a value. Match on service id instead of name?
    @sermons = Sermon.prefetch_refs.order(order).paginate(page: page)
    @sermons = @sermons.where("services.name = ?", selected_service) if selected_service != "All"
  end

  def page
    Integer(params[:page])
  rescue
    1
  end

  def service
    @service
  end

  def service_names
    @service_names
  end

  def setup_services
    @services = Service.order("name ASC")
    @service_names = @services.each_with_object([]) do |service, names|
      names << service.name.downcase
    end

    begin
      if service_names.include?(params[:service].downcase)
        @service = params[:service].titleize
      else
        @service = "All"
      end
    rescue
      @service = "All"
    end
  end
end

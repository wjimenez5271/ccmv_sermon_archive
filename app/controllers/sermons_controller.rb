class SermonsController < ApplicationController
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

    @show_field = { service: selected_service == "All" }
    @sermons = Sermon.prefetch_refs.order(order).paginate(page: page)
    @sermons = @sermons.where("services.name = ?", selected_service) \
      unless @show_field[:service]
      
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
    @service_names = Service.order("name ASC").collect(&:name).each do |name|
      name.downcase!
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

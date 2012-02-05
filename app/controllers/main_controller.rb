class MainController < ApplicationController
  handles_sortable_columns do |conf|
    conf.indicator_class = { asc: "sort_asc", desc: "sort_desc" }
  end

  def index
    params[:sort] ||= '-date'
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
    @sermons = Sermon.prefetch_refs.order(order).paginate(page: page)
  end

  def page
    Integer(params[:page])
  rescue
    1
  end
end

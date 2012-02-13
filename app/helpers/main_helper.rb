module MainHelper
  def full_title(page_title)
    base_title = "CCMV Sermon Archive"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def service_link(service_name)
    id = "#{service_name.downcase.parameterize('_')}_service_link"
    if service.downcase == service_name.downcase
      content_tag "span", service_name.titleize,
        { :class => "service_current service_link", :id => id  }
    else
      if service_name.downcase == "all"
        param_value = nil
      else
        param_value = service_name
      end
      
      link_to service_name.titleize, 
        root_path(params.merge({ service: param_value, page: nil })),
        { :class => "service_link", :id => id }
    end
  end
end

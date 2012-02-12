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
    if service.downcase == service_name
      class_name = "service_current"
      tag_type = "span"
      content_tag "span", service_name.titleize,
        { class: "service_current service_link", 
          id: "#{service_name.downcase.parameterize('_')}_service_link" }
    else
      if service_name == "All"
        param_value = nil
      else
        param_value = service_name
      end
      
      link_to service_name.titleize, 
        root_path(params.merge({ service: param_value })),
        { :class => "service_link",
          :id => "#{service_name.downcase.parameterize('_')}_service_link" }
    end
  end
end

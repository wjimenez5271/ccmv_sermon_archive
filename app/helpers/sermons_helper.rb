require 'erb'
module SermonsHelper

  def service_link(service_name)
    id = "#{service_name.downcase.parameterize('_')}_service_link"
    if service and service.downcase == service_name.downcase
      content_tag "span", service_name.titleize,
        { :class => "service_current service_link", :id => id  }
    else
      if service_name.downcase == "all"
        param_value = nil
      else
        param_value = service_name
      end
      
      link_to service_name.titleize, 
        sermons_path(params.merge({ service: param_value, page: nil })),
        { :class => "service_link", :id => id }
    end
  end

  def field_header(field, sort_direction=:asc)
    if show_field[field]
      field = field.to_s
      s = "<div id=\"#{field}_sort\" class=\"sermon_#{field} sermon_list_header>\">\n"
      s << sortable_column(field.titleize, direction: sort_direction)
      s << "\n</div>\n"
      s.html_safe
    end
  end

  def all_sermons_link

  end

  def book_selection_links
    # TODO Put this into a partial
    # This assumes that we have at least one sermon for an Old Testament book.
    links_per_row = 5

    s = '<div id="book_links">'

    s << '<p>Old Testament</p>'
    last_ot = true
    link_num = 0
    s << '<div class="book_link_row">'
    active_books.each do |book|
      if last_ot != book.old_testament
        s << '</div><p>New Testament</p><div class="book_link_row">'
        last_ot = book.old_testament
        link_num = 0
      else
        link_num += 1
        if link_num == links_per_row
          s << '</div><div class="book_link_row">'
          link_num = 0
        end
      end

      s << link_to(book.name, book_path(ERB::Util.url_encode(book.name)), 
                   { :class => "book_link" } )
      
    end

    s << '</div></div>'
    s.html_safe
  end
end

module SermonsHelper
  def full_title(page_title='')
    base_title = "CCMV Sermon Archive"
    if not page_title.empty?
      base_title << " | #{page_title}"
    end

    if service.downcase != "all"
      base_title << " | #{service.titleize}"
    end

    base_title
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
        sermons_path(params.merge({ service: param_value, page: nil })),
        { :class => "service_link", :id => id }
    end
  end

  def field_header(field, sort_direction=:asc)
    if show_field(field)
      field = field.to_s
      s = "<div id=\"#{field}_sort\" class=\"sermon_#{field} sermon_list_header>\n"
      s << sortable_column field.titleize
      s << "\n</div>\n"
    end
  end

  def more_recent_sermons_link

  end

  def book_selection_links
    # This assumes that we have at least one sermon for an Old Testament book.
    links_per_row = 5

    s = '<div id="book_links">\n'

    s << '<p>Old Testament</p>\n'
    last_ot = true
    link_num = 0
    s << '<div class="book_link_row">'
    active_books do |book|
      if last_ot != book.old_testament
        s << '</div>\n<p>New Testament</p>\n<div class="book_link_row">\n'
        last_ot = book.old_testament
        link_num = 0
      else
        link_num += 1
        if link_num == links_per_row
          s << '</div>\n<div class="book_link_row">'
          link_num = 0
        end
      end

      s << link_to book.name, book_path(book.name), { :class => "book_link" }
      
    end

    s << '</div></div>'
  end
end

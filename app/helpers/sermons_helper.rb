require 'erb'
module SermonsHelper

  def service_link(service_name)
    id = "#{service_name.downcase.parameterize('_')}_service_link"
    if service and service.downcase == service_name.downcase
      content_tag "span", service_name.titleize,
        { :class => "service_current service_link", :id => id  }
    else
      if service_name.downcase == "all"
        path = sermons_path
      else
        path = service_path( ERB::Util.url_encode(service_name) )
      end
      
      link_to service_name.titleize, path,
        { :class => "service_link", :id => id }
    end
  end

  def speaker_link(speaker_name)
    id = "#{speaker_name.downcase.parameterize('_')}_speaker_link"
    if speaker and speaker.downcase == speaker_name.downcase
      content_tag "span", speaker_name.titleize,
        { :class => "speaker_current speaker_link", :id => id  }
    else
      if speaker_name.downcase == "all"
        path = sermons_path
      else
        path = speaker_path( ERB::Util.url_encode(speaker_name) )
      end
      
      link_to speaker_name.titleize, path,
        { :class => "speaker_link", :id => id }
    end
  end

  def book_selection_links
    # TODO Put this into a partial
    # This assumes that we have at least one sermon for an Old Testament book.
    links_per_row = 5

    s = '<div id="book_links">'

    s << '<h4>Old Testament</h4>'
    last_ot = true
    link_num = 0
    s << '<table class="sermons_link_table"><tr class="book_link_row">'

    active_books.each do |book|
      if last_ot != book.old_testament
        s << '</tr></table><h4>New Testament</h4><table class="sermons_link_table"><tr class="book_link_row">'
        last_ot = book.old_testament
        link_num = 0
      end

      if link_num == links_per_row
        s << '</tr><tr class="book_link_row">'
        link_num = 1
      else
        link_num += 1
      end

      s << '<td>'
      s << link_to(book.name, book_path(ERB::Util.url_encode(book.name)), 
                   { :class => "book_link" } )
      s << '</td>'
      
    end

    s << '</tr></table></div>'
    s.html_safe
  end
end

module ApplicationHelper
  def link_to_media(name, file, *args)
    # TODO
    link_to name, file, *args
  end

  def full_title(page_title=nil)
    s = tfth_title(page_title)

    if service
      if not s.blank?
        s << ' | '
      end
      s << service.titleize
    end

    if speaker
      if not s.blank?
        s << ' | '
      end
      s << service.titleize
    end
  end

  def tfth_title(page_title=nil)
    s = String.new( base_title )
    if page_title and not page_title.empty?
      if not s.blank?
        s << ' | '
      end
      s << page_title
    end
  end

end

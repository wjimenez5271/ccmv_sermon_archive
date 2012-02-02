module MainHelper
  def full_title(page_title)
    base_title = "CCMV Sermon Archive"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end

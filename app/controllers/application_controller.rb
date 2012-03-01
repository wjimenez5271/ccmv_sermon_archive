class ApplicationController < ActionController::Base
  protect_from_forgery
  @@domain_layouts_cache = {}
  @@domain_search_restrictions_cache = {}

  helper_method :base_title

  def domain_specific_layout
    l = @@domain_layouts_cache[request.host]
    return l if l

    # We haven't seen this domain yet. Figure out which layout to use.
    # Right now we assume that there will never be a domain that matches
    # multiple regexes, so we don't care about the order in which they're checked.
    CcmvSermonArchive::Application.config.domain_layouts.each do |regex, value|
      if request.host =~ regex
        l = value
        break
      end
    end

    l ||= CcmvSermonArchive::Application.config.domain_layouts.default
    @@domain_layouts_cache[ request.host ] = l
  end

  def domain_search_restrictions
    l = @@domain_search_restrictions_cache[request.host]
    return l if l

    # We dont have this domain cached, so figure out the correct value to use.
    CcmvSermonArchive::Application.config.domain_search_restrictions.each do
      |regex, value|
      if request.host =~ regex
        l = value
        break
      end
    end

    l ||= {}
    @@domain_search_restrictions_cache[request.host] = l
    return l
  end

  def base_title
    if not defined? @base_title
      @base_title = ''
    end
    @base_title
  end

end

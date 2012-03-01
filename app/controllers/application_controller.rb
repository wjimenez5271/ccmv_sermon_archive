class ApplicationController < ActionController::Base
  protect_from_forgery
  @@domain_layouts_cache = {}

  def domain_specific_layout
    l = @@domain_layouts_cache[ request.host ]
    return l if l

    # We haven't seen this domain yet. Figure out which layout to use.
    # Right now we assume that there will never be a domain that matches
    # multiple regexes, so we don't care about the order in which they're checked.
    CcmvSermonArchive.Application.config.domain_layouts.each do |regex, value|
      if request.host =~ regex
        l = value
        break
      end
    end

    l = CcmvSermonArchive.Application.config.domain_layouts.default if not l
    @@domain_layouts_cache[ request.host ] = l
  end
end

# == Schema Information
#
# Table name: books
#
#  id            :integer         not null, primary key
#  name          :string(20)      not null
#  old_testament :boolean         default(FALSE)
#

class Book < ActiveRecord::Base

end

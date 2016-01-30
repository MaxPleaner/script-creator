class Script < ActiveRecord::Base
  validates :name, :content, presence: true
end

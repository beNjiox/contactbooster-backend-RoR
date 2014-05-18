class List < ActiveRecord::Base
  validates :position, numericality: true
end

class List < ActiveRecord::Base
  has_many :contacts

  validates :position, numericality: true
end

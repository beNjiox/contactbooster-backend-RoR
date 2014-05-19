class Contact < ActiveRecord::Base
  belongs_to :list, counter_cache: true

  validates :lastname, length: { in: 2..30 }
  validates :firstname, length: { in: 2..30 }
  validates :phone, numericality: true
end

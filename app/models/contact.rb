class Contact < ActiveRecord::Base
  belongs_to :list, counter_cache: true

  validates :lastname, length: { in: 2..30 }
  validates :firstname, length: { in: 2..30 }
  validates :phone, length: { in: 8..10 }, format: { with: /[0-9]*/ }
end

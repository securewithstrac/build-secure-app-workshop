class Address < ApplicationRecord
  validates :alias, presence: true
end

class Like < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user

  validates_uniqueness_of :post, scope: :user # TODO: Add validation in DB
end

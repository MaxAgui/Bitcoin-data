class Bitcoin < ApplicationRecord
  validates :hashb, presence: true

  scope :ordered, -> { order(id: :desc) }
end

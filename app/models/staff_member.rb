class StaffMember < ApplicationRecord
  belongs_to :team
  has_one_attached :photo
  validates :name, :role, presence: true
end

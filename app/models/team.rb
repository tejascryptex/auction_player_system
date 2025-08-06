class Team < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :staff_members, dependent: :destroy
  has_one_attached :logo
  has_one_attached :owner_avatar
  has_many :draw_players, dependent: :destroy


  validates :team_name, uniqueness: { scope: :owner_name, message: "already exists for this owner" }

  before_validation :set_default_purse, on: :create
  after_create :add_owner_as_player

  def available_purse
    (purse) - players.sum(:price)
  end

  private

  def set_default_purse
    self.purse ||= 3_000_000
  end

  def add_owner_as_player
    players.create!(
      name: owner_name,
      role: "All-Rounder",
      price: 300_000
    )
  end
end


class Player < ApplicationRecord
  belongs_to :team

  validate :price_within_team_purse, on: :create

  validates :price, numericality: { greater_than_or_equal_to: 0 }


  private

  def price_within_team_purse
    return if price.blank? || team.blank?
    if team.available_purse <= 0
      errors.add(:base, "Team purse exhausted. Use the lucky draw.")
    elsif price > team.available_purse
      errors.add(:price, "is greater than team available purse")
    end
  end
end

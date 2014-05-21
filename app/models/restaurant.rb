class Restaurant < ActiveRecord::Base
  validates :name, presence: true, format: { with: /\A[A-Z]/, message: 'must begin with capital letter' }
  validates :address, presence: true, length: { minimum: 3 }
  validates :cuisine, presence: true
  has_many :reviews

  # def reviews
  #   Review.where(restaurant_id: self.id)
  # end

  def average_rating
    if reviews.any?
      reviews.average(:rating)
    else
      'N/A'
    end
  end
end

class Course < ApplicationRecord
  has_many :students, dependent: :destroy
  has_many :evaluations, dependent: :destroy
  has_many :grades, through: :evaluations, dependent: :destroy
  validates :name, uniqueness: {scope: :year, message: "This course already exists"}, presence: true
  validates :year, presence: true, numericality: {only_integer:true, greater_than:1.years.ago.year, less_than:Date.today.year+10}

  def to_s
    name
  end
end

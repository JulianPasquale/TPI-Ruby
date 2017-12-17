class Course < ApplicationRecord
  has_many :students, :dependent => :destroy
  has_many :evaluations, :dependent => :destroy
  has_many :grades, :through => :evaluations
  validates :name, uniqueness: {scope: :year, message: "This course already exists"}, presence: true
  validates :year, presence: true, numericality: {only_integer:true, greater_than:2015, less_than:2025}

  def to_s
    name
  end
end

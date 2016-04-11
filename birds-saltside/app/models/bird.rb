class Bird
  include Mongoid::Document

  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :added, type: Date, default: ->{Time.now.to_date}
  field :visible, type: Mongoid::Boolean, default: ->{false}

  validates_uniqueness_of :name
  validates_presence_of :name, :family, :continents
end

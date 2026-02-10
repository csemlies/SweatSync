# == Schema Information
#
# Table name: studios
#
#  id         :bigint           not null, primary key
#  location   :string
#  name       :string
#  source_url :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Studio < ApplicationRecord
  has_many :studio_classes, dependent: :destroy

  validates :name, presence: true
end

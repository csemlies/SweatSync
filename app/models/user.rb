# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  name         :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class User < ApplicationRecord
  has_many :busy_blocks, dependent: :destroy
end

# == Schema Information
#
# Table name: studio_classes
#
#  id         :bigint           not null, primary key
#  class_name :string
#  difficulty :string
#  end_dt     :datetime
#  instructor :string
#  modality   :string
#  scraped_at :datetime
#  source_url :string
#  start_dt   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  studio_id  :bigint
#
# Indexes
#
#  index_studio_classes_on_scraped_at              (scraped_at)
#  index_studio_classes_on_studio_id               (studio_id)
#  index_studio_classes_on_studio_id_and_start_dt  (studio_id,start_dt)
#
# Foreign Keys
#
#  fk_rails_...  (studio_id => studios.id)
#
class StudioClass < ApplicationRecord
  belongs_to :studio

  has_many :recommended_classes, dependent: :destroy

  validates :class_name, :start_dt, :end_dt, presence: true
  validate :end_after_start

  private

  def end_after_start
    return if start_dt.blank? || end_dt.blank?
    errors.add(:end_dt, "must be after start time") if end_dt <= start_dt
  end
end

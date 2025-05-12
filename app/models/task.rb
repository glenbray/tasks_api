class Task < ApplicationRecord
  validates :title, presence: true

  scope :incomplete, -> { where(completed_at: nil) }

  def as_json(options = {})
    super(options.merge(only: [:id, :title, :description, :completed_at]))
  end
end

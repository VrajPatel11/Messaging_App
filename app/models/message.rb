class Message < ApplicationRecord
  attr_accessor :remove_cover_picture
  after_save :purge_cover_picture, if: :remove_cover_picture
  private def purge_cover_picture
    cover_picture.purge_later
  end

  has_one_attached :cover_picture
  belongs_to :user
  validates :body, presence: true
  scope :custom_display, -> { order(:created_at).last(25) }
end

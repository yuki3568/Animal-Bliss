class Video < ApplicationRecord
  validates :url, presence: true, format: { with: URI.regexp(%w[http https]), message: "must be a valid URL" }
  validates :title, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
end

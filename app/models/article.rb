class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  alias_attribute :author, :user

  def author_name
    author.username
  end
end

class Project < ApplicationRecord
  acts_as_taggable

  has_attached_file :preview,
      styles: {
        thumb: {geometry: '400x300#'},
        large: {geometry: '1200>'}
      },
      path: ":rails_root/public/system/:attachment/:id/:style/:filename",
      url: "/system/:attachment/:id/:style/:filename"

  has_many :containers, inverse_of: :project
  accepts_nested_attributes_for :containers, reject_if: :all_blank, allow_destroy: true

  validates :title, :desc, presence: true

  validates_attachment :preview, presence: true,
                                    size: { in: 0..20.megabytes },
                            content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }

  def to_param
    "#{id}-#{title.parameterize}"
  end

  AUTHORS = %w[dima mary].freeze

  def authors=(authors)
    self.authors_mask = (authors & AUTHORS).map { |r| 2**AUTHORS.index(r) }.sum
  end

  def authors
    AUTHORS.reject { |r| ((authors_mask || 0) & 2**AUTHORS.index(r)).zero? }
  end

  def self.with_author(author)
    where('authors_mask & ? > 0', 2**AUTHORS.index(author.to_s))
  end

  def author?(author)
    authors.include? author.to_s
  end
end
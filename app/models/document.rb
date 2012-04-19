class Document < ActiveRecord::Base

  attr_accessible :name, :content, :slug, :tag_list
  validates_presence_of :name, :content, :slug
  validates_uniqueness_of :name, :slug
  
  before_validation :set_default_slug
  
  default_scope :order => 'name'
  
  scope :named, lambda {|name| select("DISTINCT #{table_name}.*").
    joins("LEFT OUTER JOIN taggings ON (taggings.taggable_id = #{table_name}.id AND taggings.taggable_type = 'Document')").
    joins("LEFT OUTER JOIN tags ON taggings.tag_id = tags.id").
    where("#{table_name}.name LIKE ? OR #{table_name}.slug LIKE ? OR tags.name LIKE ?", "%#{name}%", "%#{name}%", "%#{name}%") }
  
  acts_as_taggable
  
  def self.find_by_id_or_slug(id_or_slug)
    where("#{table_name}.id = ? OR #{table_name}.slug = ?", id_or_slug, id_or_slug).first
  end
  
  def self.find_by_id_or_slug!(id_or_slug)
    doc = self.find_by_id_or_slug(id_or_slug)
    raise ActiveRecord::RecordNotFound if doc.nil?
    doc
  end
  
  def to_param
    self.slug.blank? ? self.id.to_s : self.slug
  end
  
  def text_content
    self.content.gsub(/<\/?[^>]*>/, '')
  end

  def set_default_slug
    self.slug = self.name.parameterize if self.slug.blank?
  end

end

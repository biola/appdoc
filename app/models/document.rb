class Document < ActiveRecord::Base

  attr_accessible :name, :content, :slug, :tag_list
  validates_presence_of :name, :content, :slug
  validates_uniqueness_of :name, :slug
  
  before_validation :set_default_slug
  
  default_scope :order => 'name'
  
  scope :named, lambda {|name| select("DISTINCT documents.*").
    joins("LEFT OUTER JOIN taggings ON (taggings.taggable_id = documents.id AND taggable_type = 'Document')").
    joins("LEFT OUTER JOIN tags ON taggings.tag_id = tags.id").
    where("documents.name LIKE ? OR documents.slug LIKE ? OR tags.name LIKE ?", "%#{name}%", "%#{name}%", "%#{name}%") }
  
  search_methods :named
  
  acts_as_taggable
  
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

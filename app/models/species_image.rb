class SpeciesImage < ActiveRecord::Base
  belongs_to      :species
  has_attachment(
    :content_type => :image, :storage => :file_system, 
    :thumbnails => { :small => '40', :medium => '100', :large => '160' },
    :max_size => 5.megabytes, :processor => 'ImageScience'
    )
  validates_as_attachment
  
  def attachment_attributes_valid?
    errors.add_to_base("Uploaded file is too large (5MB max).") if attachment_options[:size] && !attachment_options[:size].include?(send(:size))
    errors.add_to_base("Uploaded file has invalid content.") if attachment_options[:content_type] && !attachment_options[:content_type].include?(send(:content_type))
  end
end

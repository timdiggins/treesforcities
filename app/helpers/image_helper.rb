module ImageHelper
  def species_image_for(species, size=:small)
    return nil unless species.image
    image_tag(
              species.image.public_filename(size),
      :class => "image_#{size}"
    )
  end
  
  
  def link_to_tree_image_for(tree, size=:small)
    link_to tree_image_for(tree, :size=>size), tree
  end
  
  def tree_image_for(tree, size=:small)
    if tree.species
      species_image = species_image_for(tree.species)
    	return species_image if species_image
   end
   if tree.empty_lot?
      return  image_tag('/images/icons/lot.png')
    else 
      return image_tag('/images/icons/tree.png')
    end
  end
  
  
  #  def link_using_main_project_image(project, size=:small, html_options = {}) 
  #    link_to(main_project_image_for(project, size), project, html_options)
  #  end
  
end

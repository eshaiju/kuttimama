ActiveAdmin.register Category do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  action_item only:[:show,:edit] do
   link_to "New category", new_admin_category_path
  end
  controller do
    def permitted_params
      params.permit category: [:name, :status]
    end
  end
  
end

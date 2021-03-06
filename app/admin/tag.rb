ActiveAdmin.register Tag do

  
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
   link_to "New tag", new_admin_tag_path
  end

  form do |f|
    f.inputs "Tags" do
      f.semantic_errors *f.object.errors.keys
      f.input :title,:as=>:string
      f.input :status, :as => :string
    end
    f.actions
  end

   controller do
    def permitted_params
      params.permit tag: [:title, :status]
    end

     def tags_list
       render :json => Tag.all.collect {|tag| {:id => tag.id,:name => "#{tag.title}" }}
     end
  end
end

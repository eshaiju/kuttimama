ActiveAdmin.register Movie do
  menu :prioriy => 3
  
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
   link_to "New movie", new_admin_movie_path
  end
  form do |f|
    f.inputs "Movie Details" do
      f.semantic_errors *f.object.errors.keys
      f.input :title, :as => :string
      f.input :year, :as => :string
      f.input :actors, :as => :string
      f.input :status, :as => :string
    end
    f.actions
  end

controller do
    def permitted_params
      params.permit movie: [:title,:year,:actors,:status]
    end
  end
end


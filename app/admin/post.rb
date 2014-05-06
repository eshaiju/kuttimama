ActiveAdmin.register Post do
  menu :priority => 1
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :category=>[:name,:status]
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
   index do
    selectable_column
    column :title do |post|
      link_to post.title,admin_post_path(post)
    end
    column "Image" do |post|
      link_to(image_tag(post.image.url(:thumb)))
    end
    column :movie
    column :category
    column :tag
    actions
  end

  show do |contact|
    columns do
      column do
        attributes_table do
          row :id
          row :title
          row "Image" do |post|
            link_to(image_tag(post.image.url(:thumb)))
          end
          row :movie
          row :category
          row :tag
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Post Details" do
      f.semantic_errors *f.object.errors.keys
      f.input :title, :as => :string
      f.input :image
      f.input :movie, :as => :select,:collection => Movie.all 
      f.input :category, :as => :select,:collection => Category.all
      f.input :tag,:as => :select,:collection => Tag.all
    end
    f.actions
  end

   controller do
    def permitted_params
      params.permit post: [:title,:movie_id,:category_id,:tag_id,:image,:status]
    end
  end
end


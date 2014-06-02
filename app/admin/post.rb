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


  action_item only:[:show] do
   link_to "New post", new_admin_post_path
  end

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
    column :tags do |post|
            post.tags.map{|t| t.title}.join(', ')
          end
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
          row :tags do |post|
            post.tags.map{|t| t.title}.join(', ')
          end
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
      f.input :movie, :as => :select,:collection => Movie.all , :input_html => { :class => "chosen-input" }
      f.input :category, :as => :select,:collection => Category.all, :input_html => { :class => "chosen-input" }
      f.input :tags,:as => :string, multiple: true, :input_html => { :class => "e12" , :value =>resource.tags.map{|t| t.title}.join(', ')}
    end
    f.actions
  end

  before_save do
    if params[:post][:tags].present?
      tag_titles = params[:post][:tags].split(',')
      tags = []
      tag_titles.each do | tag_title|
         tag = Tag.find_by_title(tag_title)
        if tag.blank?
          tag = Tag.create(:title => tag_title )
        end
        tags << tag.id
      end
    end
    resource.tag_ids = tags

    if params[:post][:movie_id]
      movie = Movie.find_by_title(params[:post][:movie_id])
      if movie.blank?
        movie = Movie.create(:title => params[:post][:movie_id] )
      end
      resource.movie_id = movie.id
    end
  end


  controller do
    def permitted_params
      params.permit post: [:title,:movie_id,:category_id,:image,:status,tag_ids:[]]
    end
  end
end


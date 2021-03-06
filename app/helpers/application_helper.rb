module ApplicationHelper
  
  def collection_for_categories
    Category.ordered.map{ |c| [c.name, c.id] }
  end

  def render_new_petition_link(options = {})
    options[:data] = { :toggle => "modal" }
    if user_signed_in?
      link_to "發起連署", "#petition-start-up", options
    else
      link_to "發起連署", "#sign-up", options
    end
  end

  def render_user_avatar(user, px)
    link_to user_path(user.id) do
      image_tag user.pic_url(px)
    end
  end

  def render_user_name(user)
    link_to "#{user.name}", user_path(user.id)
  end

end

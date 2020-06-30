module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id, caller: @caller), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id, caller: @caller), method: :post)
    end
  end

  def current_user_link
    return tag.div(link_to(current_user.name, user_path(current_user)), class: 'menu-item') if current_user

    nil
  end

  def sign_out_link
    return tag.div(link_to('Sign out', destroy_user_session_path, method: :delete), class: 'menu-item') if current_user

    nil
  end

  def sign_in_link
    return tag.div(link_to('Sign in', user_session_path), class: 'menu-item') unless current_user

    nil
  end

  def notice_message(notice)
    return tag.div(tag.p(notice), class: 'notice') if notice.present?

    nil
  end

  def alert_message(alert)
    return tag.div(tag.p(alert), class: 'alert') if alert.present?

    nil
  end
end

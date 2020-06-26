module UsersHelper
  def friendship_links(user, outer_status, inner_status)
    fl = []
    unless user == current_user
      if outer_status.nil?
        fl = outer_status_nil(user, inner_status)
      elsif outer_status.zero?
        fl << link_to('Accept', friendship_path(id: user.id, accept: true, caller: 'index'), method: :patch, class: 'profile-link accept')
        fl << link_to('Reject', friendship_path(id: user.id, accept: false, caller: 'index'), method: :patch, class: 'profile-link reject')
      elsif (outer_status == 1) || (outer_status == -1)
        fl = []
      end
    end
    fl
  end

  def outer_status_nil(user, inner_status)
    fl = []
    fl << link_to('Invite', friendships_path(user, caller: 'index'), method: :post, class: 'profile-link') if inner_status.nil?
    fl
  end

  def friendship_state(user, outer_status, inner_status)
    ft = []
    unless user == current_user
      ft = outer_status_state(outer_status)
      ft = inner_status_state(inner_status) if ft.nil?
    end
    ft
  end

  def outer_status_state(outer_status)
    ft = []
    case outer_status
    when 1
      ft << { class: 'friends', text: 'Friends' }
    when -1
      ft << { class: 'reject', text: 'Rejected' }
    when 0
      ft = []
    else
      ft = nil
    end
    ft
  end

  def inner_status_state(inner_status)
    ft = []
    case inner_status
    when 1
      ft << { class: 'friends', text: 'Friends' }
    when -1
      ft << { class: 'reject', text: 'User Rejected' }
    when 0
      ft << { class: 'pending', text: 'Pending' }
    end
    ft
  end
end

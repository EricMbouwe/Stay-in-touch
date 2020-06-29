module UsersHelper
  def friendship_links(user, outer_status, inner_status)
    fl = []
    unless user == current_user
      if outer_status.nil?
        fl = outer_status_nil(user, inner_status)
      elsif outer_status.zero?
        fl = outer_status_zero(user)
      elsif (outer_status == 1)
        # can_c = 'profile-link cancel'
        # path = friendship_path(id: user.id, accept: false, caller: 'index')
        # fl << link_to('Cancel', path, method: :delete, class: can_c)
      elsif (outer_status == -1)
        #path = friendship_path(id: user.id, accept: true, caller: 'index')
        #fl << link_to('Accept', path, method: :patch, class: 'profile-link accept')
        #path = friendship_path(id: user.id, caller: 'index')
        #fl << link_to('Pend', path, method: :delete, class: 'profile-link pending')
      elsif inner_status = 0
        
      end
    end
    fl
  end

  def friendship_state(user, outer_status, inner_status)
    ft = []
    unless user == current_user
      ft = outer_status_state(user, outer_status)
      ft = inner_status_state(inner_status) if ft.nil?
    end
    ft
  end

  def profile_link(user)
    return link_to('See Profile',  user_path(user), class: 'profile-link') if current_user.friend_or_me?(user)
    tag.p('See Profile', class: 'profile-link gray')
  end

  def friend_link(user)
    return link_to(user.name,  user_path(user), class: 'blue') if current_user.friend_or_me?(user)
    user.name
  end

  private

  def outer_status_zero(user)
    fl = []
    acc = 'Accept'
    acc_c = 'profile-link accept'
    rej_c = 'profile-link reject'
    rej = 'Reject invitation from ' + user.name
    acc_path = friendship_path(id: user.id, accept: true, caller: 'index')
    rej_path = friendship_path(id: user.id, accept: false, caller: 'index')
    fl << link_to(acc, acc_path, method: :patch, class: acc_c)
    fl << link_to(rej, rej_path, method: :patch, class: rej_c)
    fl
  end

  def outer_status_nil(user, inner_status)
    fl = []
    fl << link_to('Invite', friendships_path(user, caller: 'index'), method: :post, class: 'profile-link') if inner_status.nil?
    fl
  end

  def outer_status_state(user, outer_status)
    ft = []
    case outer_status
    when 1
      ft << tag.label('Friends', class: 'friends')
    when -1
      ft << tag.label('Rejected', class: 'reject')
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
      ft << tag.label('Friends', class: 'friends')
    when -1
      ft << tag.label('Denied', class: 'reject')
    when 0
      ft << tag.label('Pending', class: 'pending')
    end
    ft
  end
end

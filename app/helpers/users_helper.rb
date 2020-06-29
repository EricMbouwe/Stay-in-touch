module UsersHelper
  def friendship_links(user, outer_status, inner_status, container_class, caller)
    fl = []
    unless user == current_user
      if outer_status.nil?
        fl = outer_status_nil(user, inner_status, container_class, caller)
      elsif outer_status.zero?
        apath = friendship_path(id: user.id, accept: true, caller: caller)
        rpath = friendship_path(id: user.id, accept: false, caller: caller)
        alink = link_to('Accept', apath, method: :patch, class: 'accept')
        rlink = link_to('Reject', rpath, method: :patch, class: 'reject')
        fl << tag.span(alink, class: container_class) << tag.span(rlink, class: container_class)
      end
    end
    fl
  end

  def friendship_state(user, outer_status, inner_status, container_class)
    ft = []
    unless user == current_user
      ft = outer_status_state(outer_status, container_class)
      ft = inner_status_state(inner_status, container_class) if ft.nil?
    end
    ft
  end

  def profile_link(user)
    tag.span(link_to('See Profile', user_path(user), class: 'link'), class: 'profile-link')
  end

  def friend_link(user)
    return link_to(user.name, user_path(user), class: 'blue') if current_user.friend_or_me?(user)

    user.name
  end

  def pending_friends_caption(count, current_user, user)
    is_current_user = current_user == user
    c_wait = "You don't wait friendship confirmation from any user"
    o_wait = user.name + " doesn't wait friendship confirmation from any user"
    no_invites = is_current_user ? c_wait : o_wait
    invites_users = (count == 1 ? ' user :' : ' users :')
    c_wait = 'You are waiting friendship confirmation from ' + count.to_s + invites_users
    o_wait = user.name + ' is waiting friendship confirmation from ' + count.to_s + invites_users
    invites = is_current_user ? c_wait : o_wait
    count.zero? ? no_invites : invites
  end

  def friend_requests_caption(count, current_user, user)
    is_current_user = current_user == user
    c_wait = 'No users are waiting friendship confirmation from you'
    o_wait = 'No users are waiting friendship confirmation from ' + user.name
    no_invites = is_current_user ? c_wait : o_wait
    invites_users = (count == 1 ? ' user is' : ' users are')
    c_wait = count.to_s + invites_users + ' waiting friendship confirmation from you'
    o_wait = count.to_s + invites_users + ' waiting friendship confirmation from ' + user.name
    invites = is_current_user ? c_wait : o_wait
    count.zero? ? no_invites : invites
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

  def outer_status_nil(user, inner_status, container_class, caller)
    fl = []
    ilink = link_to('Invite', friendships_path(user, caller: caller), method: :post, class: 'link')
    span = tag.span(ilink, class: container_class)
    fl << span if inner_status.nil?
    fl
  end

  def outer_status_state(outer_status, container_class)
    ft = []
    case outer_status
    when 1
      ft << tag.span(tag.label('Friends', class: 'friends'), class: container_class)
    when -1
      ft << tag.span(tag.label('Rejected', class: 'reject'), class: container_class)
    when 0
      ft = []
    else
      ft = nil
    end
    ft
  end

  def inner_status_state(inner_status, container_class)
    ft = []
    case inner_status
    when 1
      ft << tag.span(tag.label('Friends', class: 'friends'), class: container_class)
    when -1
      ft << tag.span(tag.label('User Rejected', class: 'reject'), class: container_class)
    when 0
      ft << tag.span(tag.label('Pending', class: 'pending'), class: container_class)
    end
    ft
  end
end

module UsersHelper
  def friendship_links(user, outer_status, inner_status)
    fl = []
    unless user == current_user
      if outer_status.zero?
        fl << link_to('Accept', friendship_path(id: user.id, accept: true, caller: 'index'), method: :patch, class: 'profile-link accept')
        fl << link_to('Reject', friendship_path(id: user.id, accept: false, caller: 'index'), method: :patch, class: 'profile-link reject')
      elsif (outer_status == 1) || (outer_status == -1)
        fl = []
      elsif inner_status.nil?
        fl << link_to('Invite', friendships_path(user, caller: 'index'), method: :post, class: 'profile-link')
      end
    end

    fl
  end

  def friendship_state(user, outer_status, inner_status)
    ft = []
    unless user == current_user
      case outer_status
      when 1
        ft << { class: 'friends', text: 'Friends' }
      when -1
        ft << { class: 'reject', text: 'Rejected' }
      when 0
        ft = []
      else
        case inner_status
        when 1
          ft << { class: 'friends', text: 'Friends' }
        when -1
          ft << { class: 'reject', text: 'User Rejected' }
        when 0
          ft << { class: 'pending', text: 'Pending' }
        end
      end
    end

    ft
  end

  def get_friendships_status(id1, id2)
    status = nil
    fr = Friendship.find_by(user_id: id1, friend_id: id2)
    if fr
      status = 'Pending' if fr.status.zero?
      status = 'Friends' if fr.status == 1
      status = @user.name + ' Rejected Friendship' if fr.status == -1
    else
      fr = Friendship.find_by(user_id: id2, friend_id: id1)
      if fr
        status = 'Deciding' if fr.status.zero?
        status = 'Friends' if fr.status == 1
        status = 'I Rejected Friendship' if fr.status == -1
      end
    end
    status
  end

end

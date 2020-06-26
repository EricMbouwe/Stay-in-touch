module UsersHelper

  def friendship_links(user, outer_status, inner_status)
    fl = []
    unless user == current_user
      if outer_status == 0
        fl << link_to('Accept', friendship_path(id: user.id, accept: true, caller: 'index' ), method: :patch, class: 'profile-link accept')
        fl << link_to('Reject', friendship_path(id: user.id, accept: false, caller: 'index' ), method: :patch, class: 'profile-link reject')
      elsif (outer_status == 1) || (outer_status == -1)
      # elsif (outer_status == -1)
        # fl << link_to('Accept', friendship_path(id: user.id, accept: true, caller: 'index' ), method: :patch, class: 'profile-link accept')
      # elsif (inner_status == -1)
        # fl << link_to('reinvite', friendships_path(user, caller: 'index', again: true ), method: :post, class: 'profile-link')  
      elsif inner_status.nil?
        fl << link_to('Invite', friendships_path(user, caller: 'index' ), method: :post, class: 'profile-link')
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
        else
          case inner_status
            when 1
              ft << {class: 'friends', text: 'Friends'}
            when -1
              ft << {class: 'reject', text: 'User Rejected'}
            when 0
              ft << {class: 'pending', text: 'Pending'}
          end
      end
    end

    ft
  end
end
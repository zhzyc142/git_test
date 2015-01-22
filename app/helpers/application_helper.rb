module ApplicationHelper
    def get_user_action_class(user_action)
    case
    when user_action.is_default
      "info"
    when user_action.is_self
      "success"
    else
      ""
    end
  end
end

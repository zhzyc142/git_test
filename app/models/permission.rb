# -*- encoding : utf-8 -*-
class Permission < ActiveRecord::Base
  has_and_belongs_to_many :users
  scope :default, -> { where(is_default: true) }
  class << self
    def actions_under_control
      Permission.available_actions - Permission.default_actions
    end
  
    def refresh!
      actions_from_code.flatten.each do |action|
        a = find_or_create_by_action_and_subject(action[:action],action[:subject])
      end
    end
  end
  
  private
  class << self
    def default_actions
      Permission.find_all_by_as_default(true)
    end
  
    def available_actions
      Permission.find_all_by_as_available(true)
    end
  
    def actions_from_code
      results = []
      UserController.all.each do |controller|
        results << controller.constantize.action_methods_with_fullname
      end
      return results - [[]]
    end
  end
end

class UserController
  def self.all
    controllers = Dir.new("#{Rails.root}/app/controllers").entries
    result = []
    controllers.each do |controller|
      if controller =~ /_controller/
        controller = controller.camelize.gsub(".rb", "")
        result << controller
      end
    end
    return result
  end
end

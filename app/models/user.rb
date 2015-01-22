# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  has_and_belongs_to_many :permissions
end

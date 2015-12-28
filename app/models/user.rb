class User < ActiveRecord::Base
  include Clearance::User

  has_many :workouts, inverse_of: :user
end

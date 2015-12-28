class WorkoutsController < ApplicationController
  def index
    if current_user
      @workouts = Workout.where(user_id: current_user.id).includes(:exercises)
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end
end

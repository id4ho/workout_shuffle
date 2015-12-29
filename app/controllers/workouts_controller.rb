class WorkoutsController < ApplicationController
  before_action :require_login
  before_action :set_workout, only: [:show, :destroy]

  def index
    @workouts = current_user.workouts.includes(:exercises)
  end

  def show
  end

  def new
    @workout = Workout.generate_workout(workout_size + 3)
    @swaps = @workout.exercises.take(3)
    @workout.exercises = @workout.exercises.last(workout_size)
  end

  def create
    workout = current_user.workouts.new(workout_params)
    workout.exercises << Exercise.where(id: params[:exercise_ids])

    if workout.save
      render js: "window.location = '#{ workout_path(workout.to_param) }'"
    else
      render json: workout.errors.full_messages.to_json
    end
  end

  def destroy
    @workout.destroy
    respond_to do |format|
      format.html { redirect_to workouts_url, notice: 'Workout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def workout_size
    Workout::STANDARD_SIZE
  end

  def workout_params
    params.require(:workout).permit(:name)
  end

  def set_workout
    @workout = current_user.workouts.find_by_id(params[:id])
    head 403 unless @workout
  end
end

## Workout Shuffle

This is a workout generator. Ever get to the gym and waste time deciding what to
do? Or worse yet avoid going to the gym entirely because you don't have a plan?
This app is intended to solve that problem (at least for me).

### Exercises
There are a handful of exercises preloaded in the seed.rb file. They exists in
two flavors: `CardioExercise` and `ResistanceExercise`. Exercises loaded in the
seed file target many `muscle_groups` though the `muscle_targets` association
model.

### Muscle Groups
All of the major muscle groups are represented in the seed.rb file. The idea is
to generate a workout that will hit many different muscle groups.

### Workout
Workouts are intended to take around 30 minutes and are thus comprised of one
`CardioExercise` and 6 `ResistanceExercise`s. When you generate a workout the
app will randomly select a Cardio exercise and the resistance exercises taking
care to not overload one major muscle groups (you'd never get Dumbbell curls and
Barbell Curls for instance). If there is an exercise that you don't like or that
you don't have the equipment for, you may click a link and swap that exercise
out for another random exercise (only `ResistanceExercise`s may be swapped at
this time)


TO DO:
There are many little missing features at the moment:
- the 403 returned when someone requests something they don't have access to
  needs to have a form and a friendlier message
- the workout form is a little weird.. i want to generate the model but then do
  an ajax call to submit it.. it may be better to have a hidden form and adjust
  the parameters for that hidden form when the user swaps out exercises. this
  would also solve the multiple response types for the WorkoutController#create
  action
- the createWorkoutPage.js needs capybara coverage and many some unit tests
  through jasmine as well
- Allow exercises to have more than one primary muscle target (squats for
  instance need more than 1)
- Make better use of FactoryGirl, figure out how to set up a lot of data quickly
  when needed

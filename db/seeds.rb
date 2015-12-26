# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

muscle_groups = [
  ["Abs", "Abdominal - Stomach"],
  ["Biceps", "Biceps - Upper Arms (front)"],
  ["Forearm (topside)", "Brachioradialis - Front-facing upper forearm"],
  ["Forearm (outside)", "Flexor digitorum superficialis - Top of the forearm facing away from body"],
  ["Forearm (inner)", "Flexor carpi radialis and ulnaris and Palmaris longus - Inner-facing underside of the forearm"],
  ["Deltoids", "Deltoids - Shoulders"],
  ["Lower Back", "Erector Spinae"],
  ["Calves", "Gastrocnemius and Soleus"],
  ["Glutes", "Gluteus Maximus - Buttocks"],
  ["Hamstrings", "Hamstrings - Thigh (back)"],
  ["Upper Back", "Latissimus Dorsi and Rhomboids - Upper back"],
  ["Side Body", "Obliques - Side of body"],
  ["Chest", "Pectoralis major - Chest"],
  ["Quads", "Quadricepts - Thigh (front)"],
  ["Traps", "Trapezius - Lower Neck"],
  ["Triceps", "Triceps - Upper arms (back)"],
]

muscle_group_ids = {}

muscle_groups.each do |name, long_name|
  muscle_group_ids[name] = MuscleGroup.create(name: name, long_name: long_name).id
end

exercises = [
  {
    name: "Russian Twists",
    description: <<DESC,
Sit on a mat or the floor with your legs together and your hips and knees both
at a 90 degree angle. Slowly lift your feet of the ground balancing on your
buttocks (you may cross your feet if you like). Then with hands together and
rotate your torso so that your upper body faces the left (your elbow should
rotate behind your back). Return to center and do the opposite side. Rotating
left and right counts as 1 repetition.
DESC
    reps: 20,
    sets: 3,
    muscle_groups: ["Abs", "Side Body"],
  },
  {
    name: "Planks",
    description: <<DESC,
Start from a modifed push up position with toes and elbows on the floor and back
straight.
DESC
    sets: 3,
    duration: 45,
    muscle_groups: ["Abs"],
  },
  {
    name: "Dumbbell Curls",
    description: <<DESC,
Start standing with arms hanging at your sides and a dumbbell in each hand
so that your palms face forward. Keeping your upper arms pressed against
your torso, alternately raise each dumbbell to it's respective shoulder.
One repetition involves curling each arm once. If you find it necessary
to swing to lift the weight, try using lighter dumbbells.
DESC
    sets: 3,
    reps: 10,
    muscle_groups: ["Biceps"],
  },
  {
    name: "Dumbbell Hammer Curls",
    description: <<DESC,
Start standing with arms hanging at your sides and a dumbbell in each hand
so that your palms face inwards toward eachother. Keeping your upper arms
pressed against your torso, alternately raise each dumbbell to it's respective
shoulder. One repetition involves curling each arm once. If you find it
necessary to swing to lift the weight, try using lighter dumbbells.
DESC
    sets: 3,
    reps: 10,
    muscle_groups: ["Biceps", "Forearm (topside)"],
  },
  {
    name: "Forearm Curls",
    description: <<DESC,
Start seated on a bench with a dumbbell in one hand. Place the elbow of the
arm with the dumbbell on the corresponding knee. The palm of your hand should
be facing the floor. Let your wrist go limp and the slowly raise the dumbbell
using only your wrist as high as you can. Slowly let it back down. Do all of
the reps for one set in this hand and then switch hands.
DESC
    sets: 3,
    reps: 12,
    muscle_groups: ["Forearm (outside)"],
  },
  {
    name: "Deadhangs",
    description: <<DESC,
Get a good grip on the pullup bar and hang for the duration of the set. Keep
your arms straight but focus on keeping your shoulders internally rotated.
('internally rotated' is the position of the shoulder achieved when holding
your arm straight out in front of your body with your palm facing the floor and
rotating the elbow down)
DESC
    sets: 3,
    duration: 40,
    muscle_groups: ["Forearm (inner)", "Forearm (outside)"],
  },
  {
    name: "Pushups",
    description: <<DESC,
To reduce the strain put on the shoulder and elbow during pushups, please use
proper technique. Place your hands flat on the ground at or a little below the
chest. When lowering keep your forearms perpendicular (straight up and down)
to the ground and keep your elbows close to your side, brushing against the
torso if possible.
DESC
    sets: 3,
    reps: 12,
    muscle_groups: ["Deltoids", "Triceps", "Chest"],
  },
  {
    name: "Supermans",
    description: <<DESC,
Lay on the floor or a mat with your arms outstreched above your head (as if you
are flying a la Superman). Each rep, arch your back lifting your legs, arms and
part of your chest off the ground and hold for 3-5 seconds.
DESC
    sets: 3,
    reps: 10,
    muscle_groups: ["Lower Back"],
  },
  {
    name: "Calf raises",
    description: <<DESC,
Begin standing near a wall or pole that you can keep a hand on for balance.
Each rep, rock your weight onto your toes, fully extending your ankle. If doing
both legs at once is too easy, use only one leg at a time.
DESC
    sets: 3,
    reps: 20,
    muscle_groups: ["Calves"],
  },
  {
    name: "Lunges",
    description: <<DESC,
Begin standing with a dumbbell in each hand. Take a large step and lower your
body until the knee of your trailing leg is just above the ground (do not bang
your knee on the ground!) then lift yourself back up to standing and alternate
legs. You can do this in a small area if you push yourself back up to the
original starting position after each rep, or if you have more space you can
move forward with each step.
DESC
    sets: 3,
    reps: 10,
    muscle_groups: ["Glutes", "Quads"],
  },
  {
    name: "Running",
    description: <<DESC,
Build up speed and distance slowly if you don't run often. Warning: If you
don't run often but are in decent shape, you will have a tendency to overdo
it and injure yourself.
DESC
    duration: 5.minutes,
    muscle_groups: ["Hamstrings", "Calves", "Glutes"],
    type: "Exercises::CardioExercise"
  },
  {
    name: "Jump Rope",
    description: <<DESC,
One rotation, one jump. Try to do it without stopping. If you hit your feet
just try again for the duration of the exercise.
DESC
    duration: 5.minutes,
    muscle_groups: ["Calves", "Deltoids"],
    type: "Exercises::CardioExercise"
  },
  {
    name: "Cycling",
    description: <<DESC,
Using a stationary bike, pedal at medium resistance and a high cadence (rpm) of
80-100.
DESC
    duration: 5.minutes,
    muscle_groups: ["Quads", "Glutes", "Calves"],
    type: "Exercises::CardioExercise"
  },
  {
    name: "Pullups",
    description: <<DESC,
Start from a dead hang with palms facing straight ahead and lift your body
until your chin is above the bar. Aim for full extension but keep your
shoulders internally rotated to protect them. If this is too difficult start
from the chin above the bar position and lower yourself as slowly as possible
to a deadhang (these are called negative reps).
DESC
    sets: 3,
    reps: 8,
    muscle_groups: ["Upper Back",
                    "Biceps",
                    "Deltoids",
                    "Forearm (inner)",
                    "Forearm (topside)",
                    "Abs"],
  },
  {
    name: "Dumbbell Press",
    description: <<DESC,
This is like bench press but with two dumbbells instead of a barbell. Sit on
the end of the bench and put the dummbells on your thighs. Slowly move the
dumbbells towards your chest while rolling back until you're laying on the
bench. Keeping the dumbbells above your chest push them into the air until your
arms are straight.
DESC
    sets: 3,
    reps: 10,
    muscle_groups: ["Chest", "Triceps", "Deltoids"],
  },
  {
    name: "Leg Extensions",
    description: <<DESC,
Using a leg extension machine, start with legs bent and lift the padded bar
with both legs until straight. Hold momentarily at the top before lowering.
DESC
    sets: 3,
    reps: 12,
    muscle_groups: ["Quads"],
  },
  {
    name: "Shoulder Shrugs",
    description: <<DESC,
Start standing with a dumbbell in each hand. Lift your shoulders slowly towards
your ears keeping your arms straight.
DESC
    sets: 3,
    reps: 10,
    muscle_groups: ["Traps"],
  },
]

exercises.each do |e_hash|
  e = Exercise.create(
    name: e_hash[:name],
    description: e_hash[:description],
    sets: e_hash[:sets],
    reps: e_hash[:reps],
    duration: e_hash[:duration]
  )

  e_hash[:muscle_groups].each do |mg_name|
    e.muscle_targets.create(muscle_group_id: muscle_group_ids[mg_name])
  end
end

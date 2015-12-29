var workoutCreatePage = {
  init: function(options) {
    this.submitPath = options.submitPath;
    $('.swap-exercise-link').on('click', this.replaceExerciseAndCheckSwaps);
    $('#create-workout').on('click', this.submitExercise);
  },

  submitExercise: function() {
    var exerciseList = workoutCreatePage.getExerciseIds();

    $.ajax({
      url: workoutCreatePage.submitPath,
      method: 'POST',
      data: {
        'workout': { 'name': 'whatever5' },
        'exercise_ids': exerciseList
      }
    });
  },

  replaceExerciseAndCheckSwaps(event) {
    workoutCreatePage.replaceExercise(event);
    workoutCreatePage.checkSwaps();
  },

  getExerciseIds: function() {
    return $('.exercise-row').toArray().map(function(exercise) {
      if (!exercise.hidden) {
        return exercise.getAttribute('data-id');
      }
    }).filter(Boolean); // filters the undefineds
  },

  replaceExercise: function(event) {
    var targetRow = $(event.target).parents('.exercise-row')
    var swapRow = $(this.nextSwapRow());

    this.swapRows(targetRow, swapRow);
    this.updateSwapsLeftMessage();
  },

  swapRows: function(rowToBeReplaced, newRow) {
    var rowIndex = rowToBeReplaced[0].rowIndex;

    this.placeRowAtIndex(newRow, rowIndex);
    rowToBeReplaced.remove();
  },

  checkSwaps: function() {
    if (this.swapRowsRemaining().length == 0) {
      this.removeSwapLinks();
    }
  },

  removeSwapLinks: function() {
    $('.swap-exercise-link').prop('hidden', true)
  },

  updateSwapsLeftMessage: function() {
    var swapMessage = $('#swap-count')
    var swapsLeft = this.swapRowsRemaining().length;

    if (swapsLeft > 1) {
      swapMessage.text(swapsLeft + ' exercise');
    } else if (swapsLeft == 1) {
      swapMessage.text('an exercise');
    } else {
      swapMessage.parent().text("No more swaps! Just do it!");
    }
  },

  placeRowAtIndex: function(row, index) {
    this.table().eq(index - 1).after(row);
    row.prop('hidden', false);
  },

  table: function() {
    return $('#workout-create-table > tbody > tr')
  },

  nextSwapRow: function() {
    return this.swapRowsRemaining()[0];
  },

  swapRowsRemaining: function() {
    return $('.exercise-row[hidden]')
  }
}

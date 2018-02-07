class UpdateGrade

  constructor: ->
    $('.select2').on 'change', (event) =>
    new_grade = $(event.target).val()
    grade_id = new_grade.closest('.js-grade').data('id')

    $.ajax
      url:      "/course/evaluation/grades/#{grade_id}"
      method:   'patch'
      dataType: 'json'
      data:
        grade: new_grade
      success: () =>
        @snackbar('success')

  snackbar: (status) ->
    if status == 'success' 
      content: "<%= t(:success) %>",
      style:   'callout callout-success bg-green',
      timeout: 10000

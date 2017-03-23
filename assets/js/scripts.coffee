$ ->
  submitForm = (method, opMethod) ->
    console.log ($("##{opMethod}").removeAttr('placeholder'))
    $("##{opMethod}").val('')

    key = $('#shift :selected').text()
    cipher = $("##{method}").val()

    $.ajax "/#{method}",
      type: 'POST'
      data: { 'cipher': cipher, 'key': key }
      success: (data) ->
        $("##{opMethod}").val(data)

  $('#encrypt-submit').click (event) ->
    event.preventDefault()
    method = $(this).attr('data-m')
    opMethod = $(this).attr('data-opm')
    submitForm(method, opMethod)

  $('#decrypt-submit').click (event) ->
    event.preventDefault()
    method = $(this).attr('data-m')
    opMethod = $(this).attr('data-opm')
    submitForm(method, opMethod)

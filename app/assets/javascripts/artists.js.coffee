$('#select-artists').multiSelect({
  keepOrder: true;
  afterSelect: (values) ->
    $('#artists').val($('#artists').val() + values[0] + ',')
  afterDeselect: (values) ->
    $('#artists').val($('#artists').val().replace(values[0] + ',', ''))
})

$('#check-artists').click ->
  if $(@).is(':checked')
    $('#select-artists').parent().removeClass('hide')
  else
    $('#select-artists').parent().addClass('hide')

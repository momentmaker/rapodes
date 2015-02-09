$('#select-artists').multiSelect({
  keepOrder: true;
  afterSelect: (values) ->
    debugger
  afterDeselect: (values) ->
    debugger
})

$('#check-artists').click ->
  if $(@).is(':checked')
    $('#select-artists').parent().removeClass('hide')
  else
    $('#select-artists').parent().addClass('hide')

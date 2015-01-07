$ ->
  form = new ImageConvertFormView
    logsElem: $("div.logs")

  form.render().$el.appendTo $("div.form")

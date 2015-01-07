class ImageConvertFormView extends Backbone.View
  tagName: "form"
  events:
    "submit" : "onSubmit"

  initialize: ({@logsElem}) ->

  render: ->
    @$el.html """
      ファイル: <input class="file" type="file" value="ファイルを選択してください"><br>
      <input type="submit" value="変換処理実施">
    """

    this

  onSubmit: (e) ->
    e.preventDefault()

    data =
      source:  @$("input.file").val()
      log: (data) =>
        @logsElem.html "#{@logsElem.html()}<br>#{data}"

    return console.log "no file!" unless data.source?

    (new ImageConverter data).process()

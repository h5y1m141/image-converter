{spawn}     = require "child_process"
{platform}  = require "os"
{chmodSync} = require "fs"


class ImageConverter
  constructor: ({@source,@log}) ->
    @source = @source.split(";")  

    switch platform()
      when "darwin"
        @pathToBin = "vendor/bin/osx/convert"
        @profile = "vendor/bin/osx/JapanColor2011Coated.icc"
      when "win32"
        @pathToBin = "vendor/bin/win32/convert.exe"
        @profile = "vendor/bin/win32/JapanColor2011Coated.icc"

    # binary may not be executable due to zip compression..
    chmodSync @pathToBin, 755

  process: ->

    @log "画像一括処理中です"
    _.each(@source, (file, index)  =>
      @child = spawn @pathToBin, [file, "-profile", @profile,"-colorspace","cmyk","/Users/hoyamada/Desktop/#{index}.jpg"]

      @child.stdout.on "data", (data) =>
        @log "#{data}"

      @child.stderr.on "data", (data) =>
        @log "ERROR: #{data}"

      @child.on "exit", (code) =>
        @log "画像一括処理が終了しました。"

    )


window.addEventListener "load", ->
  CloudinaryImageUploader.CLOUD_NAME = "hzby6i3az"
  CloudinaryImageUploader.UPLOAD_PRESET = "sfhjh1ev"
  ContentTools.IMAGE_UPLOADER = (dialog) ->
    return CloudinaryImageUploader.createImageUploader(dialog)

  editor = undefined
  ContentTools.StylePalette.add []

  editor = ContentTools.EditorApp.get()
  editor.init ".editable", "data-name"

  editor.bind "save", (regions) ->
    editor.busy(true)

    payload = new FormData
    for name of regions
      if regions.hasOwnProperty(name)
        content_text = regions[name]
          .replace(/[\n\r]/g, "")
          .replace(RegExp("  +", "g"), "")

        payload.append name, content_text

    onStateChange = (ev) ->
      if ev.target.readyState == 4
        editor.busy(false)

        if ev.target.status == 200
          new ContentTools.FlashUI("ok")
        else
          new ContentTools.FlashUI("no")
      return

    certificate_wrapper = document.getElementById("certificate_wrapper")
    xhr = new XMLHttpRequest
    xhr.overrideMimeType("application/json")
    xhr.addEventListener "readystatechange", onStateChange
    xhr.open "POST", certificate_wrapper.dataset.source
    xhr.send payload

module.exports =
class ShowIndentView
  constructor: (serializeState) ->
    # Create the show-indent div
    @element = document.createElement('div')
    @element.classList.add('show-indent')

    # Create the message div
    message = document.createElement('div')
    message.classList.add('message')

    @element.appendChild(message)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  updateIndent: ->
    editor = atom.workspace.getActiveTextEditor()
    if (editor)
      softtabs = editor.getSoftTabs()
      length = editor.getTabLength()
      @setText(softtabs, length)

  setText: (soft, length) ->
    # Set the message text
    if (soft)
      text = "Spaces: "
    else
      text = "Tabs: "
    @element.children[0].textContent = text + length

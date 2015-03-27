ShowIndentView = require './show-indent-view'
{CompositeDisposable} = require 'atom'

module.exports = ShowIndent =
  showIndentView: null
  bottomPanel: null
  observer: null

  activate: (state) ->
    statusBar = document.querySelector('status-bar')

    if statusBar?
      # Create the view and add the new element to the bottom panel.
      @showIndentView = new ShowIndentView(state.showIndentViewState)
      @bottomPanel = atom.workspace.addBottomPanel(item: @showIndentView.getElement())
      # Call updateIndent to set the initial text.
      @showIndentView.updateIndent()

      @listen()

  deactivate: ->
    @bottomPanel.destroy()
    @showIndentView.destroy()
    @observer.dispose()

  serialize: ->
    showIndentViewState: @showIndentView.serialize()

  listen: ->
    @observer = atom.workspace.observeTextEditors (editor) =>
      disposable = atom.workspace.onDidChangeActivePaneItem =>
            @showIndentView.updateIndent()
      editor.onDidDestroy -> disposable.dispose()

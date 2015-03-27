ShowIndentView = require './show-indent-view'
{CompositeDisposable} = require 'atom'

module.exports = ShowIndent =
  showIndentView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @showIndentView = new ShowIndentView(state.showIndentViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @showIndentView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'show-indent:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @showIndentView.destroy()

  serialize: ->
    showIndentViewState: @showIndentView.serialize()

  toggle: ->
    console.log 'ShowIndent was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

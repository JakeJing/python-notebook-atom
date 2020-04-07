# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

atom.commands.add 'atom-text-editor',
  'custom:insert-pycell': ->
    atom.workspace.getActiveTextEditor()?.insertText("""```{python}

	```""")

# SymbolRegex = /\s*[(){}<>[\]/'"]/
# SymbolRegex = /\s*print/
# atom.commands.add 'atom-text-editor', 'custom:jump-over-symbol': (event) ->
#   editor = atom.workspace.getActiveTextEditor()
#   cursorMoved = false
#   for cursor in editor.getCursors()
#     range = cursor.getCurrentWordBufferRange(wordRegex: /print\s*/)
#     unless range.isEmpty()
#       cursor.setBufferPosition(range.end)
#       cursorMoved = true
#   event.abortKeyBinding() unless cursorMoved

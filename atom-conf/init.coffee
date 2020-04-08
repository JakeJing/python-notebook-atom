# Your init script
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

atom.commands.add 'atom-text-editor',
  'custom:insert-pycell': ->
    atom.workspace.getActiveTextEditor()?.insertText("""```{python}

	```""")


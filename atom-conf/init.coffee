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

atom.commands.add 'atom-text-editor','custom:insert-pycell': ->
    atom.workspace.getActiveTextEditor()?.insertText("""```{python}

	```""")

atom.commands.add 'atom-text-editor','custom:insert-juliachunk': ->
    atom.workspace.getActiveTextEditor()?.insertText("""# %% label = "newchunk"

	# %%""")

atom.commands.add 'atom-text-editor','custom:insert-pychunk': ->
    atom.workspace.getActiveTextEditor()?.insertText("""# %%

	# %%""")

atom.commands.add 'atom-text-editor', 'custom:insertprint', ->
  editor = atom.workspace.getActiveTextEditor()
  editor.insertText('print()')

atom.commands.add 'atom-text-editor', 'custom:run-next-cell', ->
  editor = atom.views.getView(atom.workspace.getActiveTextEditor())
  atom.commands.dispatch(editor, 'cell-navigation:next-cell')
  atom.commands.dispatch(editor, 'hydrogen:run-cell-and-move-down')

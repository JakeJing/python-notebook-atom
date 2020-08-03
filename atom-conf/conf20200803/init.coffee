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

# Insert text
atom.commands.add 'atom-text-editor','custom:insert-pycell': ->
    atom.workspace.getActiveTextEditor()?.insertText("""```{python}

	```""")

atom.commands.add 'atom-text-editor','custom:insert-juliachunk': ->
    atom.workspace.getActiveTextEditor()?.insertText("""# %% hold=true; label = "newchunk"

	# %%""")

atom.commands.add 'atom-text-editor','custom:insert-julia-md-chunk': ->
    atom.workspace.getActiveTextEditor()?.insertText("""```julia; hold=true; label = "newchunk"

	```""")

atom.commands.add 'atom-text-editor','custom:insert-py-md-chunk': ->
    atom.workspace.getActiveTextEditor()?.insertText("""```{python, name = "newchunk"}

	```""")

atom.commands.add 'atom-text-editor','custom:insert-pychunk': ->
    atom.workspace.getActiveTextEditor()?.insertText("""# %% name = "newchunk"

	# %%""")

atom.commands.add 'atom-text-editor', 'custom:insertprint', ->
  editor = atom.workspace.getActiveTextEditor()
  editor.insertText('print()')

atom.commands.add 'atom-text-editor', 'custom:insertpipe', ->
   editor = atom.workspace.getActiveTextEditor()
   editor.insertText(' |> ')

# Navigate cell
atom.commands.add 'atom-text-editor', 'custom:insert-print-move-left', ->
  editor = atom.views.getView(atom.workspace.getActiveTextEditor())
  atom.commands.dispatch(editor, 'custom:insertprint')
  atom.commands.dispatch(editor, 'core:move-left')

atom.commands.add 'atom-text-editor', 'custom:run-next-cell', ->
  editor = atom.views.getView(atom.workspace.getActiveTextEditor())
  atom.commands.dispatch(editor, 'cell-navigation:next-cell')
  atom.commands.dispatch(editor, 'hydrogen:run-cell-and-move-down')
  atom.commands.dispatch(editor, 'core:move-up')

atom.commands.add 'atom-text-editor', 'custom:run-current-cell', ->
  editor = atom.views.getView(atom.workspace.getActiveTextEditor())
  atom.commands.dispatch(editor, 'hydrogen:run-cell-and-move-down')
  atom.commands.dispatch(editor, 'core:move-up')

# julia/python
atom.commands.add 'atom-text-editor','custom:insert-julia-md-chunk-moveup': ->
      editor = atom.views.getView(atom.workspace.getActiveTextEditor())
      atom.commands.dispatch(editor, 'custom:insert-julia-md-chunk')
      atom.commands.dispatch(editor, 'core:move-up')

atom.commands.add 'atom-text-editor','custom:insert-py-md-chunk-moveup': ->
      editor = atom.views.getView(atom.workspace.getActiveTextEditor())
      atom.commands.dispatch(editor, 'custom:insert-py-md-chunk')
      atom.commands.dispatch(editor, 'core:move-up')

# Move cursor
atom.commands.add '.platform-darwin','custom:move-cursor-to-keybinding', ->
  editor = atom.views.getView(atom.workspace.getActiveTextEditor())
  atom.commands.dispatch(editor, 'key-binding-resolver:toggle')

atom.commands.add '.platform-darwin','custom:move-cursor-to-text', ->
  editor = atom.views.getView(atom.workspace.getActiveTextEditor())
  atom.commands.dispatch(editor, 'custom:move-cursor-to-keybinding')
  atom.commands.dispatch(editor, '.platform-darwin:key-binding-resolver:toggle')
  atom.commands.dispatch(editor, 'window:focus-pane-above')

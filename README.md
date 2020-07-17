# Python Notebook in Atom

I briefly include the procedures to set up the Atom as an IDE for python. I will make Atom similar to Rstudio with roughly the same shortcuts and functions. This is designed for .pmd format, though .py is also supported.

## 1. install pweave via pip

> pip3 install --upgrade Pweave

## 2. download install Atom from the offical web ([https://atom.io/](https://atom.io/))

## 3. install the necessary packages for Atom, for example,

> apm install Hydrogen

Here I am providing a list of packages (see `packages.txt`).

## 4. customize Atom

### (1) add shortcut (__shift-cmd-k__) to compile the template file (`template.pmd`) into pdf.

I am using the fish shell, and you need first create a fish function (`autoweave.fish`) and put the file in your path. You can also translate it into a bash script, if you are using other shells. You can test this script by running the following command in the shell, and compile it into a pdf:

> autoweave template.pmd

If everything works fine, you can proceed to add a shell command in the Atom. You probably need to have pandoc, Rstudio and MkTex installed. With this script, you can create a shell command in Atom's `config.cson` file by appending the following piece of code (see the sample `config.cson` in the folder `atom-conf`). There might be some keybinding conflicts in Atom, and you can resolve them by using the `keybinding-resolver` package (__cmd - .__ to check the comflicted keybindings, and change them).

```{r remedy001}
"atom-shell-commands":
  commands: [
    {
      arguments: [
        "-c autoweave {FileName}"
      ]
      command: "fish"
      name: "pmd2pdf"
      options:
        cwd: "{FileDir}"
        keymap: "shift-cmd-k"
    }
  ]
```

### (2) add shortcut (__shift-cmd-i__) to insert a python chunk

In order to insert a python chunk, you need to add the following code in the `init.coffee`.

```{r remedy001}
atom.commands.add 'atom-text-editor',
  'custom:insert-pycell': ->
    atom.workspace.getActiveTextEditor()?.insertText("""```{python}

	```""")
```

To add the shortcut, you can put the following code in the `keymap.cson` (check the example keymap.cson).

```{r remedy001}
'atom-text-editor':
  'shift-cmd-i': 'custom:insert-pycell'
```

### (3) color the python code chunk

It can make your life easier with a different color for the python code chunk. You can add the following code in the `style.less` (see the example `style.less`). I specfically pick up the color based on my own Atom theme (UI theme: Atom dark; syntax theme: atom material or jvpr-dark-syntax).


```{r remedy001}
atom-text-editor.editor {
  .line {
    position: relative;
  .syntax--embedded {
      &::before {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 200%;
        content: '';
        display: block;
        z-index: -1;
      }
      &.syntax--python::before{
        background-color: fade(#282828, 35%);
      }
    }
  }
}
```

Note: I also slightly edit the theme color pattern below in the source code (__base.less__) of jvpr-dark-syntax.

```{r remedy001}
.syntax--invalid.syntax--illegal {
  background-color: @syntax-background-color;
  color: @jv-white;
}
```

The selection color in the theme is also changed to be light-gray in the __syntax-variables.less__ file. 

```{r remedy001}
@syntax-selection-color: @jv-light-gray;
```

### (4) add shortcuts to run the code by line (__cmd-enter__) or run the whole chunk (__shift-cmd-enter__)

Pls check the file (`hydrogen.cson`), and you can customize your own shortcuts. You may need to resolve some conflicted keymappings, if it is needed.

### (5) add shortcuts (chunk next: ctrl-n; chunk before: ctrl-b) to jump over each code chunks

I only have a temporary solution by making use of the `find-selection` packages, and you need to adjust the keybingdings accordingly. In order to just between each code chunk, you need to first select the check for python, and type (__ctr-n__) for next chunk, and (__ctrl-b__) for the chunk before. This is not the final solution, but a compromise way of solving the problem. One advantage of this is that you can jump over all the selected terms.

Alternatively, you can edit the source code of `cell-navigation` package to navigate between different python code chunks. To do that, you need to replace the original cell marker (__# %%__) as __/^```.?python|^# %%/__ in the __cell-navigation/utils.coffee__ and __spec/00-utils-spec.coffee__ files. Here I also map the keyshorts as __ctrl-n/b__ to jump to the next or previous chunk.

### (6) map multiple commands with a single keystroke

To customize your own keybindings, you can also define a series of actions or commands, and map them to one single keystroke via *coffee* script. Here is an example of running the next code chunk (__1.__ move to the next chunk; __2.__ run the code chunk).

You can put the following code block in your __init.coffee__.

```coffeescript
atom.commands.add 'atom-text-editor', 'custom:run-next-cell', ->
  editor = atom.views.getView(atom.workspace.getActiveTextEditor())
  atom.commands.dispatch(editor, 'cell-navigation:next-cell')
  atom.commands.dispatch(editor, 'hydrogen:run-cell-and-move-down')
```

With the defined command __"custom:run-next-cell"__, you can specify a key in your __keycap.cson__, i.e., "__shift-cmd-n__".

```cson
'atom-text-editor':
  'shift-cmd-n': 'custom:run-next-cell'
```

### (7) shortcut (__ctrl-l__) to clear the chunk results

I also created a shortcut to clear the chunk output. But it seems that it will clean the output from all chunks. It would be better if there is a way to clean the output for each chunk, or can fold the code chunk results justs like the Rstudio.

### (8) override keybindings

You may need to override some keybindings, you can copy certain keybindings (click the copy icon in __Settings-Keybindings__), and paste it into your __keymap.cson__ file. __Note:__ you should use '.editor:not([mini])' to define a keybinding, and the __keymap.cson__ file looks like this:

```cson
'.editor:not([mini])':
  'ctrl-n': 'find-selection:find-next'
  'ctrl-b': 'find-selection:find-previous'
```
### (9) turn on autosave

You can also turn on the autosave mode (autosave package - settings - tick the enabled).

### (10) set the tab length

You can set the tab length as 4 and show indent guide (settings - editor - tab length/show indent guide).

### (11) turn on soft wrap

Just put the following piece in Atom's __config.cson__ file.

```{r remedy001}
editor:
  softWrap: true
```

### (12) contrast the colors for code errors

The color contrast is not sufficient for Atom with a dark theme. It would be better to adjust the color for python syntactic errors.

```{r remedy001}
jupyter kernelspec list
#  python3      /Users/jakejing/Library/Jupyter/kernels/python3
```

Go to this folder and set the color as 'NoColor' in `kernel.json` file. This will make all error messages in python as white. There are also some other options, such as 'Neutral', 'LightBG', and 'Linux'.

```{r remedy001}
{
 "argv": [
  "/usr/local/opt/python/bin/python3.7",
  "-m",
  "ipykernel_launcher",
  "--colors='NoColor'",
  "-f",
  "{connection_file}"
 ],
 "display_name": "Python 3",
 "language": "python"
}
```

You can still change the background color for the hygrogen cell by appending the following code in the `style.less` file.

```{r remedy001}
atom-text-editor {
  .hydrogen {
    .hydrogen_cell_display{
        background-color: #4f4850;
    }
  }
}
```

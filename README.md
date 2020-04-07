# Set Up Atom for Python

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

It can make your life easier with a different color for the python code chunk. You can add the following code in the `style.less` (see the example `style.less`). I specfically pick up the color based on my own Atom theme (UI theme: Atom dark; syntax theme: atom material).

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

### (4) add shortcuts to run the code by line (__cmd-enter__) or run the whole chunk (__shift-cmd-enter__)

Pls check the file (`hydrogen.cson`), and you can customize your own shortcuts. You may need to resolve some conflicted keymappings, if it is needed.

### (5) add shortcuts (chunk next: ctrl-n; chunk before: ctrl-b) to jump over each code chunks

I only have a temporary solution by making use of the `find-selection` packages, and you need to adjust the keybingdings accordingly. In order to just between each code chunk, you need to first select the check for python, and type (__ctr-n__) for next chunk, and (__ctrl-b__) for the chunk before. This is not the final solution, but a compromise way of solving the problem. One advantage of this is that you can jump over all the selected terms.

### (6) shortcut (__ctrl-l__) to clear the chunk results

I also created a shortcut to clear the chunk output. But it seems that it will clean the output from all chunks. It would be better if there is a way to clean the output for each chunk, or can fold the code chunk results justs like the Rstudio. 



# Setup Atom for Python

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

If everything works fine, you can proceed to add a shell command in the Atom. You probably need to have pandoc, Rstudio and MkTex installed. With this script, you can create a shell command in Atom's `config.cson` file by appending the following piece of code (see the sample `config.cson` in the folder `atom-conf`). There might be some keybinding conflicts in Atom, and you can resolve them by using the `keybinding-resolver` package (__cmd + .__ to check the comflicted keybindings, and change them). 

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





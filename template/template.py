---
title: "Template pmd file for python"
author: "Yingqi Jing"
date: 21.02.2021
header-includes:
- \usepackage{textcomp}
- \renewcommand{\thefigure}{S\arabic{figure}}
- \renewcommand{\thetable}{S\arabic{table}}
- \renewcommand{\thesection}{S\arabic{section}}
- \renewcommand{\thesubsection}{S\arabic{section}.\arabic{subsection}}
- \usepackage{tocloft}
- \settowidth{\cftsecnumwidth}{S10x}
output:
pdf_document:
fig_crop: true
fig_caption: true
latex_engine: xelatex
toc: true
toc_depth: 4
number_section: true
pandoc_args: ["--variable=lof","--variable=lot","--bibliography=/Users/jakejing/switchdrive/bib/references.bib", "--csl=/Users/jakejing/switchdrive/bib/unified-style-linguistics.csl"]
---
\clearpage

# %% echo = False, include=False
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
# %%

Introduction
===========

This an example of a script that can be published using `Pweave`(http://mpastell.com/pweave). The script can be executed.

Data and Methods
============


# %% name = "for loop"
for i in range(10):
    print(i)
# %%

Results
=========

Discussions
==========

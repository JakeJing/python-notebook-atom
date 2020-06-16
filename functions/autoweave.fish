function autoweave --description 'automatic compile a .pmd file into pdf'
  set filename $argv
  set rootname (echo $filename | sed 's/\.[^.]*$//')

  switch $argv
  case '*.pmd'
    pweave -f pandoc $filename
	#/usr/local/bin/pandoc +RTS -K512m -RTS "$rootname".md --to latex --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash --output "$rootname".tex --table-of-contents --toc-depth 4 --template /Library/Frameworks/R.framework/Versions/3.6/Resources/library/rmarkdown/rmd/latex/default-1.17.0.2.tex --number-sections --highlight-style tango --pdf-engine xelatex --variable graphics=yes --variable=lof --variable=lot --bibliography=/Users/jakejing/switchdrive/bib/references.bib --csl=/Users/jakejing/switchdrive/bib/unified-style-linguistics.csl --variable 'geometry:margin=1in' --variable 'compact-title:yes'
	# It seems that Knit Rstudio can sometimes update the template (this is thge latest one via lua)
	/usr/local/bin/pandoc +RTS -K512m -RTS "$rootname".md --to latex --from markdown+autolink_bare_uris+tex_math_single_backslash --output "$rootname".tex --self-contained --table-of-contents --toc-depth 4 --number-sections --highlight-style tango --pdf-engine xelatex --variable graphics --lua-filter /Library/Frameworks/R.framework/Versions/3.6/Resources/library/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /Library/Frameworks/R.framework/Versions/3.6/Resources/library/rmarkdown/rmd/lua/latex-div.lua --variable=lof --variable=lot --bibliography=/Users/jakejing/switchdrive/bib/references.bib --csl=/Users/jakejing/switchdrive/bib/unified-style-linguistics.csl --include-in-header /var/folders/s9/ttwvwj0d7m55xgssdd1sx4l00000gr/T//RtmpgJoiuF/rmarkdown-strfe3e7271c4b8.html --variable 'geometry:margin=1in' --include-in-header /var/folders/s9/ttwvwj0d7m55xgssdd1sx4l00000gr/T//RtmpgJoiuF/rmarkdown-strfe3eb2a46bb.html
    xelatex "$rootname".tex
    xelatex "$rootname".tex
    # need to compile 2 times to get the content page
    rm "$rootname".md "$rootname".tex "$rootname".aux "$rootname".lo* "$rootname".out "$rootname".toc
    open -a Preview "$rootname".pdf

  case '*.py'
    sed 's/^# %% /```python,/' $filename | sed 's/^# %%$/```/' > "$rootname".pmd
    pweave -f pandoc "$rootname".pmd

	# insert the header to the 3r row
	#  echo -e '4r /Users/jakejing/.config/fish/functions/header.md\nw' | ed "$rootname".md
    	# It seems that Knit Rstudio can sometimes update the template (this is thge latest one via lua)
	/usr/local/bin/pandoc +RTS -K512m -RTS "$rootname".md --to latex --from markdown+autolink_bare_uris+tex_math_single_backslash --output "$rootname".tex --self-contained --table-of-contents --toc-depth 4 --number-sections --highlight-style tango --pdf-engine xelatex --variable graphics --lua-filter /Library/Frameworks/R.framework/Versions/3.6/Resources/library/rmarkdown/rmd/lua/pagebreak.lua --lua-filter /Library/Frameworks/R.framework/Versions/3.6/Resources/library/rmarkdown/rmd/lua/latex-div.lua --variable=lof --variable=lot --bibliography=/Users/jakejing/switchdrive/bib/references.bib --csl=/Users/jakejing/switchdrive/bib/unified-style-linguistics.csl --include-in-header /var/folders/s9/ttwvwj0d7m55xgssdd1sx4l00000gr/T//RtmpgJoiuF/rmarkdown-strfe3e7271c4b8.html --variable 'geometry:margin=1in' --include-in-header /var/folders/s9/ttwvwj0d7m55xgssdd1sx4l00000gr/T//RtmpgJoiuF/rmarkdown-strfe3eb2a46bb.html
    xelatex "$rootname".tex
    xelatex "$rootname".tex
    # need to compile 2 times to get the content page
    rm "$rootname".md "$rootname".tex "$rootname".aux "$rootname".lo* "$rootname".out "$rootname".toc
    open -a Preview "$rootname".pdf
  end
end

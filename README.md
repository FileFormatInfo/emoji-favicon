# Emoji Favicons [<img alt="emoji-favicon logo" src="docs/favicon.svg" height="90" align="right" />](https://emoji-favicon.fileformat.info/)

<!-- LATER: badges -->

Need a nice favicon?  There are a bunch of [open source sets of SVG emoji](https://github.com/VectorLogoZone/awesome-emoji#images) that look great at favicons.

While it is easy to convert an SVG to a favicon ([online](https://favicon.fileformat.info/) or [bash script](bin/svg2ico.sh)), it does get repetitious after awhile, so I pre-converted a bunch.

If you don't like any of the emoji, you can always DIY with an SVG from [IconSear.ch](IconSear.ch)!

<!--
The preview pages are **HUGE** and there is no search engine, so it is often easier to find them on [Emojipedia](https://emojipedia.org/), get the Unicode value, and then find the file name.
-->

## Running

Prerequisites you need to install to update and run:

- rsvg
- ImageMagick
- Jekyll

The scripts to download and convert the original SVG emoji images are in the [`bin`](bin/) directory.

This is standard Jekyll site running on Github Pages.  Run locally with:

```
jekyll server --source docs
```

## Credits

[![rsvg](https://www.vectorlogo.zone/logos/gnome/gnome-ar21.svg)](https://wiki.gnome.org/Projects/LibRsvg "build-time rasterization")
[![bash](https://www.vectorlogo.zone/logos/gnu_bash/gnu_bash-ar21.svg)](https://www.gnu.org/software/bash/ "scripting")
[![FileFormat.Info](https://www.vectorlogo.zone/logos/fileformatinfo/fileformatinfo-ar21.svg)](https://www.fileformat.info/ "Online format conversion")
[![git](https://www.vectorlogo.zone/logos/git-scm/git-scm-ar21.svg)](https://git-scm.com/ "Version control")
[![Github](https://www.vectorlogo.zone/logos/github/github-ar21.svg)](https://www.github.com/ "git hosting")
[![ImageMagick](https://www.vectorlogo.zone/logos/imagemagick/imagemagick-ar21.svg)](https://www.imagemagick.org/ "Image manipulation")
[![Jekyll](https://www.vectorlogo.zone/logos/jekyllrb/jekyllrb-ar21.svg)](https://jekyllrb.com/ "Static site generator")
[![Noah Marcuse](https://www.vectorlogo.zone/logos/marcuse_ink/marcuse_ink-ar21.svg)](https://noah.marcuse.ink/ "Making logos!")

The various emoji sources are listed on the [home page](https://emoji-favicon.fileformat.info/).


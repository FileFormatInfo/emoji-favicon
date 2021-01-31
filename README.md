# Emoji Favicons [<img alt="emoji-favicon logo" src="docs/favicon.svg" height="90" align="right" />](https://emoji-favicon.fileformat.info/)

[![Netlify Status](https://api.netlify.com/api/v1/badges/bd529929-0d6b-43ca-b2b9-ecc8d9685db4/deploy-status)](https://app.netlify.com/sites/svg-emoji-favicon/deploys)
[![30 day uptime](https://img.shields.io/nodeping/uptime/k4vws8sh-l4s3-4pmc-ad3t-vi9r0344u3cj.svg?label=30-day%20uptime&style=flat)](https://nodeping.com/reports/checks/k4vws8sh-l4s3-4pmc-ad3t-vi9r0344u3cj)

Need a nice favicon?  There are a bunch of [open source sets of SVG emoji](https://github.com/VectorLogoZone/awesome-emoji#images) that look great as favicons.

## Using

Go to [emoji-favicon.fileformat.info](https://emoji-favicon.fileformat.info/), choose a set of emoji, and download a beautiful favicon.

Be sure to pay attention to any licensing requirements!

Currently the search only looks at the Unicode codepoint.

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

## Do It Yourself

Don't like any of the emoji or have an SVG you want to use instead?  It is easy:

* [online](https://favicon.fileformat.info/)
* [bash script](bin/svg2ico.sh)) - you still need to have rsvg and ImageMagick installed

[IconSear.ch](IconSear.ch) and [svgrepo](https://www.svgrepo.com/) are good places to look for SVG icons.

## License

Licensing for the emoji is specific to each source, and is linked to from each source's detail page.

The code is [Affero GPL v3](LICENSE.txt)

## Credits

[![rsvg](https://www.vectorlogo.zone/logos/gnome/gnome-ar21.svg)](https://wiki.gnome.org/Projects/LibRsvg "build-time rasterization")
[![bash](https://www.vectorlogo.zone/logos/gnu_bash/gnu_bash-ar21.svg)](https://www.gnu.org/software/bash/ "scripting")
[![FileFormat.Info](https://www.vectorlogo.zone/logos/fileformatinfo/fileformatinfo-ar21.svg)](https://www.fileformat.info/ "Online format conversion")
[![git](https://www.vectorlogo.zone/logos/git-scm/git-scm-ar21.svg)](https://git-scm.com/ "Version control")
[![Github](https://www.vectorlogo.zone/logos/github/github-ar21.svg)](https://www.github.com/ "git hosting")
[![ImageMagick](https://www.vectorlogo.zone/logos/imagemagick/imagemagick-ar21.svg)](https://www.imagemagick.org/ "Image manipulation")
[![Jekyll](https://www.vectorlogo.zone/logos/jekyllrb/jekyllrb-ar21.svg)](https://jekyllrb.com/ "Static site generator")
[![Netlify](https://www.vectorlogo.zone/logos/netlify/netlify-ar21.svg)](https://www.netlify.com/ "CI and hosting")
[![Noah Marcuse](https://www.vectorlogo.zone/logos/marcuse_ink/marcuse_ink-ar21.svg)](https://noah.marcuse.ink/ "Making logos!")

The various emoji sources are listed on the [home page](https://emoji-favicon.fileformat.info/).


## Creating a Mfizz font plugin for Octopress

To start, added the font files to /source/fonts and then the css file to /sass/plugins (this directory is already imported automatically)

I changed the css file to a sass file, so that I could change the font-face declration to use a variable path for teh font files

``` scss
$mfizz-font-path: "../fonts";
@font-face {
  font-family: 'FontMfizz';
  src: url('#{$mfizz-font-path}/font-mfizz.eot');
  src: url('#{$mfizz-font-path}/font-mfizz.eot?#iefix') format("embedded-opentype"),
       url('#{$mfizz-font-path}/font-mfizz.woff') format("woff"),
       url('#{$mfizz-font-path}/font-mfizz.ttf') format("truetype"),
       url('#{$mfizz-font-path}/font-mfizz.svg#font-mfizz') format("svg");
  font-weight: normal;
  font-style: normal;
}
```

*** For plugin, add font-awesome to package, as this makes it easier to style and adds more icons not included in mfizz


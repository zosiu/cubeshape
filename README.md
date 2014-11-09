What is this?
=========
A square-1 image generator.

How to use it?
=========

`https://cubeshape.herokuapp.com/cubeshape/[shape]`

Where [shape] is formed from **c** (corner) and **e** (edge) characters.
The default image size is 200px, but can be set via the **size** query parameter.

The default color is dark grey, but everything (including side stickers) can be set via the **colors** query parameter.

Color codes:

`d: darkgrey`

`w: white`

`y: yellow`

`o: orange`

`r: red`

`g: green`

`b: blue`

If `colors.length <= shape.lengt` only the pieces will be colored, else you need to provide 3 colors for corners (color, left side, right side) and 2 colors for edges (color, side).
You can use any non-alphanumeric character as a separator between the color blocks.

Examples
=========
**default colors, default size** `/eeccccc`

![](https://cubeshape.herokuapp.com/cubeshape/eeccccc "default colors, default size")


**size set to 350** `/eeeecceeee?size=350`

![](https://cubeshape.herokuapp.com/cubeshape/eeeecceeee?size=350 "size set to 350")

**colored pieces** `/eccecece?colors=wwyyyyyy`

![](https://cubeshape.herokuapp.com/cubeshape/eccecece?colors=wwyyyyyy "colored pieces")

**colored pieces with side stickers** `/ceceecec?&colors=yrb_yb_ybo_yo_wr_wr_g_wg_wgo`

![](https://cubeshape.herokuapp.com/cubeshape/ceceecec?&colors=yrb_yb_ybo_yo_wr_wr_g_wg_wgo "colored pieces with side stickers")

**parity** `/cececece?&colors=yrb_yb_ybo_yo_yog_yr_ygr_yg`

![](https://cubeshape.herokuapp.com/cubeshape/cececece?&colors=yrb_yb_ybo_yo_yog_yr_ygr_yg "parity")

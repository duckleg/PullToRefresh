PullToRefresh
=======


![Explain01](https://c2fa2e6e-a-62cb3a1a-s-sites.googlegroups.com/site/ducklegflash/pulltorefresh/ex01.jpg)&nbsp;
![Explain03](https://c2fa2e6e-a-62cb3a1a-s-sites.googlegroups.com/site/ducklegflash/pulltorefresh/ex03.jpg)

This library aims to provide a reusable Pull to Refresh widget for Adobe AIR mobile. It was based on Starling Framework.
The inherited component is allowed to displays a “loading” busy indicator at the top of the list and dispatch a REFRESH_EVENT.

## Features

- Animated Scrolling for iOS 4.3+ or Android 2.3+
- Supports for Starling Framework (Version 1.3)
- Currently works with:
-   GroupedList
-   List

## What does work


First of all, you'll create an instance of the DPad and add to the stage.
```as3
var dPad:DPad = new DPad();
this.addChild(dPad);
````


## Examples

- example [demo](https://sites.google.com/site/ducklegflash/pulltorefresh/example01)

(Click the image to see some demos. Be patient, no preloader!)

## License

Copyright (C) 2012 Marco Wong, http://flash-adobe.blogspot.hk/

Licence Agreement (The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

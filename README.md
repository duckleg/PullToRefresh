PullToRefresh
=======


![Explain01](https://c2fa2e6e-a-62cb3a1a-s-sites.googlegroups.com/site/ducklegflash/pulltorefresh/ex01.jpg)
![Explain02](https://c2fa2e6e-a-62cb3a1a-s-sites.googlegroups.com/site/ducklegflash/pulltorefresh/ex02.jpg)
![Explain03](https://c2fa2e6e-a-62cb3a1a-s-sites.googlegroups.com/site/ducklegflash/pulltorefresh/ex03.jpg)


## Features

- 

## What does work


First of all, you'll create an instance of the DPad and add to the stage.
```as3
var dPad:DPad = new DPad();
this.addChild(dPad);
````

Add a detection listener for AxisPad. You'll get values on X and Y-axis.
```as3
dPad.leftPad.addEventListener(DPadEvent.TOUCH_PRESS, touchPressHandler);
dPad.leftPad.addEventListener(DPadEvent.TOUCH_RELEASE, touchReleaseHandler);

private function touchPressHandler(event:DPadEvent):void{
  var axisPad:AxisPad = event.target as AxisPad;
  trace("radians: " + axisPad.radians);
  trace("distance: " + axisPad.distance + "/" + axisPad.maxDistance);
  trace("press left:  " + (axisPad.value & AxisPad.LEFT));
  trace("press right: " + (axisPad.value & AxisPad.RIGHT));
  trace("press up:    " + (axisPad.value & AxisPad.UP));
  trace("press down:  " + (axisPad.value & AxisPad.DOWN));
}
private function touchReleaseHandler(event:DPadEvent):void{
  ...
}
````

Add a detection listener for GroupPad. You'll get values on A and B buttons.
```as3
dPad.rightPad.addEventListener(DPadEvent.TOUCH_PRESS_A, touchPressAHandler);
dPad.rightPad.addEventListener(DPadEvent.TOUCH_PRESS_B, touchPressBHandler);
dPad.rightPad.addEventListener(DPadEvent.TOUCH_RELEASE_A, touchReleaseAHandler);
dPad.rightPad.addEventListener(DPadEvent.TOUCH_RELEASE_B, touchReleaseBHandler);

private function touchPressAHandler(event:DPadEvent):void{
  var groupPad:GroupPad = event.target as GroupPad;
  trace("press A: " + (groupPad.value & GroupPad.A_BUTTON));
  trace("press B: " + (groupPad.value & GroupPad.B_BUTTON));
}
private function touchPressBHandler(event:DPadEvent):void{
	...
}
private function touchReleaseAHandler(event:DPadEvent):void{
	...
}
private function touchReleaseBHandler(event:DPadEvent):void{
	...
}
````

## Examples

- example01_basic [demo](https://sites.google.com/site/ducklegflash/as3dpad/example01_basic)
- example02_custom_UI [demo](https://sites.google.com/site/ducklegflash/as3dpad/example02_custom_ui)
- example03_double_AxisPad [demo](https://sites.google.com/site/ducklegflash/as3dpad/example03_double_axispad)
- example04_touch9Grid [demo](https://sites.google.com/site/ducklegflash/as3dpad/example04_touch9grid)
- example05_starling [demo](https://sites.google.com/site/ducklegflash/as3dpad/example05_starling)

[![Launch Examples](https://sites.google.com/site/ducklegflash/as3dpad/ex01.jpg)](https://sites.google.com/site/ducklegflash/as3dpad/example01_basic)
[![Launch Examples](https://sites.google.com/site/ducklegflash/as3dpad/ex02.jpg)](https://sites.google.com/site/ducklegflash/as3dpad/example02_custom_ui)
[![Launch Examples](https://sites.google.com/site/ducklegflash/as3dpad/ex03.jpg)](https://sites.google.com/site/ducklegflash/as3dpad/example03_double_axispad)
[![Launch Examples](https://sites.google.com/site/ducklegflash/as3dpad/ex04.jpg)](https://sites.google.com/site/ducklegflash/as3dpad/example04_touch9grid)
[![Launch Examples](https://sites.google.com/site/ducklegflash/as3dpad/ex05.jpg)](https://sites.google.com/site/ducklegflash/as3dpad/example05_starling)

(Click the image to see some demos. Be patient, no preloader!)

## Download

SWC Library - [as3dpad.swc](https://github.com/duckleg/as3dpad/tree/master/as3dpad/bin)

## License

Copyright (C) 2012 Marco Wong, http://flash-adobe.blogspot.hk/

Licence Agreement (The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

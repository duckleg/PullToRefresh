PullToRefresh
=======


![Explain01](https://c2fa2e6e-a-62cb3a1a-s-sites.googlegroups.com/site/ducklegflash/pulltorefresh/ex01.jpg)&nbsp;&nbsp;&nbsp;
![Explain03](https://c2fa2e6e-a-62cb3a1a-s-sites.googlegroups.com/site/ducklegflash/pulltorefresh/ex03.jpg)

This library aims to provide a reusable Pull to Refresh widget for Adobe AIR mobile. It was based on Feathers (UI component of Starling Framework).
The inherited component is allowed to display a “loading” busy indicator at the top of the list and dispatch a event.

## Features

- Supports for Feathers (Version 1.1)
- Currently works with:
  - GroupedList (Inherit to: [feathers.controls.PullToRefreshGroupedList](https://github.com/duckleg/PullToRefresh/blob/master/src/feathers/controls/PullToRefreshGroupedList.as))
  - List (Inherit to: [feathers.controls.PullToRefreshList](https://github.com/duckleg/PullToRefresh/blob/master/src/feathers/controls/PullToRefreshList.as))

## What does work


First of all, you'll import the class path of the component
```as3
import feathers.controls.PullToRefreshList;
import feathers.controls.List;
````

Define a data set
```as3
var data:Array =
	[
		{ text: "Aardvark" },
		{ text: "Alligator" },
		{ text: "Alpaca" },
		{ text: "Anteater" },
	];
````

Create a PullToRefreshList
```as3
var list:List = new PullToRefreshList();
list.dataProvider = new ListCollection(data);
list.addEventListener(PullToRefreshList.PULL_TO_REFRESH_EVENT, listPullToRefreshHandler);
````

If user pull down the component, you will receive a event
```as3
private function listPullToRefreshHandler(event:Event):void{
	...
	// call server to return some data
	...
}
````

## Examples

- example ([demo](https://sites.google.com/site/ducklegflash/pulltorefresh/example01))

(Click the link to see demo. Be patient, no preloader!)

## License

Copyright (C) 2013 Marco Wong, http://flash-adobe.blogspot.hk/

Licence Agreement (The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

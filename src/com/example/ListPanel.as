package com.example
{
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.PullToRefreshList;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	public class ListPanel extends PanelScreen
	{
		private var _data:Array;
		private var _list:List;
		
		public function ListPanel()
		{
			_data =
				[
					{ text: "Aardvark" },
					{ text: "Alligator" },
					{ text: "Alpaca" },
					{ text: "Anteater" },
				];
			
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		protected function initializeHandler(event:Event):void
		{
			this.layout = new AnchorLayout();
			this.headerProperties.title = "List";
			
			var btn:Button = new Button();
			btn.label = "Group List";
			btn.addEventListener(Event.TRIGGERED, btnTriggeredHandler);
			this.headerProperties.leftItems = new <DisplayObject>[btn];
			
			_list = new PullToRefreshList();
			_list.clipContent = false;
			_list.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.labelField = "text";
				renderer.isQuickHitAreaEnabled = true;
				return renderer;
			};
			_list.dataProvider = new ListCollection(_data);
			_list.addEventListener(PullToRefreshList.PULL_TO_REFRESH_EVENT, listPullToRefreshHandler);
			_list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this.addChildAt(_list, 0);
		}
		
		// **************************************** event - UI
		private function listPullToRefreshHandler(event:Event):void{
			// <----- disable refresh event
			_list.removeEventListener(PullToRefreshList.PULL_TO_REFRESH_EVENT, listPullToRefreshHandler);
			
			// <----- simulate to get data from server
			getData();
			
			// <----- enable refresh event
			_list.addEventListener(PullToRefreshList.PULL_TO_REFRESH_EVENT, listPullToRefreshHandler);
		}
		private function btnTriggeredHandler(event:Event):void{
			this.dispatchEvent(new Event(Event.OPEN));
		}
		
		// **************************************** private method
		private function getData():void{
			// <----- add one more item
			_data.push(
				{ 
					text: String.fromCharCode(Math.round(Math.random()*26)+65)
				});
			
			// <----- reset data provider
			_list.dataProvider = new ListCollection(_data);
		}
	}
}
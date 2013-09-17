package com.example
{
	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.PanelScreen;
	import feathers.controls.PullToRefreshGroupedList;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;

	public class GroupListPanel extends PanelScreen
	{
		private var _data:Array;
		private var _list:GroupedList;
		
		public function GroupListPanel()
		{
			var a:Starling
			_data =
				[
					{
						header: "A",
						children:
						[
							{ text: "Aardvark", price:"$100" },
							{ text: "Alligator", price:"$5" },
							{ text: "Alpaca", price:"$12" },
							{ text: "Anteater", price:"$55" },
						]
					},
					{
						header: "B",
						children:
						[
							{ text: "Baboon", price:"$9" },
							{ text: "Bear", price:"$101" },
							{ text: "Beaver", price:"$21" },
						]
					},
					{
						header: "C",
						children:
						[
							{ text: "A", price:"$30" },
						]
					},
				];
			
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		protected function initializeHandler(event:Event):void
		{
			this.layout = new AnchorLayout();
			this.headerProperties.title = "Group List";
			
			var btn:Button = new Button();
			btn.label = "List";
			btn.addEventListener(Event.TRIGGERED, btnTriggeredHandler);
			this.headerProperties.rightItems = new <DisplayObject>[btn];
			
			_list = new PullToRefreshGroupedList();
			_list.clipContent = false;
			_list.itemRendererFactory = function():IGroupedListItemRenderer
			{
				var renderer:DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				renderer.labelField = "text";
				renderer.accessoryLabelField = "price";
				renderer.isQuickHitAreaEnabled = true;
				return renderer;
			};
			_list.dataProvider = new HierarchicalCollection(_data);
			_list.addEventListener(PullToRefreshGroupedList.PULL_TO_REFRESH_EVENT, listPullToRefreshHandler);
			_list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this.addChildAt(_list, 0);
		}
		
		// **************************************** event - UI
		private function listPullToRefreshHandler(event:Event):void{
			// <----- disable refresh event
			_list.removeEventListener(PullToRefreshGroupedList.PULL_TO_REFRESH_EVENT, listPullToRefreshHandler);
			
			// <----- simulate to get data from server
			getData();
			
			// <----- enable refresh event
			_list.addEventListener(PullToRefreshGroupedList.PULL_TO_REFRESH_EVENT, listPullToRefreshHandler);
		}
		private function btnTriggeredHandler(event:Event):void{
			this.dispatchEvent(new Event(Event.OPEN));
		}
		
		// **************************************** private method
		private function getData():void{
			// <----- add one more item
			_data[_data.length-1].children.push(
				{ 
					text: String.fromCharCode(Math.round(Math.random()*26)+65), 
					price:"$"+Math.round(Math.random()*1000) 
				});
			
			// <----- reset data provider
			_list.dataProvider = new HierarchicalCollection(_data);
		}
	}
}
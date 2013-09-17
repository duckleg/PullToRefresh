package com.example
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.BlueWhiteMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class MainPanel extends Sprite
	{
		private var _navigator:ScreenNavigator;
		
		public function MainPanel(){
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		// **************************************** event - Stage
		private function addedToStageHandler(event:Event):void
		{
			// <----- define theme
			new BlueWhiteMobileTheme();
			
			// <----- add panels
			_navigator = new ScreenNavigator();
			_navigator.addScreen("Group List", new ScreenNavigatorItem(GroupListPanel, {open:openHandler}));
			_navigator.addScreen("List", new ScreenNavigatorItem(ListPanel, {open:openHandler}));
			this.addChild(_navigator);
			
			// <----- transition motion
			var tm:ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager(_navigator);
			tm.duration = 0.4;
			tm.clearStack();
			tm.skipNextTransition = false;
			
			// <----- start
			_navigator.showScreen("Group List");
		}
		private function removedFromStageHandler(event:Event):void{}
		
		// **************************************** event - UI
		private function openHandler(event:Event):void{
			if(event.target is GroupListPanel){
				_navigator.showScreen("List");
			}else if(event.target is ListPanel){
				_navigator.showScreen("Group List");
			}
		}
	}
}
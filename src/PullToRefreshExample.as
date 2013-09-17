package
{
	import com.example.MainPanel;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60")]
	public class PullToRefreshExample extends Sprite
	{
		private var _starling:Starling;
		
		public function PullToRefreshExample()
		{
			super();
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		// **************************************************** event - Sprite
		private function addedToStageHandler(event:Event):void{
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		private function enterFrameHandler(event:Event):void{
			// <----- remove listener
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			// <----- craete Starling
			this._starling = new Starling(MainPanel, this.stage);
			this._starling.enableErrorChecking = false;
			this._starling.start();
		}
	}
}
package feathers.controls
{
	import flash.display.BitmapData;
	
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class PullToRefreshList extends List
	{
		[Embed(source="/assets/images/pullToRefresh/loading.xml", mimeType="application/octet-stream")]
		private var LoadingAtlasXML:Class;
		
		[Embed(source="/assets/images/pullToRefresh/loading.png")]
		private var LoadingAtlasTexture:Class;
		
		[Embed(source="/assets/images/pullToRefresh/arrow_up.png")]
		private static const DEFAULT_PULL_DOWN_TO_REFRESH_ICON:Class;
		
		[Embed(source="/assets/images/pullToRefresh/arrow_down.png")]
		private static const DEFAULT_RELEASE_TO_REFRESH_ICON:Class;
		
		private static const PADDING_BOTTOM:int = 5;
		
		public static const PULL_TO_REFRESH_EVENT:String = "pull_to_refresh_event";
		
		public static const CLEAR_STATUS:String = "clear_status";
		public static const NORMAL_STATUS:String = "normal_status";
		public static const PULL_STATUS:String = "pull_status";
		public static const LOADING_STATUS:String = "loading_status";
		
		private var _pullDownToRefresh:Sprite;
		private var _releaseToRefresh:Sprite;
		private var _loadingNewRecords:Sprite;
		
		private var _releaseHeight:Number;
		
		private var _container:Sprite;
		
		private var _status:String;
		
		// ************************************** main
		public function PullToRefreshList(){
			super();
			
			// <----- add listener
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			this.addEventListener(Event.CHANGE, changeHandler);
		}
		
		// ************************************** event - starling.events.Event
		private function addToStageHandler(event:Event):void{
			_container = this.getChildAt(0) as Sprite;
			_pullDownToRefresh = createPullDownToRefresh();
			_releaseToRefresh = createReleaseToRefresh();
			_loadingNewRecords = createLoadingNewRecords();
			
			_container.addChild(_pullDownToRefresh);
			_container.addChild(_releaseToRefresh);
			_container.addChild(_loadingNewRecords);
			
			this.addEventListener(Event.ENTER_FRAME, firstFrameHandler);
		}
		private function firstFrameHandler(event:Event):void{
			this.removeEventListener(Event.ENTER_FRAME, firstFrameHandler);
			
			// <----- start
			if(this.dataProvider!=null && this.dataProvider.length==0){
				setUI();
				changeStatus(LOADING_STATUS);
			}
			
			// <----- add listener
			this.addEventListener(Event.SCROLL, scrollHandler);
			this.addEventListener(FeathersEventType.BEGIN_INTERACTION, scrollBeginHandler);
			this.addEventListener(FeathersEventType.END_INTERACTION, scrollEndHandler);
		}
		private function scrollHandler(event:Event):void{
			if(this._verticalScrollPosition<-_releaseHeight)
				changeStatus(PULL_STATUS);
			else if(this._verticalScrollPosition>-_releaseHeight)
				changeStatus(NORMAL_STATUS);
		}
		private function changeHandler(event:Event):void{
			if(this.selectedItem){
				for(var i:int=0; i<_container.numChildren; i++){
					var tmp:DefaultGroupedListItemRenderer = _container.getChildAt(i) as DefaultGroupedListItemRenderer;
					if(tmp!=null && tmp.data==this.selectedItem){
						this.dispatchEvent(new Event(Event.SELECT, false, tmp));
						return;
					}
				}
			}
		}
		
		// ************************************** event - starling.events.FeathersEventType
		private function scrollBeginHandler(event:Event):void{
			if(this.stage){
				setUI();
				changeStatus(NORMAL_STATUS);
			}
			
			this.addEventListener(Event.ENTER_FRAME, scrollHandler);
		}
		private function scrollEndHandler(event:Event):void{
			if(_status==PULL_STATUS)
				changeStatus(LOADING_STATUS);
			
			this.removeEventListener(Event.ENTER_FRAME, scrollHandler);
		}
		private function scrollCompleteHandler(event:Event):void{
			this.removeEventListener(FeathersEventType.SCROLL_COMPLETE, scrollCompleteHandler);
			this.dispatchEvent(new Event(PULL_TO_REFRESH_EVENT));
		}
		
		// ************************************** getter
		public function get pullDownToRefresh():Sprite{
			return _pullDownToRefresh;
		}
		public function get releaseToRefresh():Sprite{
			return _releaseToRefresh;
		}
		public function get loadingNewRecords():Sprite{
			return _loadingNewRecords;
		}
		
		// ************************************** setter
		override public function set dataProvider(value:ListCollection):void{
			super.dataProvider = value;
			
			if(this.stage){
				setUI();
				changeStatus(CLEAR_STATUS);
			}
		}
		
		// ************************************** private method
		private function setUI():void{
			var halfW:Number = this.width/2;
			_pullDownToRefresh.x = halfW - _pullDownToRefresh.width/2;
			_pullDownToRefresh.y = -_pullDownToRefresh.height-PADDING_BOTTOM;
			_releaseToRefresh.x = halfW - _releaseToRefresh.width/2;
			_releaseToRefresh.y = -_releaseToRefresh.height-PADDING_BOTTOM;
			_loadingNewRecords.x = halfW - _loadingNewRecords.width/2;
			_loadingNewRecords.y = -_loadingNewRecords.height-PADDING_BOTTOM;
			
			_releaseHeight = _pullDownToRefresh.height*2;
		}
		private function changeStatus(status:String):void{
			if(_status!=status){
				if(_status==LOADING_STATUS && status!=CLEAR_STATUS)
					return;
				
				_status = status;
				
				if(_status==NORMAL_STATUS || _status==CLEAR_STATUS){
					_pullDownToRefresh.visible = true;
					_releaseToRefresh.visible = false;
					_loadingNewRecords.visible = false;
					this.y = 0;
				}else if(_status==PULL_STATUS){
					_pullDownToRefresh.visible = false;
					_releaseToRefresh.visible = true;
					_loadingNewRecords.visible = false;
					this.y = 0;
				}else if(_status==LOADING_STATUS){
					_pullDownToRefresh.visible = false;
					_releaseToRefresh.visible = false;
					_loadingNewRecords.visible = true;
					this.y = _loadingNewRecords.height + PADDING_BOTTOM*2;
					this.addEventListener(FeathersEventType.SCROLL_COMPLETE, scrollCompleteHandler);
				}
			}
		}
		private function createPullDownToRefresh():Sprite{
			var tmp:Sprite = new Sprite();
			
			var icon:BitmapData = (new DEFAULT_PULL_DOWN_TO_REFRESH_ICON()).bitmapData;
			var img:Image = new Image(Texture.fromBitmapData(icon));
			tmp.addChild(img);
			
			var lab:Label = new Label();
			lab.x = 50;
			lab.text = "Pull Down to refresh";
			
			tmp.addChild(lab);
			tmp.visible = false;
			
			return tmp;
		}
		private function createReleaseToRefresh():Sprite{
			var tmp:Sprite = new Sprite();
			
			var icon:BitmapData = (new DEFAULT_RELEASE_TO_REFRESH_ICON()).bitmapData;
			var img:Image = new Image(Texture.fromBitmapData(icon));
			tmp.addChild(img);
			
			var lab:Label = new Label();
			lab.x = 50;
			lab.text = "Release to refresh...";
			
			tmp.addChild(lab);
			tmp.visible = false;
			
			return tmp;
		}
		private function createLoadingNewRecords():Sprite{
			var tmp:Sprite = new Sprite();
			
			var texture:Texture = Texture.fromBitmap(new LoadingAtlasTexture());
			var xml:XML = XML(new LoadingAtlasXML());
			var atlas:TextureAtlas = new TextureAtlas(texture, xml);
			var textures:Vector.<Texture> = atlas.getTextures("loading");
			var loading:MovieClip = new MovieClip(textures, 30);
			tmp.addChild(loading);
			Starling.juggler.add(loading);
			
			var lab:Label = new Label();
			lab.x = 50;
			lab.text = "Loading new records...";
			
			tmp.addChild(lab);
			tmp.visible = false;
			
			return tmp;
		}
	}
}
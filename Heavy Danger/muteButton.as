package  {
	
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.media.SoundTransform;
	import flash.events.MouseEvent;
	import flash.media.SoundMixer
	
	public class muteButton extends SimpleButton 
	{
		static var isAudioEnabled:Boolean = true;
		
		public function muteButton()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		function onAddedToStage(event:Event):void
		{
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		function onRemovedFromStage(event:Event):void
		{
			removeEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		function onMouseClick(event:MouseEvent):void
		{
			var s:SoundTransform = new SoundTransform();
			
			if (isAudioEnabled)
			{
				s.volume = 0;
				document.mute = true;
			}
			else
			{
				s.volume = 1;
				document.mute = false;
			}
			SoundMixer.soundTransform = s;
			isAudioEnabled = !isAudioEnabled;
		}
	}
	
}
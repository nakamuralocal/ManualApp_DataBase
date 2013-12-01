package Controllers.Views
{
	import flash.events.IEventDispatcher;
	
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	
	import Events.Oev_ErrorView;
	
	import Statics.Sta_UseViews;
	
	import avmplus.getQualifiedClassName;
	
	public class Vic_MainWindow extends Vic_ApplyWindow implements IMXMLObject
	{
		public function Vic_MainWindow(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function initialized(document:Object, id:String):void
		{
			view = document as ManualApp_DataBase;
			view.addEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
		}
		
		private var view:ManualApp_DataBase;
		
		private function complete_CreationView(evt:FlexEvent):void
		{
			view.removeEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
			
			var temp_ViewManager:Sta_UseViews = new Sta_UseViews();
			obj_ViewManager = temp_ViewManager.obj_UseView;
			
			grp_ViewStage.width = view.width;
			grp_ViewStage.height = view.height - 24;
			view.addElement(grp_ViewStage);
			
			grp_ErrorStage.width = view.width;
			grp_ErrorStage.height = view.height - 24;
			view.addElement(grp_ErrorStage);
			
			M_APP.change_View(Sta_UseViews.FIRST_VIEW);
		}
		
		override public function error_View(evt:Oev_ErrorView):void
		{
			var flg_Error:Boolean = true;
			
			trace(getQualifiedClassName(now_View));
			
			switch(getQualifiedClassName(now_View))
			{
				case "Views.Views::Viw_00_00_StartMenu":
					flg_Error = false;
					break;
			}
			
			if(flg_Error)
			{
				error_Stage(evt.catch_ErrorCode,evt.catch_ErrorMSG);
			}

		}
				
	}
}
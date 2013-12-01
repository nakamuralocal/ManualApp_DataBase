package Controllers.Views
{
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	
	import Singletons.Sig_APP_Master;
	import Singletons.Sig_Project_Master;
	import Singletons.Sig_ThisApp_Master;
	
	import Statics.Sta_UseViews;
	
	import Views.Views.Viw_01_01_DeployProjects;
	
	public class Vic_01_01_DeployProjects implements IMXMLObject
	{
		public function Vic_01_01_DeployProjects()
		{
		}
		
		public function initialized(document:Object, id:String):void
		{
			view = document as Viw_01_01_DeployProjects;
			view.addEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
		}
		
		private var view:Viw_01_01_DeployProjects;
		private var M_APP:Sig_APP_Master = Sig_APP_Master.getInstance();
		private var M_THIS_APP:Sig_ThisApp_Master = Sig_ThisApp_Master.getInstance();
		private var M_PROJECT:Sig_Project_Master = Sig_Project_Master.getInstance();

		private function complete_CreationView(evt:FlexEvent):void
		{
			view.removeEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
			view.prs_NewTable.viewCon.startUp_Deploy(Sta_UseViews.LABEL_00_00);
		}
		
	}
}
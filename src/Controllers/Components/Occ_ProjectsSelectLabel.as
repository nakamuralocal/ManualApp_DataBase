package Controllers.Components
{
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	
	import Models.Mod_WorkProjects;
	
	import Singletons.Sig_APP_Master;
	
	import Views.Components.Ocv_ProjectsSelectLabel;
		
	public class Occ_ProjectsSelectLabel implements IMXMLObject
	{
		public function Occ_ProjectsSelectLabel()
		{
		}
		
		public function initialized(document:Object, id:String):void
		{
			view = document as Ocv_ProjectsSelectLabel;
			view.addEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
		}
		
		private var view:Ocv_ProjectsSelectLabel;
		private var M_APP:Sig_APP_Master = Sig_APP_Master.getInstance();
		
		private function complete_CreationView(evt:FlexEvent):void
		{
			view.removeEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
			view.buttonMode = true;
		}
		
		public var my_DataModel:Mod_WorkProjects = new Mod_WorkProjects();
		
		public function setting_Data():void
		{
			view.lab_CarName.text = my_DataModel.CarName;
			view.lab_CreatedDate.text = M_APP.convert_DateToString(my_DataModel.date_Created);
			view.lab_UpDate.text = M_APP.convert_DateToString(my_DataModel.date_Update);
		}
		
	}
}
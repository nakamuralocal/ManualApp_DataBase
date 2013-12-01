package Controllers.Views
{
	
	import flash.events.MouseEvent;
	
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	import mx.utils.ObjectUtil;
	
	import Models.Mod_WorkProjects;
	
	import Singletons.Sig_APP_Master;
	import Singletons.Sig_Project_Master;
	import Singletons.Sig_ThisApp_Master;
	
	import Statics.Sta_UseViews;
	
	import Views.Components.Ocv_ProjectsSelectLabel;
	import Views.Views.Viw_00_00_StartMenu;
	
	public class Vic_00_00_StartMenu implements IMXMLObject
	{
		public function Vic_00_00_StartMenu()
		{
		}
		
		public function initialized(document:Object, id:String):void
		{
			view = document as Viw_00_00_StartMenu;
			view.addEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
		}
		
		private var view:Viw_00_00_StartMenu;
		private var M_APP:Sig_APP_Master = Sig_APP_Master.getInstance();
		private var M_THIS_APP:Sig_ThisApp_Master = Sig_ThisApp_Master.getInstance();
		private var M_PROJECT:Sig_Project_Master = Sig_Project_Master.getInstance();

		private function complete_CreationView(evt:FlexEvent):void
		{
			view.removeEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
			init();
		}
		
		private function init():void
		{
			view.vgr_SelectCars.removeAllElements();
			ary_ProjectsSelectLabel = new Array();
			
			view.btn_StartCreate.addEventListener(MouseEvent.CLICK , click_btn_StartCreate);
			
			M_THIS_APP.load_WorkProjects(setting_SelectCars);
		}
		
		private var ary_ProjectsSelectLabel:Array = new Array();
		
		public function setting_SelectCars():void
		{
			for each (var trg_DataObject:Mod_WorkProjects in M_THIS_APP.aryObj_WorkProjects)
			{
				var add_Elements:Ocv_ProjectsSelectLabel = new Ocv_ProjectsSelectLabel();
				view.vgr_SelectCars.addElement(add_Elements);
				
				add_Elements.viewCon.my_DataModel = trg_DataObject;
				add_Elements.viewCon.setting_Data();
				add_Elements.addEventListener(MouseEvent.CLICK , select_Cars);
				
				ary_ProjectsSelectLabel.push(add_Elements);
			}
		}
		
		public function select_Cars(evt:MouseEvent):void
		{
			var select_Elements:Ocv_ProjectsSelectLabel = evt.currentTarget as Ocv_ProjectsSelectLabel;
			
			M_PROJECT.load_ProjectFile(select_Elements.viewCon.my_DataModel.CarName);
			
			exit_View();
			
			M_APP.change_View(Sta_UseViews.LABEL_01_01);
		}
		
		public function click_btn_StartCreate(evt:MouseEvent):void
		{
			exit_View();
			
			M_APP.change_View(Sta_UseViews.LABEL_01_00);
		}
		
		private function exit_View():void
		{
			view.btn_StartCreate.removeEventListener(MouseEvent.CLICK , click_btn_StartCreate);

			for each(var trg_Elements:Ocv_ProjectsSelectLabel in ary_ProjectsSelectLabel)
			{
				trg_Elements.removeEventListener(MouseEvent.CLICK , select_Cars);
			}
		}
		
	}
}
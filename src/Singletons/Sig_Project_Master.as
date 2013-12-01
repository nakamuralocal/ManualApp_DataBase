package Singletons
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.utils.ObjectUtil;
	
	import Models.Mod_ProjectsFile;
	import Models.Mod_WorkProjects;
	
	public class Sig_Project_Master extends EventDispatcher
	{
		private var M_APP:Sig_APP_Master = Sig_APP_Master.getInstance();
		private var M_THIS_APP:Sig_ThisApp_Master = Sig_ThisApp_Master.getInstance();
		private var M_JSON:Sig_JSON_Master = Sig_JSON_Master.getInstance();

		public var aryObj_ProjectsFile:Object = new Object();
		public var now_ProjectsFile:Mod_ProjectsFile = new Mod_ProjectsFile();
		
		public function regist_ProjectFile():void
		{
			now_ProjectsFile.date_Created = new Date();
			M_THIS_APP.now_WorkProjects.date_Created = now_ProjectsFile.date_Created;
			save_ProjectFile();			
		}
		
		public function save_ProjectFile():void
		{
			now_ProjectsFile.date_Update = new Date();
			
			M_JSON.save_JSON(
				now_ProjectsFile,
				now_ProjectsFile.dir_ProjectSave,
				Mod_WorkProjects.fName);
			
			M_THIS_APP.now_WorkProjects.CarName = now_ProjectsFile.ProjectCarName;
			M_THIS_APP.now_WorkProjects.dir_ProjectsFile = now_ProjectsFile.dir_ProjectSave;
			M_THIS_APP.save_WorkProjects();
		}
		
		public function load_ProjectFile(trg_CarName:String):void
		{
			
			var trg_Dir:String = M_THIS_APP.setting_WorkProjects(trg_CarName);
			
			M_JSON.load_JSON(
				true,
				now_ProjectsFile,
				Mod_ProjectsFile,
				load_Complete,
				trg_Dir,
				Mod_WorkProjects.fName);
		}
		
		private function load_Complete(trg_Object:Object):void
		{
			for (var key:String in trg_Object)
			{
				var pass_String:String = trg_Object[key];
				
				if(pass_String.indexOf("GMT") >= 0)
				{
					var date_MillSec:Number = Date.parse(pass_String);
					var passDate:Date = new Date(date_MillSec);
					
					now_ProjectsFile[key] = passDate;
				} else {
					now_ProjectsFile[key] = trg_Object[key];
				}
			}
		}
		
		private static var _instance:Sig_Project_Master;
		
		public function Sig_Project_Master(privateClass:PrivateClass,target:IEventDispatcher=null)
		{
		}

		public static function getInstance():Sig_Project_Master {
			if (!_instance) {
				_instance = new Sig_Project_Master(new PrivateClass,null);
			}
			return _instance;
		}
	}
}

class PrivateClass {
}
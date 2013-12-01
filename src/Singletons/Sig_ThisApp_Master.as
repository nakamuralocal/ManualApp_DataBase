package Singletons
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	import Models.Mod_WorkProjects;
	
	public class Sig_ThisApp_Master extends EventDispatcher
	{
		public const dir_SaveFolder:String = File.applicationStorageDirectory.nativePath;
		public const fName_WorkProjects:String = "WorkProjects";

		private var M_APP:Sig_APP_Master = Sig_APP_Master.getInstance();
		private var M_JSON:Sig_JSON_Master = Sig_JSON_Master.getInstance();

		public var aryObj_WorkProjects:Object = new Object();
		public var now_WorkProjects:Mod_WorkProjects = new Mod_WorkProjects();
				
		public function save_WorkProjects():void
		{
			now_WorkProjects.date_Update = new Date();
			
			aryObj_WorkProjects[now_WorkProjects.CarName] = now_WorkProjects;
			
			M_JSON.save_JSON(
				aryObj_WorkProjects,
				dir_SaveFolder,
				fName_WorkProjects);
		}
		
		public function load_WorkProjects(trg_Function:Function):void
		{
			var complete_load_WorkProjects:Function = trg_Function;
			
			M_JSON.load_JSON(
				false,
				aryObj_WorkProjects,
				Mod_WorkProjects,
				complete_load_WorkProjects,
				dir_SaveFolder,
				fName_WorkProjects);
		}
		
		public function setting_WorkProjects(trg_CarName:String):String
		{
			now_WorkProjects = aryObj_WorkProjects[trg_CarName];
			
			return now_WorkProjects.dir_ProjectsFile;
		}
		
		private static var _instance:Sig_ThisApp_Master;
		
		public function Sig_ThisApp_Master(privateClass:PrivateClass,target:IEventDispatcher=null)
		{
		}

		public static function getInstance():Sig_ThisApp_Master {
			if (!_instance) {
				_instance = new Sig_ThisApp_Master(new PrivateClass,null);
			}
			return _instance;
		}
	}
}

class PrivateClass {
}
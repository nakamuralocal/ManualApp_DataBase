package Models
{
	import Singletons.Sig_APP_Master;

	public class Mod_ProjectsFile
	{
		private var M_APP:Sig_APP_Master = Sig_APP_Master.getInstance();
		
		//基本情報
		public var date_Created:Date;
		public var date_Update:Date;
		public var ProjectCarName:String = "";
		private var _dir_ProjectSave:String = "";
		public var ary_Grade:Array = new Array();
		public var ary_SubGrade:Array = new Array();
		public var ary_UseCheckBox:Array = new Array();
		
		//カタログ情報
		public var dir_CatalogSave:String = "";
		public var fName_CatalogMaster:String = "CatalogMaster";
		
		//タッチポイント情報
		public var dir_TouchPointSave:String = "";
		public var fName_TouchPointMaster:String = "TouchPointMaster";

		public function Mod_ProjectsFile()
		{
		}
		
		public function get dir_ProjectSave():String
		{
			return _dir_ProjectSave;
		}
		
		public function set dir_ProjectSave(trg_Path:String):void
		{
			_dir_ProjectSave = trg_Path;
			dir_CatalogSave = _dir_ProjectSave + M_APP.FS + "01_Catalog";
			dir_TouchPointSave = _dir_ProjectSave + M_APP.FS + "02_TouchPoint";
		}
	}
}
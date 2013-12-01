package Statics
{
	import mx.utils.ObjectUtil;
	
	import Views.Views.Viw_00_00_StartMenu;
	import Views.Views.Viw_01_00_CreateProjects;
	import Views.Views.Viw_01_01_DeployProjects;

	public class Sta_UseViews
	{
		public static const FIRST_VIEW:String = LABEL_00_00;
		
		public static var LABEL_00_00:String = "Viw_00_00";
		public static var CLASS_00_00:Class = Viw_00_00_StartMenu;
		
		public static var LABEL_01_00:String = "Viw_01_00";
		public static var CLASS_01_00:Class = Viw_01_00_CreateProjects;

		public static var LABEL_01_01:String = "Viw_01_01";
		public static var CLASS_01_01:Class = Viw_01_01_DeployProjects;

		public var obj_UseView:Object = new Object();
		
		public function Sta_UseViews()
		{
			var ary_Excludes:Array = [
				"obj_UseView"
				];
			
			var ary_ViewObject:Array = ObjectUtil.getClassInfo(Sta_UseViews,ary_Excludes, {includeReadOnly:false}).properties;
			var cnt_Loop:uint = ary_ViewObject.length / 2;
			
			for (var i:uint = 0 ; i < cnt_Loop ; i++)
			{
				var reg_Label:String = Sta_UseViews[ary_ViewObject[cnt_Loop + i]];
				var reg_Class:Class = Sta_UseViews[ary_ViewObject[i]];
				obj_UseView[reg_Label] = reg_Class;
			}
			
		}
	}
}
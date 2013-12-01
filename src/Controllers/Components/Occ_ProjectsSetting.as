package Controllers.Components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	
	import Events.Oev_FreeAddGroup;
	
	import Singletons.Sig_APP_Master;
	import Singletons.Sig_Project_Master;
	import Singletons.Sig_ThisApp_Master;
	
	import Views.Components.Ocv_ProjectsSetting;
	
	public class Occ_ProjectsSetting implements IMXMLObject
	{
		public function Occ_ProjectsSetting()
		{
		}
		
		public function initialized(document:Object, id:String):void
		{
			view = document as Ocv_ProjectsSetting;
			view.addEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
		}
		
		private var view:Ocv_ProjectsSetting;
		private var M_APP:Sig_APP_Master = Sig_APP_Master.getInstance();
		private var M_THIS_APP:Sig_ThisApp_Master = Sig_ThisApp_Master.getInstance();
		private var M_PROJECT:Sig_Project_Master = Sig_Project_Master.getInstance();
		
		private var flg_NewMode:Boolean = false;
		private var back_View:String = new String();
		private var next_View:String = new String();
		
		private function complete_CreationView(evt:FlexEvent):void
		{
			view.removeEventListener(FlexEvent.CREATION_COMPLETE , complete_CreationView);
		}
		
		public function startUp_NewMode(trg_NextView:String):void
		{
			next_View = trg_NextView;
			flg_NewMode = true;
			
			add_ButtonFunction();
			add_ComponentsFunction();
			
			view.mlb_WindowTitle.text = "基本情報設定：新規作成";
			view.fag_Grade.viewCon.update();
			view.fag_SubGrade.viewCon.update();
			
		}
		
		public function startUp_Deploy(trg_NextView:String):void
		{
			next_View = trg_NextView;
			flg_NewMode = false;
			
			add_ButtonFunction();
			add_ComponentsFunction();
			
			view.mlb_WindowTitle.text = "基本情報設定：編集";
			
			deploy_ProjectsFile();
		}
		
		private function click_btn_SelectSaveFolder(evt:MouseEvent):void
		{
			if(view.txi_CarName.text != "")
			{
				record_SaveFolder();
			}
		}
		
		private function record_SaveFolder():void
		{
			var temp_File:File = new File();
			temp_File.addEventListener(Event.SELECT,select_SaveFolder);
			temp_File.browseForDirectory("プロジェクトセーブフォルダー選択");
			
		}
		
		private function select_SaveFolder(evt:Event):void
		{
			evt.currentTarget.removeEventListener(Event.SELECT,select_SaveFolder);
			M_PROJECT.now_ProjectsFile.dir_ProjectSave = evt.currentTarget.nativePath;
			M_PROJECT.now_ProjectsFile.dir_ProjectSave += M_APP.FS + view.txi_CarName.text;
			deployments_SaveFolder();
		}
		
		private function deployments_SaveFolder():void
		{
			view.lab_SaveFolder.text = M_PROJECT.now_ProjectsFile.dir_ProjectSave;
		}
		
		private function update_tcb_Grade(evt:Oev_FreeAddGroup):void
		{
			var ary_Grade:Array = view.fag_Grade.viewCon.ary_Data;
			var ary_SubGrade:Array = view.fag_SubGrade.viewCon.ary_Data;
			
			view.tcb_Grade.viewCon.update(ary_Grade,ary_SubGrade,flg_NewMode);
		}
		
		private function click_btn_Next(evt:MouseEvent):void
		{
			var flg_check:Boolean = true;
			
			if(view.txi_CarName.text.match(/\w+/) == null)
			{
				flg_check = false;	
			}
			
			if(view.lab_SaveFolder.text.length <= 0)
			{
				flg_check = false;
			}
			
			var check_ary:Array = view.tcb_Grade.viewCon.throw_CheckValue();
			
			if(check_ary.length <= 0)
			{
				flg_check = false;
			} else {
				var check_UseFlg:uint = 0;
				
				for each (var trg_CK:Boolean in check_ary)
				{
					if(trg_CK){++check_UseFlg;}
				}
				
				if(check_UseFlg <=0)
				{
					flg_check = false;
				}
			}
			
			if(flg_check)
			{
				records_ProjectsFile();
				exit_View();
			}
		}
		
		private function records_ProjectsFile():void
		{
			//プロジェクト設定ファイルセーブ
			M_PROJECT.now_ProjectsFile.ProjectCarName = view.txi_CarName.text;
			M_PROJECT.now_ProjectsFile.dir_ProjectSave = view.lab_SaveFolder.text;
			M_PROJECT.now_ProjectsFile.ary_Grade = view.fag_Grade.viewCon.ary_Data;
			M_PROJECT.now_ProjectsFile.ary_SubGrade = view.fag_SubGrade.viewCon.ary_Data;
			M_PROJECT.now_ProjectsFile.ary_UseCheckBox = view.tcb_Grade.viewCon.throw_CheckValue();
			
			if(flg_NewMode)
			{
				M_PROJECT.regist_ProjectFile();
			} else {
				M_PROJECT.save_ProjectFile();
			}
		}
		
		private function deploy_ProjectsFile():void
		{
			//プロジェクト設定ファイルdeploy
			view.txi_CarName.text = M_PROJECT.now_ProjectsFile.ProjectCarName;
			view.lab_SaveFolder.text = M_PROJECT.now_ProjectsFile.dir_ProjectSave;
			view.fag_Grade.viewCon.update(M_PROJECT.now_ProjectsFile.ary_Grade);
			view.fag_SubGrade.viewCon.update(M_PROJECT.now_ProjectsFile.ary_SubGrade);
			//view.tcb_Grade.viewCon.throw_CheckValue() = M_PROJECT.now_ProjectsFile.ary_UseCheckBox;
		}
		
		private function add_ButtonFunction():void
		{
			view.btn_SelectSaveFolder.addEventListener(MouseEvent.CLICK,click_btn_SelectSaveFolder);
			view.btn_Next.addEventListener(MouseEvent.CLICK,click_btn_Next);
		}
		
		private function remove_ButtonFunction():void
		{
			view.btn_SelectSaveFolder.removeEventListener(MouseEvent.CLICK,click_btn_SelectSaveFolder);
			view.btn_Next.removeEventListener(MouseEvent.CLICK,click_btn_Next);
		}
		
		private function add_ComponentsFunction():void
		{
			view.fag_Grade.viewCon.addEventListener(Oev_FreeAddGroup.CHANGE_DATA,update_tcb_Grade);
			view.fag_SubGrade.viewCon.addEventListener(Oev_FreeAddGroup.CHANGE_DATA,update_tcb_Grade);
		}
		
		private function remove_ComponentsFunction():void
		{
			view.fag_Grade.viewCon.removeEventListener(Oev_FreeAddGroup.CHANGE_DATA,update_tcb_Grade);
			view.fag_SubGrade.viewCon.removeEventListener(Oev_FreeAddGroup.CHANGE_DATA,update_tcb_Grade);
		}
		
		private function exit_View():void
		{
			remove_ButtonFunction();
			remove_ComponentsFunction();
			
			view.fag_Grade.viewCon.exit_View();
			view.fag_SubGrade.viewCon.exit_View();
			view.tcb_Grade.viewCon.exit_View();
			
			M_APP.change_View(next_View);
		}
		
	}
}
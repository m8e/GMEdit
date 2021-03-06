package file.kind;

import editors.EditCode;
import electron.Dialog;
import electron.FileWrap;
import file.FileKind;
import gml.file.GmlFile;
import electron.FileSystem;

/**
 * ...
 * @author YellowAfterlife
 */
class KCode extends FileKind {
	
	/// language mode path for Ace
	public var modePath:String = "ace/mode/text";
	
	/// whether to do a GmlSeeker pass after saving to update definitions
	public var indexOnSave:Bool = false;
	
	public function new() {
		super();
	}
	
	override public function init(file:GmlFile, data:Dynamic):Void {
		file.codeEditor = new EditCode(file, modePath);
		file.editor = file.codeEditor;
	}
	
	public function loadCode(editor:EditCode, data:Dynamic):String {
		return data != null ? data : FileWrap.readTextFileSync(editor.file.path);
	}
	public function saveCode(editor:EditCode, code:String):Bool {
		FileWrap.writeTextFileSync(editor.file.path, code);
		return true;
	}
	
	/**
	 * Executed after getting the code from loadCode for pre-processing
	 * @return Modified code
	 */
	public function preproc(editor:EditCode, code:String):String {
		return code;
	}
	
	/**
	 * Executed before passing the code to saveCode for post-processing
	 * Whatever returned from here is then passed to saveCode.
	 * @return New code or null on error
	 */
	public function postproc(editor:EditCode, code:String):String {
		return code;
	}
}

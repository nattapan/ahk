#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

FileDeleteIdle(Path,IdleDays:=14,DeleteEmptyFolders:=1){
	Loop,Files,% Path,DFR
	{
		If InStr(A_LoopFileAttrib,"D"){
			Dirs.=A_LoopFileLongPath "`n"
			Continue
		}
		Dc:=A_LoopFileTimeCreated
		EnvSub,Dc,% A_Now,D
		Dm:=A_LoopFileTimeModified
		EnvSub,Dm,% A_Now,D
		;If (-Dc>=IdleDays && -Dm>=IdleDays)
		If ( -Dm>=IdleDays)
		FileDelete % A_LoopFileLongPath
	}
	If (DeleteEmptyFolders){
		Sort,Dirs,RU
		Loop,Parse,Dirs,`n
			FileRemoveDir,% A_Loopfield
	}
}
// example use
;FileDeleteidle("D:\DB\ieat_entrepreneur\archived\*.7z",7)
;FileDeleteidle("D:\DB\ieat_epp\archived\*.7z",7)

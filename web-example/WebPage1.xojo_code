#tag WebPage
Begin WebPage WebPage1
   AllowTabOrderWrap=   True
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   False
   Height          =   400
   ImplicitInstance=   True
   Index           =   -2147483648
   Indicator       =   0
   IsImplicitInstance=   False
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   MinimumHeight   =   400
   MinimumWidth    =   600
   PanelIndex      =   0
   ScaleFactor     =   0.0
   TabIndex        =   0
   Title           =   "Pomodoro #1"
   Top             =   0
   Visible         =   True
   Width           =   600
   _ImplicitInstance=   False
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin PomodoroViewModel ViewModel
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      LongBreakMinutesDuration=   15
      PomodoroMinutesDuration=   25
      Scope           =   2
      ShortBreakMinutesDuration=   5
   End
   Begin WebLabel RemainingTimeLabel
      Bold            =   True
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   42.0
      Height          =   123
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   167
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   0
      TabStop         =   True
      Text            =   "00:00"
      TextAlignment   =   2
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   139
      Underline       =   False
      Visible         =   True
      Width           =   266
      _mPanelIndex    =   -1
   End
   Begin WebSegmentedButton ModeSegmentedButton
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      LastSegmentIndex=   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      SegmentCount    =   0
      Segments        =   "Pomodoro\n\nTrue\rShort Break\n\nFalse\rLong Break\n\nFalse"
      SelectedSegmentIndex=   0
      SelectionStyle  =   1
      TabIndex        =   1
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Visible         =   True
      Width           =   354
      _mPanelIndex    =   -1
   End
   Begin WebButton StartStopButton
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Start"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   250
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   2
      TabStop         =   True
      Tooltip         =   ""
      Top             =   342
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebButton SkipButton
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Skip"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   480
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   3
      TabStop         =   True
      Tooltip         =   ""
      Top             =   342
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Opening()
		  ViewModel.Mode = PomodoroViewModel.Modes.Pomodoro
		  ViewModel.State = PomodoroViewModel.States.Ready
		End Sub
	#tag EndEvent


#tag EndWindowCode

#tag Events ViewModel
	#tag Event
		Sub Completed(pomodoros As Integer)
		  Self.Title = "Pomodoro #" + Str(pomodoros + 1)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ModeChanged(newMode As PomodoroViewModel.Modes)
		  ModeSegmentedButton.SelectedSegmentIndex = CType(newMode, Integer)
		End Sub
	#tag EndEvent
	#tag Event
		Sub RemainingSecondsChanged(minutes As Integer, seconds As Integer)
		  RemainingTimeLabel.Text = minutes.ToString(Nil, "00") + ":" + seconds.ToString(Nil, "00")
		End Sub
	#tag EndEvent
	#tag Event
		Sub StateChanged(newState As PomodoroViewModel.States)
		  Select Case newState
		  Case PomodoroViewModel.States.Ready
		    StartStopButton.Caption = "Start"
		    SkipButton.Visible = False
		  Case PomodoroViewModel.States.Running
		    StartStopButton.Caption = "Pause"
		    SkipButton.Visible = True
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModeSegmentedButton
	#tag Event
		Sub Pressed(segmentIndex As Integer)
		  ViewModel.Mode = PomodoroViewModel.Modes(segmentIndex)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StartStopButton
	#tag Event
		Sub Pressed()
		  Var isRunning As Boolean = ViewModel.State = PomodoroViewModel.States.Running
		  ViewModel.State = If(isRunning, PomodoroViewModel.States.Ready, PomodoroViewModel.States.Running)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SkipButton
	#tag Event
		Sub Pressed()
		  ViewModel.CompleteCurrent
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="PanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlCount"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mPanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutType"
		Visible=true
		Group="Behavior"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_ImplicitInstance"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mName"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsImplicitInstance"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabOrderWrap"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Visual Controls"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Indicator"
		Visible=false
		Group="Visual Controls"
		InitialValue=""
		Type="WebUIControl.Indicators"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Primary"
			"2 - Secondary"
			"3 - Success"
			"4 - Danger"
			"5 - Warning"
			"6 - Info"
			"7 - Light"
			"8 - Dark"
			"9 - Link"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutDirection"
		Visible=true
		Group="WebView"
		InitialValue="LayoutDirections.LeftToRight"
		Type="LayoutDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - LeftToRight"
			"1 - RightToLeft"
			"2 - TopToBottom"
			"3 - BottomToTop"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="ScaleFactor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior

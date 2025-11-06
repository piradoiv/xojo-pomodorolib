#tag MobileScreen
Begin MobileScreen MainScreen
   BackButtonCaption=   ""
   BackgroundColor =   
   Compatibility   =   ""
   ControlCount    =   0
   Device = 1
   HasNavigationBar=   True
   LargeTitleDisplayMode=   2
   Left            =   0
   NavigationBarColor=   
   NavigationBarTextColor=   
   Orientation = 0
   ScaleFactor     =   0.0
   TabBarVisible   =   True
   TabIcon         =   0
   TintColor       =   
   Title           =   "Pomodoro #1"
   Top             =   0
   _mTabBarVisible =   False
   Begin PomodoroViewModel ViewModel
      Left            =   0
      LockedInPosition=   False
      LongBreakMinutesDuration=   15
      PanelIndex      =   -1
      Parent          =   ""
      PomodoroMinutesDuration=   25
      Scope           =   2
      ShortBreakMinutesDuration=   5
      Top             =   0
   End
   Begin MobileSegmentedButton ModeSegmentedButton
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   ModeSegmentedButton, 1, <Parent>, 1, False, +1.00, 4, 1, *kStdGapCtlToViewH, , True
      AutoLayout      =   ModeSegmentedButton, 2, <Parent>, 2, False, +1.00, 4, 1, -*kStdGapCtlToViewH, , True
      AutoLayout      =   ModeSegmentedButton, 3, TopLayoutGuide, 4, False, +1.00, 4, 1, *kStdControlGapV, , True
      AutoLayout      =   ModeSegmentedButton, 8, , 0, True, +1.00, 4, 1, 29, , True
      ControlCount    =   0
      Enabled         =   True
      Height          =   29
      LastSegmentIndex=   0
      Left            =   20
      LockedInPosition=   False
      Scope           =   2
      SegmentCount    =   0
      Segments        =   "Pomodoro\n\nTrue\rShort Break\n\nFalse\rLong Break\n\nFalse"
      SelectedSegmentIndex=   0
      TintColor       =   
      Top             =   73
      Visible         =   True
      Width           =   280
      _ClosingFired   =   False
   End
   Begin MobileLabel RemainingTimeLabel
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AdjustTextSizeToFit=   False
      Alignment       =   1
      AutoLayout      =   RemainingTimeLabel, 4, SkipButton, 3, False, +1.00, 4, 1, -*kStdControlGapV, , True
      AutoLayout      =   RemainingTimeLabel, 1, ModeSegmentedButton, 1, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   RemainingTimeLabel, 2, ModeSegmentedButton, 2, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   RemainingTimeLabel, 3, ModeSegmentedButton, 4, False, +1.00, 4, 1, *kStdControlGapV, , True
      ControlCount    =   0
      Enabled         =   True
      Height          =   382
      Left            =   20
      LineBreakMode   =   0
      LockedInPosition=   False
      MaximumCharactersAllowed=   0
      Scope           =   2
      SelectedText    =   ""
      SelectionLength =   0
      SelectionStart  =   0
      Text            =   "00:00"
      TextColor       =   &c00000000
      TextFont        =   "System Bold		"
      TextSize        =   64
      TintColor       =   
      Top             =   110
      Visible         =   True
      Width           =   280
      _ClosingFired   =   False
   End
   Begin MobileButton SkipButton
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AdjustTextSizeToFit=   False
      AutoLayout      =   SkipButton, 4, BottomLayoutGuide, 3, False, +1.00, 4, 1, -*kStdControlGapV, , True
      AutoLayout      =   SkipButton, 8, , 0, False, +1.00, 4, 1, 60, , True
      AutoLayout      =   SkipButton, 1, <Parent>, 1, False, +1.00, 4, 1, *kStdGapCtlToViewH, , True
      AutoLayout      =   SkipButton, 2, <Parent>, 2, False, +1.00, 4, 1, -*kStdGapCtlToViewH, , True
      BackgroundColor =   
      BorderColor     =   
      BorderWidth     =   0
      Caption         =   "Skip"
      CaptionColor    =   &c007AFF00
      ControlCount    =   0
      CornerSize      =   0
      Enabled         =   True
      Height          =   60
      Icon            =   0
      Left            =   20
      LockedInPosition=   False
      Scope           =   2
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   
      Top             =   500
      Visible         =   True
      Width           =   280
      _ClosingFired   =   False
   End
   Begin MobileToolbarButton PlayPauseButton
      Caption         =   "Play"
      Enabled         =   True
      Height          =   22
      Icon            =   0
      Left            =   277
      LockedInPosition=   False
      Scope           =   2
      Top             =   32
      Type            =   1001
      Width           =   35.0
   End
End
#tag EndMobileScreen

#tag WindowCode
	#tag Event
		Sub ToolbarButtonPressed(button As MobileToolbarButton)
		  Select Case button
		  Case PlayPauseButton
		    Var isRunning As Boolean = ViewModel.State = PomodoroViewModel.States.Running
		    ViewModel.State = If(isRunning, PomodoroViewModel.States.Ready, PomodoroViewModel.States.Running)
		  End Select
		End Sub
	#tag EndEvent


#tag EndWindowCode

#tag Events ViewModel
	#tag Event
		Sub Completed(pomodoros As Integer)
		  Title = "Pomodoro #" + Str(pomodoros + 1)
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
		    PlayPauseButton.Caption = "Start"
		    SkipButton.Visible = False
		  Case PomodoroViewModel.States.Running
		    PlayPauseButton.Caption = "Pause"
		    SkipButton.Visible = True
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModeSegmentedButton
	#tag Event
		Sub Pressed(segmentedIndex As Integer)
		  ViewModel.Mode = PomodoroViewModel.Modes(segmentedIndex)
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
		Name="BackButtonCaption"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasNavigationBar"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIcon"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="Picture"
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
		Name="LargeTitleDisplayMode"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="MobileScreen.LargeTitleDisplayModes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Automatic"
			"1 - Always"
			"2 - Never"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabBarVisible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TintColor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="ColorGroup"
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
		Name="ScaleFactor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mTabBarVisible"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="ColorGroup"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="NavigationBarColor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="ColorGroup"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="NavigationBarTextColor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="ColorGroup"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior

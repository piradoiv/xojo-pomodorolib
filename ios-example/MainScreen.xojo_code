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
      TextColor       =   &c000000
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
      Caption         =   "Untitled"
      Enabled         =   True
      Height          =   22
      Icon            =   0
      Left            =   290
      LockedInPosition=   False
      Scope           =   2
      Top             =   32
      Type            =   17
      Width           =   22.0
   End
End
#tag EndMobileScreen

#tag WindowCode
	#tag Event
		Sub ToolbarButtonPressed(button As MobileToolbarButton)
		  Select Case button
		  Case PlayPauseButton
		    Var isRunning As Boolean = ViewModel.Mode = PomodoroViewModel.Modes.Running
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
		Sub RemainingSecondsChanged(totalSeconds As Integer, remainingSeconds As Integer)
		  Var minutes As Integer = Floor(remainingSeconds / 60)
		  Var seconds As Integer = remainingSeconds Mod 60
		  RemainingTimeLabel.Text = minutes.ToString(Nil, "00") + ":" + seconds.ToString(Nil, "00")
		End Sub
	#tag EndEvent
	#tag Event
		Sub StateChanged(newState As PomodoroViewModel.States)
		  Select Case newState
		  Case PomodoroViewModel.States.Ready
		    PlayPauseButton.Type = MobileToolbarButton.Types.Play
		    SkipButton.Visible = False
		  Case PomodoroViewModel.States.Running
		    PlayPauseButton.Type = MobileToolbarButton.Types.Pause
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

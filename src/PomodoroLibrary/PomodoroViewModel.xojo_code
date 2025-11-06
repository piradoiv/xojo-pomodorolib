#tag Class
Protected Class PomodoroViewModel
	#tag Method, Flags = &h0
		Sub CompleteCurrent()
		  State = States.Ready
		  Select Case Mode
		  Case Modes.Pomodoro
		    mPomodorosCompleted = mPomodorosCompleted + 1
		    Mode = If(mPomodorosCompleted Mod 4 = 0, Modes.LongBreak, Modes.ShortBreak)
		  Case Modes.ShortBreak
		    Mode = Modes.Pomodoro
		  Case Modes.LongBreak
		    Mode = Modes.Pomodoro
		  End Select
		  
		  RaiseEvent Completed(mPomodorosCompleted)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mInternalTimer = New Timer
		  mInternalTimer.Period = 250
		  mInternalTimer.RunMode = Timer.RunModes.Off
		  
		  #If TargetIOS
		    AddHandler mInternalTimer.Run, WeakAddressOf TimerAction
		  #Else
		    AddHandler mInternalTimer.Action, WeakAddressOf TimerAction
		  #EndIf
		  
		  Mode = Modes.Pomodoro
		  State = States.Ready
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SecondsForMode(mode As Modes) As Integer
		  Select Case mode
		  Case Modes.Pomodoro
		    Return 25 * 60
		  Case Modes.ShortBreak
		    Return 5 * 60
		  Case Modes.LongBreak
		    Return 15 * 60
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Tick()
		  Var interval As DateInterval = mFinishTime - DateTime.Now
		  Var remaining As Integer = interval.Minutes * 60 + interval.Seconds
		  
		  If mRemainingSeconds <> remaining Then
		    mRemainingSeconds = remaining
		    RaiseEvent RemainingSecondsChanged(SecondsForMode(mMode), mRemainingSeconds)
		  End If
		  
		  If remaining <= 0 Then
		    CompleteCurrent
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TimerAction(sender As Timer)
		  Tick
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Completed(pomodoros As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ModeChanged(newMode As PomodoroViewModel.Modes)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RemainingSecondsChanged(totalSeconds As Integer, remainingSeconds As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event StateChanged(newState As PomodoroViewModel.States)
	#tag EndHook


	#tag Property, Flags = &h0
		LongBreakMinutesDuration As Integer = 15
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinishTime As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInternalTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As Modes = Modes.Pomodoro
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mMode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mMode = value
			  State = States.Ready
			  
			  mRemainingSeconds = SecondsForMode(value)
			  
			  mFinishTime = DateTime.Now.AddInterval(0, 0, 0, 0, 0, mRemainingSeconds + 1)
			  
			  RaiseEvent Completed(mPomodorosCompleted)
			  RaiseEvent ModeChanged(mMode)
			  RaiseEvent RemainingSecondsChanged(SecondsForMode(mMode), mRemainingSeconds)
			End Set
		#tag EndSetter
		Mode As PomodoroViewModel.Modes
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mPomodorosCompleted As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRemainingSeconds As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mState As States = States.Ready
	#tag EndProperty

	#tag Property, Flags = &h0
		PomodoroMinutesDuration As Integer = 25
	#tag EndProperty

	#tag Property, Flags = &h0
		ShortBreakMinutesDuration As Integer = 5
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mState
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mState = value
			  
			  Select Case value
			  Case States.Ready
			    mInternalTimer.RunMode = Timer.RunModes.Off
			    Var finishTime As DateTime = mFinishTime
			    If finishTime = Nil Then
			      finishTime = DateTime.Now
			    End If
			    Var interval As DateInterval = finishTime - DateTime.Now
			    mRemainingSeconds = interval.Minutes * 60 + interval.Seconds
			    mFinishTime = Nil
			  Case States.Running
			    mFinishTime = DateTime.Now.AddInterval(0, 0, 0, 0, 0, mRemainingSeconds)
			    mInternalTimer.RunMode = Timer.RunModes.Multiple
			  End Select
			  
			  RaiseEvent StateChanged(mState)
			End Set
		#tag EndSetter
		State As PomodoroViewModel.States
	#tag EndComputedProperty


	#tag Enum, Name = Modes, Flags = &h0
		Pomodoro
		  ShortBreak
		LongBreak
	#tag EndEnum

	#tag Enum, Name = States, Flags = &h0
		Ready
		Running
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="PomodoroMinutesDuration"
			Visible=false
			Group="Behavior"
			InitialValue="25"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LongBreakMinutesDuration"
			Visible=false
			Group="Behavior"
			InitialValue="15"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShortBreakMinutesDuration"
			Visible=false
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="PomodoroViewModel.Modes"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="State"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="PomodoroViewModel.States"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

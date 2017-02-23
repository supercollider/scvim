" Copyright 2007 Alex Norman
" This file is part of SCVIM.
"
" SCVIM is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" SCVIM is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with SCVIM.  If not, see <http://www.gnu.org/licenses/>.
"
" Vim syntax file
" Language:	supercollider	
" Maintainer: Stephen Lumenta <stephen.lumenta@gmail.com>
" Version:	0.2
" Last change:	2012-03-31

if exists("b:current_syntax")
    finish
endif

syn clear

syn match	scAoperator	"{"
syn match	scAoperator	"}"

"syn	match	scVariable	"\%(var.*\)\@<=\(\l\w*\)" "lowercase followed by wordchar
syn	match	scGlobvariable	"\~\l\w*" "~ followed by lowercase followed by wordchar
syn	match scVar "\s*var\s"
syn	match scVar "\s*classvar\s"
syn	match scArg "\s*arg\s"

" symbols, strings, numbers
syn match	scSymbol "\v(\w|\\)@<!\'.{-}(\\)@<!\'" "\{-} is a non greedy version of *
syn match	scSymbol "\v\$@<!\\\w\w*"
syn match	scSymbol "\\\\"
syn match	scSymbol "\w\+:"

syn region  scString start=+"+ skip=+\\\\\|\\"+ end=+"+

syn match	scChar	"\$\w"
syn match	scChar	"\$\\\\"
syn match	scChar	"\$\\\w"

syn match scInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[xX]\x\+\%(_\x\+\)*\>"								display
syn match scInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0[dD]\)\=\%(0\|[1-9]\d*\%(_\d\+\)*\)\>"						display
syn match scInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[oO]\=\o\+\%(_\o\+\)*\>"								display
syn match scInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[bB][01]\+\%(_[01]\+\)*\>"								display
syn match scFloat	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\.\d\+\%(_\d\+\)*\>"					display
syn match scFloat	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\%(\.\d\+\%(_\d\+\)*\)\=\%([eE][-+]\=\d\+\%(_\d\+\)*\)\>"	display
syn match scInfinity "inf"	

" keywords
syn match   scControl	"\<\%(break\|rescue\|return\)\>[?!]\@!"
syn match   scKeyword	"\<\%(super\|this\|new\|yield\)\>[?!]\@!"
syn match   scBoolean	"\<\%(true\|false\)\>[?!]\@!"
syn match   scControl "\<\%(case\|begin\|do\|forBy\|loop\|if\|while\|else\)\>[?!]\@!"

" scsynth
syn match scArate "\v\.@<=ar(\w)@!"
syn match scKrate "\v\.@<=kr(\w)@!"

" operators
syn keyword  scUnaryoperator  neg reciprocal abs floor ceil frac sign squared cubed sqrt exp midicps cpsmidi midiratio ratiomidi dbamp ampdb octcps cpsoct log log2 log10 sin cos tan asin acos atan sinh cosh tanh distort softclip isPositive isNegative isStrictlyPositive
syn keyword  scBinaryoperator  min max round trunc atan2 hypot hypotApx ring1 ring2 ring3 ring4 sumsqr difsqr sqrsum sqrdif absdif thresh amclip scaleneg clip2 wrap2 fold2 excess + - *

syn match scBinaryoperator "+"
syn match scBinaryoperator "-"
syn match scBinaryoperator "*"
syn match scBinaryoperator "/"
syn match scBinaryoperator "%"
syn match scBinaryoperator "\*\*"
syn match scBinaryoperator "<"
syn match scBinaryoperator "<="
syn match scBinaryoperator ">"
syn match scBinaryoperator "<>"
syn match scBinaryoperator ">="
syn match scBinaryoperator "="
syn match scBinaryoperator "=="
syn match scBinaryoperator "==="
syn match scBinaryoperator "!="
syn match scBinaryoperator "!=="
syn match scBinaryoperator "&"
syn match scBinaryoperator "|"
syn match scBinaryoperator "<!"
syn match scBinaryoperator "?"
syn match scBinaryoperator "??"
syn match scBinaryoperator "!?"
syn match scBinaryoperator "!"
syn match scBinaryoperator "#"
syn match scBinaryoperator "_"
syn match scBinaryoperator "\.\."
syn match scBinaryoperator "\.\.\."
syn match scBinaryoperator "`"
syn match scBinaryoperator ":"

" Classes
syn keyword scClass A2B A2K AbstractDispatcher AbstractFunction AbstractGroup AbstractIn AbstractMDPlugin AbstractMessageMatcher AbstractNodeWatcher AbstractOpPlug AbstractOut AbstractPlayControl AbstractResponderFunc AbstractScroll AbstractServerAction AbstractStepValue AbstractSystemAction AbstractWrappingDispatcher Allpass1 Allpass2 AllpassC AllpassL AllpassN AmpComp AmpCompA Amplitude AmplitudeMod AnalyseEvents2 APF AppClock ApplicationStart Archive Array Array2D ArrayedCollection ArrayMax ArrayMin Association Atk AtkKernelConv AtkMatrix AtkMatrixMix AtsAmp AtsBand AtsFile AtsFreq AtsNoise AtsNoiSynth AtsParInfo AtsPartial AtsSynth AtsUGen AttackSlope AudioControl AudioIn AudioMSG AutoTrack AverageOutput AY
syn keyword scClass B2A B2Ster B2UHJ Bag Balance Balance2 Ball BAllPass BasicNodeWatcher BasicOpUGen BBandPass BBandStop BBlockerBuf BBlockerProgram BeatStatistics BeatTrack BeatTrack2 BendResponder BEQSuite BF BFDecode BFDecode1 BFDecoder BFEncode BFEncode1 BFEncode2 BFEncodeSter BFFreeVerb BFGrainPanner BFGVerb BFManipulate BFPanner BHiPass BHiPass4 BHiShelf BhobHiShelf BhobLoShelf BhobTone BHPF BinaryOpFailureError BinaryOpFunction BinaryOpFunctionProxy BinaryOpPlug BinaryOpStream BinaryOpUGen BinaryOpXStream BinData BiPanB2 BlankGridLines BLBufRd Blip BlitB3 BlitB3D BlitB3Saw BlitB3Square BlitB3Tri BlockSize BLowPass BLowPass4 BLowShelf BLPF BMoog Boolean BPeakEQ BPF BPZ2 Breakcore BRF BrownNoise Brusselator BRZ2 BtoUHJ BufAllpassC BufAllpassL BufAllpassN BufChannels BufCombC BufCombL BufCombN BufDelayC BufDelayL BufDelayN BufDur Buffer BufFrames BufGrain BufGrainB BufGrainBBF BufGrainBF BufGrainI BufGrainIBF BufInfoUGenBase BufMax BufMin BufRateScale BufRd BufSampleRate BufSamples BufWr BundleNetAddr Bus BusPlug BusScopeSynth Button
syn keyword scClass CCResponder Cepstrum Changed ChaosGen Char CheapVerb CheckBadValues CheckBox Chromagram CircleRamp Class ClassBrowser ClassInspector CleanupStream ClearBuf Clip ClipNoise Clipper32 Clipper4 Clipper8 Clock Clockmus CmdPeriod CoinGate Collection CollStream Color CombC CombL CombLP CombN Compander CompanderD Complex ComplexRes CompositeView Concat Concat2 Condition ContiguousBlock ContiguousBlockAllocator Control ControlDur ControlName ControlRate ControlSpec Convolution Convolution2 Convolution2L Convolution3 COsc CosineWarp Coyote CQ_Diff Crackle Crest CrossoverDistortion CSVFileReader CurveWarp CuspL CuspN
syn keyword scClass Date DbFaderWarp Dbrown Dbrown2 Dbufrd DbufTag Dbufwr DC Dconst DebugFrame DebugNodeWatcher Decay Decay2 Decimator DecodeB2 Decorator DegreeToKey Delay1 Delay2 DelayC DelayL DelayN DelayWr DelTapRd DelTapWr Demand DemandEnvGen DeprecatedError DetaBlockerBuf DetectIndex DetectSilence DFM1 Dfsm Dgauss Dgeom Dialog Dibrown Dictionary DiodeRingMod Disintegrator DiskIn DiskOut Diwhite Dneuromodule DNoiseRing Document DoesNotUnderstandError Donce Done DoubleArray DoubleNestedAllpassC DoubleNestedAllpassL DoubleNestedAllpassN DoubleWell DoubleWell2 DoubleWell3 Download Dpoll DPW3Tri DPW4Saw DragBoth DragSink DragSource DragView Drand DrawGrid DrawGridX DrawGridY Dreset DriveNoise DrumTrack Dseq Dser Dseries Dshuf Dstutter Dswitch Dswitch1 Dtag DUGen Dunique Dust Dust2 Duty DWGBowed DWGBowedSimple DWGBowedTor DWGPlucked DWGPlucked2 DWGPluckedStiff DWGSoundBoard Dwhite Dwrand Dxrand DynKlang DynKlank
syn keyword scClass EmbedOnce Env EnvDetect EnvelopeView EnvFollow EnvGate EnvGen EnvirGui Environment EnvironmentRedirect Error Event EventPatternProxy EventStreamCleanup EventStreamPlayer EventTypesWithCleanup Exception ExponentialWarp ExpRand EZControlSpecEditor EZGui EZKnob EZLists EZListView EZNumber EZPopUpMenu EZRanger EZScroller EZSlider EZText
syn keyword scClass FaderWarp False FBSineC FBSineL FBSineN Fdef FeatureSave Feedback FFT FFTCentroid FFTComplexDev FFTCrest FFTDiffMags FFTFlux FFTFluxPos FFTMKL FFTPeak FFTPhaseDev FFTPower FFTSlope FFTSpread FFTSubbandFlatness FFTSubbandFlux FFTSubbandPower FFTTrigger Fhn2DC Fhn2DL Fhn2DN FhnTrig File FileDialog FileReader Filter FilterPattern Finalizer FincoSprottL FincoSprottM FincoSprottS FitzHughNagumo Float FloatArray FlowLayout FlowVar FlowView FlowViewLayout FM7 FMGrain FMGrainB FMGrainBBF FMGrainBF FMGrainI FMGrainIBF FMHDecode1 FMHEncode0 FMHEncode1 FMHEncode2 Foa FoaAsymmetry FoaBalance FoaDecode FoaDecoderKernel FoaDecoderMatrix FoaDirect FoaDirectO FoaDirectX FoaDirectY FoaDirectZ FoaDominate FoaDominateX FoaDominateY FoaDominateZ FoaEncode FoaEncoderKernel FoaEncoderMatrix FoaFocus FoaFocusX FoaFocusY FoaFocusZ FoaMirror FoaNFC FoaPanB FoaPress FoaPressX FoaPressY FoaPressZ FoaProximity FoaPsychoShelf FoaPush FoaPushX FoaPushY FoaPushZ FoaRotate FoaRTT FoaSpeakerMatrix FoaTilt FoaTransform FoaTumble FoaUGen FoaXform FoaXformerMatrix FoaZoom FoaZoomX FoaZoomY FoaZoomZ Fold Font Formant FormantTable Formlet FOS Frame FrameCompare FrameInspector Free FreeSelf FreeSelfWhenDone FreeVerb FreeVerb1 FreeVerb2 FreqScope FreqScopeView FreqScopeWindow FreqShift Friction FSinOsc FuncFilterPattern FuncStream FuncStreamAsRoutine Function FunctionDef FunctionDefInspector FunctionList
syn keyword scClass Gammatone Gate GaussClass GaussTrig Gbman2DC Gbman2DL Gbman2DN GbmanL GbmanN GbmanTrig Gendy1 Gendy2 Gendy3 Gendy4 Gendy5 Getenv Git GlitchBPF GlitchBRF GlitchHPF GlitchRHPF Goertzel Gradient GrainBuf GrainBufJ GrainFM GrainFMJ GrainIn GrainInJ GrainSin GrainSinJ GraphBuilder GravityGrid GravityGrid2 GrayNoise Greyhole GreyholeRaw GridLayout GridLines Group GUI GVerb
syn keyword scClass HairCell Harmonics Hasher Help HelpBrowser Henon2DC Henon2DL Henon2DN HenonC HenonL HenonN HenonTrig HID HIDCollection HIDdef HIDDeviceDispatcher HIDElement HIDElementDispatcher HIDElementProto HIDElementProtoDispatcher HIDFunc HIDFuncDeviceProtoMatcher HIDFuncElementProtoMatcher HIDInfo HIDProto HIDRawValueMatcher HIDUsage HIDUsageDispatcher HIDValueMatcher HighShelf Hilbert HilbertFIR HiliteGradient History HistoryGui HLayout HLayoutView HPF HPZ1 HPZ2
syn keyword scClass ICepstrum IdentityBag IdentityDictionary IdentitySet IEnvGen IFFT IIRFilter Image ImmutableError Impulse In InBus Index IndexInBetween IndexL InFeedback InfoUGenBase InGrain InGrainB InGrainBBF InGrainBF InGrainI InGrainIBF InRange InRect InsideOut Inspector Instruction Int16Array Int32Array Int8Array Integer Integrator InterplChord InterplEnv InterplPairs InterplXYC Interpreter Interval InTrig IODesc IOStream IRand ItemViewBase
syn keyword scClass JITGui JoshGrain JoshMultiChannelGrain JoshMultiOutGrain JPverb JPverbRaw
syn keyword scClass K2A KeyClarity KeyMode KeyState KeyTrack Klang Klank KMeansRT KmeansToBPSet1 Knob
syn keyword scClass LADSPA Lag Lag2 Lag2UD Lag3 Lag3UD LagControl LagIn LagUD LanguageConfig LastValue Latch Latoocarfian2DC Latoocarfian2DL Latoocarfian2DN LatoocarfianC LatoocarfianL LatoocarfianN LatoocarfianTrig Layout LazyEnvir LeakDC LeastChange LevelIndicator LFBrownNoise0 LFBrownNoise1 LFBrownNoise2 LFClipNoise LFCub LFDClipNoise LFDNoise0 LFDNoise1 LFDNoise3 LFGauss LFNoise0 LFNoise1 LFNoise2 LFPar LFPulse LFSaw LFTri Library LibraryBase LID LIDAbsInfo LIDAbsSlot LIDGui LIDInfo LIDKeySlot LIDLedSlot LIDMscSlot LIDRelSlot LIDSlot LimitedWriteStream Limiter LinCongC LinCongL LinCongN Line LinearWarp LineLayout Linen LinExp LinkedList LinkedListNode LinLin LinPan2 LinRand LinSelectX LinuxPlatform LinXFade2 List ListDUGen ListPattern ListTrig ListTrig2 ListView LocalBuf LocalIn LocalOut Logger Logistic LoopBuf Lorenz2DC Lorenz2DL Lorenz2DN LorenzL LorenzTrig Loudness LowShelf LPCAnalyzer LPCError LPCSynth LPCVals LPF LPF1 LPF18 LPFVS6 LPZ1 LPZ2 LRHPF LRLPF LRUNumberAllocator LTI
syn keyword scClass Magnitude Main MantissaMask MarkovSynth MatchingP MatchingPResynth Max Maxamp MaxLocalBufs Maybe MCLDChaosGen MdaPiano MeanTriggered Meddis Median MedianSeparation MedianTriggered MembraneCircle MembraneHexagon Message Method MethodError MethodInspector MethodOverride MethodQuote Metro MFCC MidEQ MIDIClient MIDIdef MIDIEndPoint MIDIEvent MIDIFunc MIDIFuncBothCAMessageMatcher MIDIFuncBothMessageMatcher MIDIFuncChanArrayMessageMatcher MIDIFuncChanMessageMatcher MIDIFuncSrcMessageMatcher MIDIFuncSrcMessageMatcherNV MIDIFuncSrcSysMessageMatcher MIDIFuncSrcSysMessageMatcherND MIDIIn MIDIMessageDispatcher MIDIMessageDispatcherNV MIDIMTCtoSMPTEDispatcher MIDIOut MIDIResponder MIDISMPTEAssembler MIDISysDataDispatcher MIDISysDataDropIndDispatcher MIDISysexDispatcher MIDISysNoDataDispatcher MIDIValueMatcher Mix MixedBundle ModDif Module Monitor MonitorGui MonoGrain MonoGrainBF MoogFF MoogLadder MoogVCF MostChange MouseButton MouseX MouseY MovieView MulAdd MultiLevelIdentityDictionary MultiOutDemandUGen MultiOutUGen MultiSliderView MultiTap MustBeBooleanError
syn keyword scClass NamedControl NAryOpFunction NAryOpFunctionProxy NAryOpStream NAryValueProxy Ndef NdefGui NdefMixer NdefMixerOld NdefParamGui NearestN NeedleRect NestedAllpassC NestedAllpassL NestedAllpassN NetAddr Nil NL NL2 NLFiltC NLFiltL NLFiltN Node NodeControl NodeID NodeIDAllocator NodeMap NodeProxy NodeProxyEditor NodeWatcher Normalizer Notch NoteOffResponder NoteOnResponder NotificationCenter NotificationRegistration NotYetImplementedError NRand NTube NumAudioBuses Number NumberBox NumBuffers NumChannels NumControlBuses NumInputBuses NumOutputBuses NumRunningSynths
syn keyword scClass Object ObjectGui ObjectInspector ObjectTable OffsetOut OnePole OnError OneShotStream OneZero Onsets OnsetsDS OnsetStatistics Order OrderedIdentitySet Oregonator Osc OSCArgsMatcher OSCBundle OSCdef OSCFunc OSCFuncAddrMessageMatcher OSCFuncBothMessageMatcher OSCFuncRecvPortMessageMatcher OSCMessageDispatcher OSCMessagePatternDispatcher OSCMultiResponder OscN OSCpathDispatcher OSCpathResponder OSCresponder OSCresponderNode OSFold4 OSFold8 OSTrunc4 OSTrunc8 OSWrap4 OSWrap8 OteyPiano OteyPianoStrings OteySoundBoard Out OutOfContextReturnError OutputProxy
syn keyword scClass PAbstractGroup PackFFT Padd Paddp Paddpre PageLayout Pair Pan2 Pan4 PanAz PanB PanB2 PanX PanX2D ParamView ParGroup PartConv PathName Pattern PatternConductor PatternControl PatternProxy Pause PauseSelf PauseSelfWhenDone PauseStream Pavaroh Pbeta Pbind Pbindef Pbindf PbindProxy Pbinop Pbrown Pbus Pcauchy Pchain Pclump Pclutch Pcollect Pconst Pdef PdefAllGui PdefEditor PdefGui Pdefn PdefnAllGui PdefnGui PdegreeToKey Pdfsm Pdict Pdiff Pdrop PdurStutter Peak PeakEQ2 PeakEQ4 PeakFollower Pen Penv Penvir Perlin3 Pevent Peventmod Pexprand PfadeIn PfadeOut Pfhn Pfin Pfindur PfinQuant Pfinval Pflatten Pfpar Pfset Pfsm Pfunc Pfuncn Pfx Pfxb Pgate Pgauss Pgbman Pgbrown Pgeom Pget Pgpar Pgroup Pgtpar Phaser Phasor Phenon Phprand Phrase Pif Pindex PingPong PinkNoise Pipe Pitch PitchShift Pkey Place Plag Plambda PlaneTree Platform Platoo PlayBuf Plazy PlazyEnvir PlazyEnvirN Plet PlinCong Plorenz Plot Plotter Plprand Pluck PlusFreqScope PlusFreqScopeView PlusFreqScopeWindow Pmeanrand Pmono PmonoArtic PmonoArticStream PmonoStream PMOsc Pmul Pmulp Pmulpre Pn Pnaryop Pnsym Pnsym1 Point PointArray PointSource Polar Poll PopUpMenu PosRatio Post PowerOfTwoAllocator PowerOfTwoBlock Ppar PparGroup Ppatlace Ppatmod Pplayer Ppoisson Pprob Pprotect Pproto Pquad Prand Preject Pretty PrettyEat PrettyEcho PrettyState Prewrite PrimitiveFailedError PrintVal PriorityQueue Process ProgramChangeResponder Prorate Prout ProxyMixer ProxyMixerOld ProxyMonitorGui ProxyNodeMap ProxySpace ProxySynthDef Pseed Pseg Pselect Pseq Pser Pseries Pset Psetp Psetpre Pshuf PSinGrain Pslide Pspawn Pspawner Pstandard Pstep Pstep2add Pstep3add PstepNadd PstepNfunc Pstretch Pstretchp Pstutter Pswitch Pswitch1 Psym Psym1 Psync Ptime Ptpar Ptrace Ptsym Ptuple Pulse PulseCount PulseDivider PulseDPW Punop PureMultiOutUGen PureUGen PVInfo PVSynth PV_Add PV_BinBufRd PV_BinDelay PV_BinFilter PV_BinPlayBuf PV_BinScramble PV_BinShift PV_BinWipe PV_BrickWall PV_BufRd PV_ChainUGen PV_CommonMag PV_CommonMul PV_Compander PV_ConformalMap PV_Conj PV_Copy PV_CopyPhase PV_Cutoff PV_DiffMags PV_Diffuser PV_Div PV_EvenBin PV_ExtractRepeat PV_Freeze PV_FreqBuffer PV_HainsworthFoote PV_Invert PV_JensenAndersen PV_LocalMax PV_MagAbove PV_MagBelow PV_MagBuffer PV_MagClip PV_MagDiv PV_MagExp PV_MagFreeze PV_MagGate PV_MagLog PV_MagMap PV_MagMinus PV_MagMul PV_MagMulAdd PV_MagNoise PV_MagScale PV_MagShift PV_MagSmear PV_MagSmooth PV_MagSquared PV_MagSubtract PV_Max PV_MaxMagN PV_Min PV_MinMagN PV_Morph PV_Mul PV_NoiseSynthF PV_NoiseSynthP PV_OddBin PV_PartialSynthF PV_PartialSynthP PV_PhaseShift PV_PhaseShift270 PV_PhaseShift90 PV_PitchShift PV_PlayBuf PV_RandComb PV_RandWipe PV_RecordBuf PV_RectComb PV_RectComb2 PV_SoftWipe PV_SpectralEnhance PV_SpectralMap PV_Whiten PV_XFade Pwalk Pwhile Pwhite Pwrand Pwrap Pxrand
syn keyword scClass QAbstractScroll QAbstractStepValue QAlignment QButton QCheckBox QColorGroup QColorRole QCurve QDialog QDragBoth QDragSink QDragSource QDragView QEnvelopeView QFileDialog QFont QGridLayout QHLayout QHLayoutView QImage Qitch QItemViewBase QKey QKeyModifiers QKnob QLayout QLevelIndicator QLevelIndicatorStyle QLimits QLineLayout QListView QMetaObject QMultiSliderView QNumberBox QObject QOrientation QPalette QPen QPenPrinter QPopUpMenu QQuartzComposerView QRangeSlider QScope QScope2 QScrollCanvas QScrollTopView QScrollView QSlider QSlider2D QSoundFileView QStackLayout QStaticText QStethoscope QTextField QTextView QTextViewBase QtGUI QTopScrollWidget QTopView QTreeView QTreeViewItem QuadC QuadL QuadN Quant Quark QuarkDetailView QuarkRowView Quarks QuarksGui QuartzComposerView QUserView QView QVLayout QVLayoutView QWebFontFamily QWebView QWindow
syn keyword scClass RadiansPerSample Ramp Rand RandID RandSeed Range RangeSlider RawArray RawPointer RBJHighShelf RBJLowShelf RBJNotch RecNodeProxy RecordBuf Recorder Rect Ref RefCopy Reflections RegaliaMitraEQ ReplaceOut Resonz Rest RHPF RingBuffer RingNumberAllocator Ringz RLPF RLPFD RMAFoodChainL RMEQ RMEQSuite RMS RMShelf RMShelf2 RootNode RosslerL RosslerResL Rotate Rotate2 Routine RunningMax RunningMin RunningSum
syn keyword scClass SampleDur SampleRate Sanitize Saw SawDPW Scale ScaleAD ScaleLP ScaleStream SCContainerView SCDoc SCDocEntry SCDocHTMLRenderer SCDocNode SCDragView SCEnvelopeEdit Scheduler Schmidt ScIDE SCImage SCImageFilter SCImageKernel Scope2 ScopeBuffer ScopeOut ScopeOut2 ScopeView Score ScoreStreamPlayer ScrollCanvas ScrollTopView ScrollView SCScope SCViewHolder Select SelectX SelectXFocus Semaphore SemiColonFileReader SendPeakRMS SendReply SendTrig SensoryDissonance SequenceableCollection SerialPort Server ServerBoot ServerMeter ServerMeterView ServerOptions ServerQuit ServerShmInterface ServerStatusWatcher ServerTree Set SetBuf SetResetFF Shaper SharedIn SharedOut Shift90 ShouldNotImplementError ShutDown Sieve1 Signal Silent SimpleController SimpleNumber SineShaper SineWarp SinGrain SinGrainB SinGrainBBF SinGrainBF SinGrainI SinGrainIBF SinOsc SinOscFB SinTone Size SkipJack SkipNeedle Slew Slider Slider2D SLOnset Slope SlotInspector SmoothDecimator SMS SoftClipAmp SoftClipAmp4 SoftClipAmp8 SoftClipper4 SoftClipper8 SOMAreaWr SOMRd SOMTrain SortBuf SortedList SOS SoundFile SoundFileView SoundIn SparseArray Spawner Speakers Spec SpecCentroid SpecFlatness SpecPcile SpectralEntropy Speech Spkr Splay SplayAz SplayZ Spreader Spring SpruceBudworm Squiz StackLayout StackNumberAllocator Standard2DC Standard2DL Standard2DN StandardL StandardN StandardTrig StartUp StaticText Stepper StereoConvolution2L Stethoscope Stk StkBandedWG StkBeeThree StkBlowHole StkBowed StkBowedI StkClarinet StkFlute StkGlobals StkInst StkMandolin StkModalBar StkMoog StkPluck StkSaxofony StkShakers StkVoicForm Stream StreamClutch StreamControl Streson String StringGui StringInspector SubclassResponsibilityError SubsampleOffset Sum3 Sum4 Summer SVF Sweep SwitchDelay Symbol SymbolArray SyncSaw Synth SynthControl SynthDef SynthDefControl SynthDefOld SynthDesc SynthDescLib SystemClock SystemSynthDefs
syn keyword scClass T2A T2K TabFileReader TabletSlider2D TabletView Tap TapN Tartini Task TaskProxy TaskProxyAllGui TaskProxyGui TBall TBetaRand TBrownRand TChoose Tdef TdefAllGui TdefEditor TdefGui TDelay TDuty TDuty_old TempoBusClock TempoClock TermanWang TestDependant TExpRand TextArchiveMDPlugin TextField TextView TextViewBase TextVU TGaussRand TGrains TGrains2 TGrains3 Thread Thunk Tilt Timer TIRand ToggleFF TopScrollWidget TopView TouchResponder TPV TRand TreeView TreeViewItem Trig Trig1 TrigAvg TrigControl True TTendency Tumble Tuning TWChoose TWindex TwoPole TwoTube TwoWayIdentityDictionary TwoZero
syn keyword scClass UGen UGenThunk UHJ2B UHJtoB UnaryOpFunction UnaryOpFunctionProxy UnaryOpPlug UnaryOpStream UnaryOpUGen UniqueID Unix UnixFILE UnixPlatform Unpack1FFT UnpackFFT URI UserView
syn keyword scClass VarLag VarSaw VBAP VBAPSpeaker VBAPSpeakerArray VBAPSpeakerSet VDiskIn Vibrato View VLayout VLayoutView VMScan2D Vocode VocodeBand Vocoder Volume VolumeGui VOsc VOsc3 VOSIM
syn keyword scClass WalshHadamard WAmp Warp Warp1 WarpOverlap WarpZ Watcher WaveletDaub WaveLoss Wavetable WaveTerrain WeaklyNonlinear WeaklyNonlinear2 WebView WhiteNoise WidthFirstUGen WiiCalibrationInfo WiiMote WiiMoteGUI WiiMoteIRObject WiiNunchukGUI WiiRemoteGUI Window Wrap WrapIndex WrapSummer
syn keyword scClass XFade2 XIn XInFeedback XLine XOut
syn keyword scClass ZeroCrossing ZHPF ZLPF ZPoint ZPolar

" comments
syn keyword scCommentTodo   TODO FIXME XXX TBD contained
syn match   scLineComment   "\/\/.*" contains=@Spell,scCommentTodo
syn region  scComment	      start="/\*"  end="\*/" contains=@Spell,scCommentTodo


" object syntax file is regenerated on startup
runtime! syntax/supercollider_objects.vim

"""""""""""""""""""""""""""""""""""""""""
" linkage

hi def link scClass Constant
hi def link scObject Identifier
hi def link scBinaryoperator Special
hi def link scUnaryoperator Special
hi def link scAoperator Statement
hi def link scArate Statement
hi def link scKrate Statement
hi def link scSymbol Constant
hi def link scString String
hi def link scChar String
hi def link scInteger Number
hi def link scInfinity Number
hi def link scFloat Float
hi def link scGlobVariable Define
hi def link scComment		Comment
hi def link scLineComment		Comment
hi def link scCommentTodo		Todo
hi def link scVar Type
hi def link scArg Type
hi def link scControl Statement
hi def link scKeyword Keyword
hi def link scBoolean Boolean

let b:current_syntax = "supercollider"

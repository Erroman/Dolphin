"Filed out from Dolphin Smalltalk 7"!

ThemeLibrary subclass: #VistaThemeLibrary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
VistaThemeLibrary guid: (GUID fromString: '{a07fa8a2-68a8-4f59-9459-e71f9bece9ac}')!
VistaThemeLibrary comment: ''!
!VistaThemeLibrary categoriesForClass!Win32-Modules! !
!VistaThemeLibrary methodsFor!

beginBufferedAnimation: hwnd hdcTarget: hdcTarget prcTarget: prcTarget dwFormat: dwFormat pPaintParams: pPaintParams pAnimationParams: pAnimationParams phdcFrom: phdcFrom phdcTo: phdcTo
	"Invoke the BeginBufferedAnimation() function of the module wrapped by the receiver.

		HANDLE __stdcall BeginBufferedAnimation(
			[in]HWND HWND,
			[in]HDC hdcTarget,
			[in]RECT* prcTarget,
			[in]BP_BUFFERFORMAT dwFormat,
			[in]BP_PAINTPARAMS* pPaintParams,
			[in]BP_ANIMATIONPARAMS* pAnimationParams,
			[out]HDC* phdcFrom,
			[out]HDC* phdcTo);"

	<stdcall: handle BeginBufferedAnimation handle handle RECT* sdword BP_PAINTPARAMS* BP_ANIMATIONPARAMS* handle* handle*>
	^self invalidCall!

beginBufferedPaint: hdcTarget prcTarget: prcTarget dwFormat: dwFormat pPaintParams: pPaintParams phDC: phDC
	"Invoke the BeginBufferedPaint() function of the module wrapped by the receiver.
	Helpstring: Begins a buffered paint operation.

		HANDLE __stdcall BeginBufferedPaint(
			[in]HDC hdcTarget,
			[in]RECT* prcTarget,
			[in]BP_BUFFERFORMAT dwFormat,
			[in]BP_PAINTPARAMS* pPaintParams,
			[out]HDC* phDC);"

	<stdcall: handle BeginBufferedPaint handle RECT* sdword BP_PAINTPARAMS* handle*>
	^self invalidCall!

bufferedPaintClear: hBufferedPaint prc: prc
	"Invoke the BufferedPaintClear() function of the module wrapped by the receiver.
	Helpstring: Returns the target rectangle specified during BeginBufferedPaint.

		HRESULT __stdcall BufferedPaintClear(
			[in]HANDLE hBufferedPaint,
			[in, optional]RECT* prc);"

	<stdcall: hresult BufferedPaintClear handle RECT*>
	^self invalidCall!

bufferedPaintInit
	"Invoke the BufferedPaintInit() function of the module wrapped by the receiver.
	Helpstring: Initialize the Buffered Paint API.

		HRESULT __stdcall BufferedPaintInit();"

	<stdcall: hresult BufferedPaintInit>
	^self invalidCall!

bufferedPaintRenderAnimation: hwnd hdcTarget: hdcTarget
	"Invoke the BufferedPaintRenderAnimation() function of the module wrapped by the receiver.

		BOOL __stdcall BufferedPaintRenderAnimation(
			[in]HWND HWND,
			[in]HDC hdcTarget);"

	<stdcall: bool BufferedPaintRenderAnimation handle handle>
	^self invalidCall!

bufferedPaintSetAlpha: hBufferedPaint prc: prc alpha: alpha
	"Invoke the BufferedPaintSetAlpha() function of the module wrapped by the receiver.
	Helpstring: Returns the target rectangle specified during BeginBufferedPaint.

		HRESULT __stdcall BufferedPaintSetAlpha(
			[in]HANDLE hBufferedPaint,
			[in]RECT* prc,
			[in]BYTE Alpha);"

	<stdcall: hresult BufferedPaintSetAlpha handle RECT* byte>
	^self invalidCall!

bufferedPaintStopAllAnimations: hwnd
	"Invoke the BufferedPaintStopAllAnimations() function of the module wrapped by the receiver.

		HRESULT __stdcall BufferedPaintStopAllAnimations(
			[in]HWND HWND);"

	<stdcall: hresult BufferedPaintStopAllAnimations handle>
	^self invalidCall!

bufferedPaintUnInit
	"Invoke the BufferedPaintUnInit() function of the module wrapped by the receiver.
	Helpstring: Uninitialize the Buffered Paint API.

		HRESULT __stdcall BufferedPaintUnInit();"

	"Ignore any errors from calling this function, as we call it on shutdown."

	<stdcall: sdword BufferedPaintUnInit>
	^self invalidCall!

endBufferedPaint: hBufferedPaint fUpdateTarget: fUpdateTarget
	"Invoke the EndBufferedPaint() function of the module wrapped by the receiver.
	Helpstring: Ends a buffered paint operation.

		HRESULT __stdcall EndBufferedPaint(
			[in]HANDLE hBufferedPaint,
			[in]BOOL fUpdateTarget);"

	<stdcall: hresult EndBufferedPaint handle bool>
	^self invalidCall!

getBufferedPaintBits: hBufferedPaint ppbBuffer: ppbBuffer pcxRow: pcxRow
	"Invoke the GetBufferedPaintBits() function of the module wrapped by the receiver.
	Helpstring: Returns the target rectangle specified during BeginBufferedPaint.

		HRESULT __stdcall GetBufferedPaintBits(
			[in]HANDLE hBufferedPaint,
			[out]RGBQUAD** ppbBuffer,
			[out]int* pcxRow);"

	<stdcall: hresult GetBufferedPaintBits handle RGBQUAD** sdword*>
	^self invalidCall!

getBufferedPaintDC: hBufferedPaint
	"Invoke the GetBufferedPaintDC() function of the module wrapped by the receiver.
	Helpstring: Returns the target rectangle specified during BeginBufferedPaint.

		HDC __stdcall GetBufferedPaintDC(
			[in]HANDLE hBufferedPaint);"

	<stdcall: handle GetBufferedPaintDC handle>
	^self invalidCall!

getBufferedPaintTargetDC: hBufferedPaint
	"Invoke the GetBufferedPaintTargetDC() function of the module wrapped by the receiver.
	Helpstring: Returns the target rectangle specified during BeginBufferedPaint.

		HDC __stdcall GetBufferedPaintTargetDC(
			[in]HANDLE hBufferedPaint);"

	<stdcall: handle GetBufferedPaintTargetDC handle>
	^self invalidCall!

getBufferedPaintTargetRect: hBufferedPaint prc: prc
	"Invoke the GetBufferedPaintTargetRect() function of the module wrapped by the receiver.
	Helpstring: Returns the target rectangle specified during BeginBufferedPaint.

		HRESULT __stdcall GetBufferedPaintTargetRect(
			[in]HANDLE hBufferedPaint,
			[out, retval]RECT* prc);"

	<stdcall: hresult GetBufferedPaintTargetRect handle RECT*>
	^self invalidCall!

isCompositionActive
	"Invoke the IsCompositionActive() function of the module wrapped by the receiver.
	Helpstring: Tells if the DWM is running, and composition effects are possible for this process (themes are active).

		BOOL __stdcall IsCompositionActive();"

	<stdcall: bool IsCompositionActive>
	^self invalidCall!

onExit
	"Private - Perform any uninitialization required at system shutdown time"

	self bufferedPaintUnInit!

onStartup
	"Private - Perform any initialization required at system startup time"

	self bufferedPaintInit! !
!VistaThemeLibrary categoriesFor: #beginBufferedAnimation:hdcTarget:prcTarget:dwFormat:pPaintParams:pAnimationParams:phdcFrom:phdcTo:!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #beginBufferedPaint:prcTarget:dwFormat:pPaintParams:phDC:!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #bufferedPaintClear:prc:!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #bufferedPaintInit!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #bufferedPaintRenderAnimation:hdcTarget:!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #bufferedPaintSetAlpha:prc:alpha:!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #bufferedPaintStopAllAnimations:!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #bufferedPaintUnInit!public! !
!VistaThemeLibrary categoriesFor: #endBufferedPaint:fUpdateTarget:!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #getBufferedPaintBits:ppbBuffer:pcxRow:!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #getBufferedPaintDC:!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #getBufferedPaintTargetDC:!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #getBufferedPaintTargetRect:prc:!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #isCompositionActive!**auto generated**!public! !
!VistaThemeLibrary categoriesFor: #onExit!private! !
!VistaThemeLibrary categoriesFor: #onStartup!private! !


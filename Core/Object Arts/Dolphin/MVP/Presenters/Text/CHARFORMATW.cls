"Filed out from Dolphin Smalltalk 7"!

Win32Structure subclass: #CHARFORMATW
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'CommonDialogConstants RichEditConstants'
	classInstanceVariableNames: ''!
CHARFORMATW guid: (GUID fromString: '{87b4c5cf-026e-11d3-9fd7-00a0cc3e4a32}')!
CHARFORMATW comment: 'CHARFORMAT is an <ExternalStructure> class to represent the Win32 structure of the same name.

The CHARFORMAT structure contains information about character formatting in a rich edit control.'!
!CHARFORMATW categoriesForClass!External-Data-Structured-Win32! !
!CHARFORMATW methodsFor!

bCharSet
	"Answer the <Integer> value of the receiver's 'bCharSet' field."

	^bytes byteAtOffset: ##(self offsetOf: #bCharSet)!

bCharSet: anInteger
	"Set the receiver's 'bCharSet' field to the value of the argument, anInteger"

	bytes byteAtOffset: ##(self offsetOf: #bCharSet) put: anInteger!

beBold
	"Set the character bold effect on."

	self isBold: true!

beItalic
	"Set the character italic effect on."

	self isItalic: true!

beNotBold
	"Set the character bold effect off."

	self isBold: false!

beNotItalic
	"Set the character italic effect off."

	self isItalic: false!

beNotUnderlined
	"Set the character underline effect off."

	self isUnderlined: false!

bePlain
	"Remove all text effects (such as bold, italic, etc)"

	self maskIn: ##(CFM_BOLD|CFM_ITALIC|CFM_UNDERLINE|CFM_STRIKEOUT).
	self dwEffects: 0!

beUnderlined
	"Set the character underline effect on."

	self isUnderlined: true!

bPitchAndFamily
	"Answer the <Integer> value of the receiver's 'bPitchAndFamily' field."

	^bytes byteAtOffset: ##(self offsetOf: #bPitchAndFamily)!

bPitchAndFamily: anInteger
	"Set the receiver's 'bPitchAndFamily' field to the value of the argument, anInteger"

	bytes byteAtOffset: ##(self offsetOf: #bPitchAndFamily) put: anInteger!

characterSet
	^(self maskAny: CFM_CHARSET) ifTrue: [self bCharSet]!

characterSet: anIntegerOrNil 
	"Set the desired character set (permitted values of lfCharSet member of LOGFONT on MSDN)."

	self maskIn: CFM_CHARSET.
	self bCharSet: anIntegerOrNil!

color
	"Answer the character colour."

	^Color fromInteger: self crTextColor!

color: aColor 
	"Set the character colour."

	self maskIn: CFM_COLOR.
	self crTextColor: (aColor ifNil: [Color windowText]) asColorRef asParameter!

crTextColor
	"Answer the <Integer> value of the receiver's 'crTextColor' field."

	^bytes dwordAtOffset: ##(self offsetOf: #crTextColor)!

crTextColor: anInteger
	"Set the receiver's 'crTextColor' field to the value of the argument, anInteger"

	bytes dwordAtOffset: ##(self offsetOf: #crTextColor) put: anInteger!

dwEffects
	"Answer the <Integer> value of the receiver's 'dwEffects' field."

	^bytes dwordAtOffset: ##(self offsetOf: #dwEffects)!

dwEffects: anInteger
	"Set the receiver's 'dwEffects' field to the value of the argument, anInteger"

	bytes dwordAtOffset: ##(self offsetOf: #dwEffects) put: anInteger!

dwMask
	"Answer the <Integer> value of the receiver's 'dwMask' field."

	^bytes dwordAtOffset: ##(self offsetOf: #dwMask)!

dwMask: anInteger
	"Set the receiver's 'dwMask' field to the value of the argument, anInteger"

	bytes dwordAtOffset: ##(self offsetOf: #dwMask) put: anInteger!

dwSize: anInteger
	"Set the receiver's 'dwSize' field to the value of the argument, anInteger"

	bytes dwordAtOffset: 0 put: anInteger!

effectsAny: anInteger
	"Private - Answer true if the effects member contains the bit flags represented by anInteger."

	^self dwEffects anyMask: anInteger!

faceName: aString
	"Set the character face name.
	Note that the szFaceName member is an embedded string, rather than a pointer,
	and there is, therefore, no need to save down a reference to aString."

	self maskIn: CFM_FACE.
	self szFaceName: aString asUtf16String!

font
	^Font fromLogFont: self logFont!

font: aFont 
	"Set the character font."

	| lf |
	lf := aFont logFont.
	self
		faceName: aFont name;
		pointSize: aFont pointSize;
		characterSet: lf lfCharSet;
		bPitchAndFamily: lf lfPitchAndFamily;
		isBold: aFont isBold;
		isItalic: aFont isItalic;
		isUnderlined: aFont isUnderlined;
		isStruckThrough: aFont isStruckThrough!

height: aNumber
	"Set the receiver's height field to anInteger (N.B.
	the height is specified in half points)."

	self maskIn: CFM_SIZE.
	self yHeight: aNumber asInteger!

isBold
	"Answer the character bold effect."

	^(self maskAny: CFM_BOLD) and: [self effectsAny: CFE_BOLD].
!

isBold: aBoolean
	"Set the character bold effect."

	self setEffect: CFE_BOLD mask: CFM_BOLD set: aBoolean!

isItalic
	"Answer the character italic effect."

	^(self maskAny: CFM_ITALIC) and: [self effectsAny: CFE_ITALIC].
!

isItalic: aBoolean
	"Set the character italic effect."

	self setEffect: CFE_ITALIC mask: CFM_ITALIC set: aBoolean!

isStruckThrough
	"Answer whether the strike-out effect is set."

	^(self maskAny: CFM_STRIKEOUT) and: [self effectsAny: CFE_STRIKEOUT].
!

isStruckThrough: aBoolean
	"Set the struck out character effect."

	self setEffect: CFE_STRIKEOUT mask: CFM_STRIKEOUT set: aBoolean
!

isUnderlined
	"Answer the character underline effect."

	^(self maskAny: CFM_UNDERLINE) and: [self effectsAny: CFE_UNDERLINE].
!

isUnderlined: aBoolean
	"Set the character underline effect."

	self setEffect: CFE_UNDERLINE mask: CFM_UNDERLINE set: aBoolean!

logFont
	"Answer a <LOGFONTW> configured with the font settings from the receiver. The display resolution is assumed in converting from the point size to font height."

	| answer |
	answer := LOGFONTW new.
	answer faceName: self szFaceName.
	answer lfHeight: (self pointSize * Canvas desktopResolution y / 72) rounded negated.
	answer lfWeight: (self isBold ifTrue: [FW_BOLD] ifFalse: [FW_NORMAL]).
	answer lfItalic: self isItalic asParameter.
	answer lfUnderline: self isUnderlined asParameter.
	answer lfStrikeOut: self isStruckThrough asParameter.
	self characterSet ifNotNil: [:script | answer lfCharSet: script].
	^answer!

maskAny: anInteger
	"Private - Answer true if the mask member contains the bit flags represented by anInteger."

	^self dwMask anyMask: anInteger!

maskIn: anInteger
	"Private - OR in to contents mask member the bit flags represented by anInteger.
	Answer the receiver."

	self dwMask: (self dwMask bitOr: anInteger)!

maskOut: anInteger 
	self dwMask: (self dwMask maskClear: anInteger)!

pointSize
	"Answer the receiver's height field in points (N.B. the answer may be
	a Fraction if the, for example, the size if 10.5 points)."

	^self yHeight / 20!

pointSize: aNumber
	"Set the receiver's height field to  aNumber points (aNumber 
	need not be integral)."

	self height: aNumber * 20!

populateChooseFont: aCHOOSEFONT 
	"Private - Set up the CHOOSEFONT argument appropriately for the <FontDialog> to modify the
	character format settings in the receiver. The receiver's mask tells us which settings are
	consistent across the entire selection range, so we set up the dialog so that this is clear
	to the user (e.g. there will be no selections for values which are not common)."

	| flags mask |
	flags := aCHOOSEFONT flags.
	aCHOOSEFONT logFont: self logFont.
	mask := self dwMask.
	(mask allMask: CFM_FACE) ifFalse: [flags := flags bitOr: CF_NOFACESEL].
	"Only enables effects portion of the dialog if colour and other effects are consistent"
	(mask allMask: ##(CFM_STRIKEOUT | CFM_UNDERLINE | CFM_COLOR)) 
		ifTrue: [flags := flags bitOr: CF_EFFECTS].
	(mask allMask: ##(CFM_BOLD | CFM_ITALIC | CFM_UNDERLINE)) 
		ifFalse: [flags := flags bitOr: CF_NOSTYLESEL].
	(mask allMask: CFM_SIZE) ifFalse: [flags := flags bitOr: CF_NOSIZESEL].
	(mask allMask: CFM_CHARSET) ifFalse: [flags := flags bitOr: CF_NOSCRIPTSEL].
	aCHOOSEFONT flags: flags.
	aCHOOSEFONT color: self color!

populateFromChooseFont: aCHOOSEFONT 
	| lf flags |
	flags := aCHOOSEFONT flags.
	lf := aCHOOSEFONT lpLogFont.
	"Did the user select a font face?"
	(flags allMask: CF_NOFACESEL) ifFalse: [self faceName: lf faceName].
	"Did the user select a script/charset?"
	(flags allMask: CF_NOSCRIPTSEL) ifFalse: [self characterSet: lf lfCharSet].
	"Did the user select a point size?"
	(flags allMask: CF_NOSIZESEL) ifFalse: [self pointSize: aCHOOSEFONT iPointSize / 10].
	"Did the user make a style selection?"
	(flags allMask: CF_NOSTYLESEL) 
		ifFalse: 
			[self
				isBold: lf lfWeight >= FW_BOLD;
				isItalic: lf lfItalic asBoolean].
	(flags allMask: CF_EFFECTS) ifFalse: [^self].
	self isUnderlined: lf lfUnderline asBoolean.
			self isStruckThrough: lf lfStrikeOut asBoolean.
	self color: aCHOOSEFONT color!

setEffect: effectFlag mask: effectMask set: aBoolean
	"Private - Set/reset an effect such as underlined, bold, etc."

	self maskIn: effectMask.
	self dwEffects: (self dwEffects mask: effectFlag set: aBoolean)
!

size: twips
	"Set the character size."

	self maskIn: CFM_SIZE.
	self yHeight: twips
!

szFaceName
	"Answer the <Utf16String> value of the receiver's 'szFaceName' field."

	^Utf16String fromAddress: bytes yourAddress + ##(self offsetOf: #szFaceName)!

szFaceName: anUtf16String
	"Set the receiver's 'szFaceName' field to the value of the argument, anUtf16String"

	| size |
	size := anUtf16String byteSize - 2 min: ##(31 * 2).
	anUtf16String
		replaceBytesOf: bytes
		from: ##((self offsetOf: #szFaceName) + 1)
		to: ##(self offsetOf: #szFaceName) + size
		startingAt: 1.
	bytes wordAtOffset: ##(self offsetOf: #szFaceName) + size put: 0!

yHeight
	"Answer the <Integer> value of the receiver's 'yHeight' field."

	^bytes sdwordAtOffset: ##(self offsetOf: #yHeight)!

yHeight: anInteger
	"Set the receiver's 'yHeight' field to the value of the argument, anInteger"

	bytes sdwordAtOffset: ##(self offsetOf: #yHeight) put: anInteger! !
!CHARFORMATW categoriesFor: #bCharSet!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #bCharSet:!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #beBold!accessing!public! !
!CHARFORMATW categoriesFor: #beItalic!accessing!public! !
!CHARFORMATW categoriesFor: #beNotBold!accessing!public! !
!CHARFORMATW categoriesFor: #beNotItalic!accessing!public! !
!CHARFORMATW categoriesFor: #beNotUnderlined!accessing!public! !
!CHARFORMATW categoriesFor: #bePlain!modes!public! !
!CHARFORMATW categoriesFor: #beUnderlined!accessing!public! !
!CHARFORMATW categoriesFor: #bPitchAndFamily!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #bPitchAndFamily:!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #characterSet!public! !
!CHARFORMATW categoriesFor: #characterSet:!accessing!public! !
!CHARFORMATW categoriesFor: #color!accessing!public! !
!CHARFORMATW categoriesFor: #color:!accessing!public! !
!CHARFORMATW categoriesFor: #crTextColor!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #crTextColor:!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #dwEffects!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #dwEffects:!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #dwMask!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #dwMask:!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #dwSize:!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #effectsAny:!accessing!private! !
!CHARFORMATW categoriesFor: #faceName:!accessing!public! !
!CHARFORMATW categoriesFor: #font!accessing!public! !
!CHARFORMATW categoriesFor: #font:!accessing!public! !
!CHARFORMATW categoriesFor: #height:!accessing!public! !
!CHARFORMATW categoriesFor: #isBold!public!testing! !
!CHARFORMATW categoriesFor: #isBold:!accessing!public! !
!CHARFORMATW categoriesFor: #isItalic!accessing!public! !
!CHARFORMATW categoriesFor: #isItalic:!accessing!public! !
!CHARFORMATW categoriesFor: #isStruckThrough!public!testing! !
!CHARFORMATW categoriesFor: #isStruckThrough:!accessing!public! !
!CHARFORMATW categoriesFor: #isUnderlined!accessing!public! !
!CHARFORMATW categoriesFor: #isUnderlined:!accessing!public! !
!CHARFORMATW categoriesFor: #logFont!public! !
!CHARFORMATW categoriesFor: #maskAny:!accessing!private! !
!CHARFORMATW categoriesFor: #maskIn:!accessing!private! !
!CHARFORMATW categoriesFor: #maskOut:!private! !
!CHARFORMATW categoriesFor: #pointSize!accessing!public! !
!CHARFORMATW categoriesFor: #pointSize:!accessing!public! !
!CHARFORMATW categoriesFor: #populateChooseFont:!private! !
!CHARFORMATW categoriesFor: #populateFromChooseFont:!private! !
!CHARFORMATW categoriesFor: #setEffect:mask:set:!accessing!private! !
!CHARFORMATW categoriesFor: #size:!accessing!public! !
!CHARFORMATW categoriesFor: #szFaceName!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #szFaceName:!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #yHeight!**compiled accessors**!public! !
!CHARFORMATW categoriesFor: #yHeight:!**compiled accessors**!public! !

!CHARFORMATW class methodsFor!

defineFields
	"Define the layout of the CHARFORMAT structure
		CHARFORMAT compileDefinition
	"

	self defineField: #dwSize type: DWORDField writeOnly beOverride;
		defineField: #dwMask type: DWORDField new;
		defineField: #dwEffects type: DWORDField new;
		defineField: #yHeight type: SDWORDField new;
		defineField: #yOffset type: SDWORDField new beUncompiled;
		defineField: #crTextColor type: DWORDField new;
		defineField: #bCharSet type: BYTEField new;
		defineField: #bPitchAndFamily type: BYTEField new;
		defineField: #szFaceName type: (StringField type: Utf16String length: 32)!

fromChooseFont: aCHOOSEFRONT 
	^(self new)
		populateFromChooseFont: aCHOOSEFRONT;
		yourself! !
!CHARFORMATW class categoriesFor: #defineFields!initializing!public! !
!CHARFORMATW class categoriesFor: #fromChooseFont:!public! !

"Filed out from Dolphin Smalltalk 7"!

CCITEM subclass: #LVITEMW
	instanceVariableNames: ''
	classVariableNames: 'CallbackPrototype'
	poolDictionaries: 'ListViewConstants'
	classInstanceVariableNames: ''!
LVITEMW guid: (GUID fromString: '{87b4c620-026e-11d3-9fd7-00a0cc3e4a32}')!
LVITEMW comment: 'LVITEMW is an <ExternalStructure> class which represents the Windows common control structure of the same name.

LVITEMW is used to communicate information about the items (rows) in a List View control such as the text, icon, state, etc.

typedef [uuid(87b4c620-026e-11d3-9fd7-00a0cc3e4a32)]
struct tagLVITEMW {
	unsigned int mask;
	int iItem;
	int iSubItem;
	unsigned int State;
	unsigned int stateMask;
	[string] LPWSTR pszText;
	int cchTextMax;
	int iImage;
	LONG_PTR lParam;
	int iIndent;
	int iGroupId;
	unsigned int cColumns;
	[size_is(''cColumns'')] unsigned int* puColumns;
	[size_is(''cColumns'')] int* piColFmt;
	[readonly] int iGroup;
} LVITEMW;
'!
!LVITEMW categoriesForClass!Win32-Structs! !
!LVITEMW methodsFor!

allCallbacks
	bytes
		sdwordAtOffset: ##(self offsetOf: #iImage) put: I_IMAGECALLBACK;
		dwordAtOffset: ##(self offsetOf: #pszText) put: LPSTR_TEXTCALLBACK.
	self maskIn: ##(LVIF_TEXT | LVIF_IMAGE)!

cchTextMax
	"Answer the <Integer> value of the receiver's 'cchTextMax' field."

	^bytes sdwordAtOffset: ##(self offsetOf: #cchTextMax)!

cchTextMax: anInteger
	"Set the receiver's 'cchTextMax' field to the value of the argument, anInteger"

	bytes sdwordAtOffset: ##(self offsetOf: #cchTextMax) put: anInteger!

cchTextMaxOffset
	^##(self offsetOf: #cchTextMax)!

cColumns
	"Answer the <Integer> value of the receiver's 'cColumns' field."

	^bytes dwordAtOffset: ##(self offsetOf: #cColumns)!

cColumns: anInteger
	"Set the receiver's 'cColumns' field to the value of the argument, anInteger"

	bytes dwordAtOffset: ##(self offsetOf: #cColumns) put: anInteger!

column: colInteger 
	self iSubItem: colInteger - 1!

dwState
	"Answer the <Integer> value of the receiver's 'dwState' field."

	^bytes dwordAtOffset: ##(self offsetOf: #dwState)!

dwState: anInteger
	"Set the receiver's 'dwState' field to the value of the argument, anInteger"

	bytes dwordAtOffset: ##(self offsetOf: #dwState) put: anInteger!

handle
	"Answer the 'handle' of the item described by the receiver."

	^self iItem + 1!

iGroup
	"Answer the <Integer> value of the receiver's 'iGroup' field."

	^bytes sdwordAtOffset: ##(self offsetOf: #iGroup)!

iGroupId
	"Answer the <Integer> value of the receiver's 'iGroupId' field."

	^bytes sdwordAtOffset: ##(self offsetOf: #iGroupId)!

iGroupId: anInteger
	"Set the receiver's 'iGroupId' field to the value of the argument, anInteger"

	bytes sdwordAtOffset: ##(self offsetOf: #iGroupId) put: anInteger!

iImage
	"Answer the <Integer> value of the receiver's 'iImage' field."

	^bytes sdwordAtOffset: ##(self offsetOf: #iImage)!

iImage: anInteger
	"Set the receiver's 'iImage' field to the value of the argument, anInteger"

	bytes sdwordAtOffset: ##(self offsetOf: #iImage) put: anInteger!

iIndent
	"Answer the <Integer> value of the receiver's 'iIndent' field."

	^bytes sdwordAtOffset: ##(self offsetOf: #iIndent)!

iIndent: anInteger
	"Set the receiver's 'iIndent' field to the value of the argument, anInteger"

	bytes sdwordAtOffset: ##(self offsetOf: #iIndent) put: anInteger!

iItem
	"Answer the <Integer> value of the receiver's 'iItem' field."

	^bytes sdwordAtOffset: ##(self offsetOf: #iItem)!

iItem: anInteger
	"Set the receiver's 'iItem' field to the value of the argument, anInteger"

	bytes sdwordAtOffset: ##(self offsetOf: #iItem) put: anInteger!

indent: widths
	"Set the number of image widths to indent the item text."

	self iIndent: widths.
	self maskIn: LVIF_INDENT!

iSubItem
	"Answer the <Integer> value of the receiver's 'iSubItem' field."

	^bytes sdwordAtOffset: ##(self offsetOf: #iSubItem)!

iSubItem: anInteger
	"Set the receiver's 'iSubItem' field to the value of the argument, anInteger"

	bytes sdwordAtOffset: ##(self offsetOf: #iSubItem) put: anInteger!

lParam
	"Answer the <Integer> value of the receiver's 'lParam' field."

	^bytes intPtrAtOffset: ##(self offsetOf: #lParam)!

lParam: anInteger
	"Set the receiver's 'lParam' field to the value of the argument, anInteger"

	bytes intPtrAtOffset: ##(self offsetOf: #lParam) put: anInteger!

piColFmt
	"Answer the <SDWORDArray> value of the receiver's 'piColFmt' field."

	^SDWORDArray fromAddress: (bytes intPtrAtOffset: ##(self offsetOf: #piColFmt)) length: self cColumns!

piColFmt: aSDWORDArray
	"Set the receiver's 'piColFmt' field to the value of the argument, aSDWORDArray"

	bytes uintPtrAtOffset: ##(self offsetOf: #piColFmt) put: aSDWORDArray yourAddress.
	self cColumns: aSDWORDArray size!

pszText
	"Answer the <Utf16String> value of the receiver's 'pszText' field."

	^Utf16String fromAddress: (bytes intPtrAtOffset: ##(self offsetOf: #pszText))!

pszText: anUtf16String
	"Set the receiver's 'pszText' field to the value of the argument, anUtf16String"

	bytes uintPtrAtOffset: ##(self offsetOf: #pszText) put: anUtf16String yourAddress!

puColumns
	"Answer the <DWORDArray> value of the receiver's 'puColumns' field."

	^DWORDArray fromAddress: (bytes intPtrAtOffset: ##(self offsetOf: #puColumns)) length: self cColumns!

puColumns: aDWORDArray
	"Set the receiver's 'puColumns' field to the value of the argument, aDWORDArray"

	bytes uintPtrAtOffset: ##(self offsetOf: #puColumns) put: aDWORDArray yourAddress.
	self cColumns: aDWORDArray size!

row: rowInteger text: aString imageIndex: imageInteger indent: indentInteger 
	| mask iImage |
	self
		iItem: rowInteger - 1;
		pszText: (text := self textClass fromString: aString).
	mask := LVIF_TEXT.
	imageInteger notNil ifTrue: [iImage := imageInteger - 1].
	indentInteger notNil 
		ifTrue: 
			[self iIndent: indentInteger.
			mask := mask bitOr: LVIF_INDENT.
			indentInteger < 0 ifTrue: [iImage := -1]].
	iImage notNil 
		ifTrue: 
			[self iImage: iImage.
			mask := mask bitOr: LVIF_IMAGE].
	self mask: mask!

stateImageIndex
	"Answer contents' state image index."

	self dwState bitShift: -12.!

stateImageIndex: anInteger
	"Set contents' state image index to anInteger."

	self
		dwState: ((anInteger bitShift: 12) bitOr: self dwState);
		maskIn: self stateValidMask;
		stateMask: (LVIS_STATEIMAGEMASK bitOr: self stateMask).!

stateMask
	"Answer the <Integer> value of the receiver's 'stateMask' field."

	^bytes dwordAtOffset: ##(self offsetOf: #stateMask)!

stateMask: anInteger
	"Set the receiver's 'stateMask' field to the value of the argument, anInteger"

	bytes dwordAtOffset: ##(self offsetOf: #stateMask) put: anInteger!

textPointerOffset
	"Private - Answer the offset of the text pointer in the receiver. "

	^##(self offsetOf: #pszText)! !
!LVITEMW categoriesFor: #allCallbacks!accessing!public! !
!LVITEMW categoriesFor: #cchTextMax!**compiled accessors**!public! !
!LVITEMW categoriesFor: #cchTextMax:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #cchTextMaxOffset!constants!private! !
!LVITEMW categoriesFor: #cColumns!**compiled accessors**!public! !
!LVITEMW categoriesFor: #cColumns:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #column:!accessing!public! !
!LVITEMW categoriesFor: #dwState!**compiled accessors**!public! !
!LVITEMW categoriesFor: #dwState:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #handle!accessing!public! !
!LVITEMW categoriesFor: #iGroup!**compiled accessors**!public! !
!LVITEMW categoriesFor: #iGroupId!**compiled accessors**!public! !
!LVITEMW categoriesFor: #iGroupId:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #iImage!**compiled accessors**!public! !
!LVITEMW categoriesFor: #iImage:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #iIndent!**compiled accessors**!public! !
!LVITEMW categoriesFor: #iIndent:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #iItem!**compiled accessors**!public! !
!LVITEMW categoriesFor: #iItem:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #indent:!accessing!public! !
!LVITEMW categoriesFor: #iSubItem!**compiled accessors**!public! !
!LVITEMW categoriesFor: #iSubItem:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #lParam!**compiled accessors**!public! !
!LVITEMW categoriesFor: #lParam:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #piColFmt!**compiled accessors**!public! !
!LVITEMW categoriesFor: #piColFmt:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #pszText!**compiled accessors**!public! !
!LVITEMW categoriesFor: #pszText:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #puColumns!**compiled accessors**!public! !
!LVITEMW categoriesFor: #puColumns:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #row:text:imageIndex:indent:!accessing!private! !
!LVITEMW categoriesFor: #stateImageIndex!accessing!public! !
!LVITEMW categoriesFor: #stateImageIndex:!accessing!public! !
!LVITEMW categoriesFor: #stateMask!**compiled accessors**!public! !
!LVITEMW categoriesFor: #stateMask:!**compiled accessors**!public! !
!LVITEMW categoriesFor: #textPointerOffset!constants!private! !

!LVITEMW class methodsFor!

allCallbacks
	^self fromBytes: CallbackPrototype!

defineFields
	"Define the fields of the LVITEMW structure.

	self compileDefinition

		typedef [uuid(87b4c620-026e-11d3-9fd7-00a0cc3e4a32)]
		struct tagLVITEMW {
			unsigned int mask;
			int iItem;
			int iSubItem;
			unsigned int State;
			unsigned int stateMask;
			[string] LPWSTR pszText;
			int cchTextMax;
			int iImage;
			LONG_PTR lParam;
			int iIndent;
			int iGroupId;
			unsigned int cColumns;
			[size_is('cColumns')] unsigned int* puColumns;
			[size_is('cColumns')] int* piColFmt;
			[readonly] int iGroup;
		} LVITEMW;
	"

	super defineFields.
	self
		defineField: #iItem type: SDWORDField new offset: 4;
		defineField: #iSubItem type: SDWORDField new offset: 8;
		defineField: #dwState type: DWORDField new offset: 12;
		defineField: #stateMask type: DWORDField new offset: 16;
		defineField: #pszText type: (PointerField type: Utf16String) offset: 20;
		defineField: #cchTextMax type: SDWORDField new offset: 24;
		defineField: #iImage type: SDWORDField new offset: 28; 
		defineField: #lParam type: INT_PTRField new offset: 32;
		defineField: #iIndent type: SDWORDField new offset: 36;
		defineField: #iGroupId type: SDWORDField new offset: 40;
		defineField: #cColumns type: DWORDField new offset: 44;
		defineField: #puColumns type: (ArrayPointerField type: DWORDArray lengthField: #cColumns) offset: 48;
		defineField: #piColFmt type: (ArrayPointerField type: SDWORDArray lengthField: #cColumns) offset: 52;
		defineField: #iGroup type: SDWORDField new beReadOnly offset: 56.
	self byteSize: 60!

initialize
	CallbackPrototype := self new allCallbacks; bytes! !
!LVITEMW class categoriesFor: #allCallbacks!public! !
!LVITEMW class categoriesFor: #defineFields!initializing!public! !
!LVITEMW class categoriesFor: #initialize!development!public! !


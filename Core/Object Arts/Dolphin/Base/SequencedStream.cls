"Filed out from Dolphin Smalltalk 7"!

Stream subclass: #SequencedStream
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SequencedStream guid: (GUID fromString: '{9b6a5665-c80e-457c-b384-f716399f271d}')!
SequencedStream isAbstract: true!
SequencedStream comment: 'SequencedStream is an class of <Stream>s that stream over a finite number of past and future sequence values, maintaining a current position among those sequence values and allowing that position to be altered. Sub-instances of <SequencedStream> conform to the ANSI <sequencedStream> protocol.'!
!SequencedStream categoriesForClass!Collections-Streams! !
!SequencedStream methodsFor!

contents
	"Answer a <sequencedReadableCollection> that contains the receiver's past and future
	sequence values, in order, i.e. the complete contents of the stream."

	^self subclassResponsibility
!

copyFrom: startInteger to: stopInteger 
	"Answer a new <sequencedReadableCollection> like that streamed over by the receiver
	containing those elements of the receiver between the specified one-based <integer> indices,
	inclusive, and in the same order. The stream position is left unchanged."

	| answer mark |
	mark := self position.
	self position: startInteger - 1.
	answer := self next: stopInteger - startInteger + 1.
	self position: mark.
	^answer!

flush
	"No-op to allow non-FileStreams to be used interchangeably with FileStream."

	^self!

isEmpty
	"Answer whether the sets of both past and future sequence values are empty."

	^self size == 0!

nextLine
	"Answer a Collection consisting of the receiver contents up to (but not including) the next
	line delimiter. If there are no further line delimiters in the receiver, then the rest of
	the receiver's contents are answered. If the receiver is at its end, then an empty
	collection is answered. "

	"N.B. This method works for CR, LF and CR/LF line delimiters."

	| newStream nextObject |
	newStream := self contentsSpecies writeStream: 128.
	
	[(nextObject := self nextOrNil) isNil
		or: [nextObject == $\n or: [nextObject == $\r and: 
							[self peekFor: $\n.
							true]]]]
			whileFalse: [newStream nextPut: nextObject].
	^newStream contents!

nextWord
	"Answer the next 'word' in the receiver's element stream, where a word is defined as a
	sequence of one or more elements delimited by an elements which answer true to #isSeparator,
	or nil if there are no more words in the receiver. Leading separators are skipped. The
	stream is left positioned after the first trailing separator."

	| wordStream element |
	self skipSeparators ifFalse: [^nil].
	wordStream := self contentsSpecies writeStream: 32.
	[self atEnd] whileFalse: 
			[element := self next.
			element isSeparator ifTrue: [^wordStream contents].
			wordStream nextPut: element].
	^wordStream contents!

notEmpty
	"Answer whether there are any sequence values in the receiver."

	^self isEmpty not!

peek
	"Answer the next element in the collection, but do not change the current position. Answer
	nil if the receiver is at its end."

	^self atEnd 
		ifFalse: 
			[| anObject |
			anObject := self next.
			"We don't use #skip:, since we know going back 1 is in bounds"
			self position: self position - 1.
			anObject]!

peekFor: anObject
	"Determine the response to the message peek. If it is the same as the argument, anObject,
	then advance the current position and answer true. Otherwise answer false and do not change
	the current position."

	| next |
	^(next := self nextOrNil) notNil and: 
			[next = anObject or: 
					["We don't use #skip:, since we know going back 1 is in bounds"
					self position: self position - 1.
					false]]!

pop
	"Move back one position in the stream."

	self skip: -1!

position
	"Answer the current <integer> position in the stream of  values."

	^self subclassResponsibility!

position: anInteger 
	"Set the current position in the stream of values to the <integer> argument."

	^self subclassResponsibility!

reset
	"Reset the position of the receiver to be at the beginning of the stream of values, i.e. the
	stream will answer the first sequence value (if any) in response to the #next message."

	self position: 0!

setToEnd
	"Set the position of the receiver to be past the last value (i.e. the stream will have no
	future sequence values), and will answer true in response to the #atEnd message."

	^self subclassResponsibility!

skip: anInteger 
	"Set the receiver's position to be the current position plus the argument, anInteger,
	possibly adjusting the result so as to remain within the bounds of the collection."

	self position: self position + anInteger.
	#todo	"This may need to be modified to be compatible with ANSI definition"!

skipSeparators
	"Advance the receiver's position over any leading whitespace. Answer whether their are more
	elements remaining in the receiver after the separators."

	"Implementation Note: Implementable in terms of #skipWhile:, but this is called so
	frequently that we open code to avoid instantiating a block."

	| next |
	[(next := self nextOrNil) isNil] whileFalse: 
			[next isSeparator
				ifFalse: 
					[self position: self position - 1.
					^true]].
	^false!

skipToAll: aCollection 
	"Set the receivers current position to be past the next occurrence of the sequence of
	objects which are the elements of the <collection> argument. Answer whether such any such
	sequence was found."

	| sequence partialStart |
	sequence := aCollection readStream.
	[sequence atEnd] whileFalse: 
			[self atEnd ifTrue: [^false].
			self next = sequence next 
				ifTrue: [partialStart isNil ifTrue: [partialStart := self position]]
				ifFalse: 
					[sequence reset.
					partialStart isNil 
						ifFalse: 
							[self position: partialStart.
							partialStart := nil]]].
	^true!

skipWhile: aMonadicValuable 
	"Advance the receiver's current position to be past the sequence of future values for which
	the <monadicValuable> argument evaluates to true. Answer true if there are more elements on
	the stream of false otherwise."

	[self atEnd] whileFalse: 
			[(aMonadicValuable value: self next) 
				ifFalse: 
					[self pop.
					^true]].
	^false!

skipWhileMatchAll: aCollection 
	"Advance the receiver's current position to be past the sequence of future values which
	match those in the <Collection> argument. Answer true if the match succeeds completely and
	the stream is left positioned after the final match. If the match fails at any point then
	false is answered and the stream is re-positioned to its initial position. The collection's
	elements are matched against the receiver's future sequence values in the same order as they
	would be enumerated by the collection's implementation of the #do: message."

	^aCollection skipOver: self!

upToAll: aCollection 
	"Answer a collection of the receiver's future sequence values starting with the next value
	accessed by the receiver, and up to, not inclusive of, the sequence of values that match the
	elements of the <collection> argument, or the remaining contents of the stream up to its end
	if the sequence is not found. The stream is left positioned after the last matching element,
	or at the end if the sequence is not found."

	| start |
	start := self position.
	^(self skipToAll: aCollection) 
		ifTrue: 
			[| end answer |
			end := self position.
			self position: start.
			answer := self next: end - start - aCollection size.
			self position: end.
			answer]
		ifFalse: 
			[self position: start.
			self upToEnd]! !
!SequencedStream categoriesFor: #contents!accessing!public! !
!SequencedStream categoriesFor: #copyFrom:to:!copying!public! !
!SequencedStream categoriesFor: #flush!accessing!public! !
!SequencedStream categoriesFor: #isEmpty!public!testing! !
!SequencedStream categoriesFor: #nextLine!accessing!public! !
!SequencedStream categoriesFor: #nextWord!accessing!public! !
!SequencedStream categoriesFor: #notEmpty!public!testing! !
!SequencedStream categoriesFor: #peek!accessing!public! !
!SequencedStream categoriesFor: #peekFor:!accessing!public! !
!SequencedStream categoriesFor: #pop!positioning!public! !
!SequencedStream categoriesFor: #position!positioning!public! !
!SequencedStream categoriesFor: #position:!positioning!public! !
!SequencedStream categoriesFor: #reset!positioning!public! !
!SequencedStream categoriesFor: #setToEnd!positioning!public! !
!SequencedStream categoriesFor: #skip:!positioning!public! !
!SequencedStream categoriesFor: #skipSeparators!positioning!public! !
!SequencedStream categoriesFor: #skipToAll:!positioning!public! !
!SequencedStream categoriesFor: #skipWhile:!positioning!public! !
!SequencedStream categoriesFor: #skipWhileMatchAll:!positioning!public! !
!SequencedStream categoriesFor: #upToAll:!positioning!public! !

SequencedStream methodProtocol: #gettableStream attributes: #(#ansi #readOnly) selectors: #(#atEnd #do: #next #next: #nextLine #nextMatchFor: #peek #peekFor: #skip: #skipTo: #upTo:)!
SequencedStream methodProtocol: #sequencedStream attributes: #(#ansi #readOnly) selectors: #(#close #contents #isEmpty #position #position: #reset #setToEnd)!


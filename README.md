# purescript-vexflow
Purescript wrapper for VexFlow notation. Based on an original implementation by [@marcoalkema](https://github.com/marcoalkema/purescript-vexflow), this version has syntax closer to that of the original VexFlow library using programmable semicolons (i.e. Monads) ala [purescript-d3](https://github.com/pelotom/purescript-d3). 

Also provides some type level safety, your code wil not compile if you try to call `getContext` before calling `setContext`, for example.

###Example
Here's an example of a bar created in JavaScript, taken from the [VexFlow wiki](https://github.com/0xfe/vexflow/wiki/The-VexFlow-Tutorial#step-2-add-some-notes--run-):

```javascript
var notes = [
  new VF.StaveNote({clef: "treble", keys: ["c/4"], duration: "q" }),
  new VF.StaveNote({clef: "treble", keys: ["d/4"], duration: "q" }),
  new VF.StaveNote({clef: "treble", keys: ["b/4"], duration: "qr" }),
  new VF.StaveNote({clef: "treble", keys: ["c/4", "e/4", "g/4"], duration: "q" })
];

var voice = new VF.Voice({num_beats: 4,  beat_value: 4});
voice.addTickables(notes);

var formatter = new VF.Formatter().joinVoices([voice]).format([voice], 400);

voice.draw(context, stave);
```
![](https://camo.githubusercontent.com/5c05de592817f2aafe8dccb924b85e5d21c297ce/687474703a2f2f696d6775722e636f6d2f4e5436325137672e706e67)


The equivalent PureScript would be

```haskell
  notes <- sequence
    [ note Treble [c Natural 4] quarter
    , note Treble [d Natural 4] quarter
    , note Treble [b Natural 4] quarterRest
    , note Treble [c Natural 4, e Natural 4, g Natural 4] quarter
    ]
  
  voice <- newVoice (Voice (TimeSignature 4 4))
    .. addTickables notes
    .. setContext ctx
    .. setStave stave

  formatter <- newFormatter
    .. joinVoices [build voice]
    .. format [build voice] 400.0

  drawVoice voice
```

There are more examples in the `/Test` folder.

#To Do:

###Typelevel safety
 - [x] Enforce `setContext` before `getContext` 
 - [x] Enforce `setStave` before `getStave`
 - [ ] Require that the duration of notes in a voice sum to one bar length
 - [ ] Require `addAccidental`, `addDot` and other functions that target specific notes in a `StaveNote` to only target notes that exists in that `StaveNote`, i.e. you can't add an accidental to the 4th note if there are only three notes.

###Features
 - [x] Beaming notes
 - [x] Formatter
 - [x] Renderer
 - [x] Stave
 - [x] StaveNote
 - [x] Voice
 - [x] Standard Accidentals
 - [ ] Microtonal Accidentals
 - [ ] Annotations
 - [ ] Guitar Tab
 - [ ] Ties
 - [ ] Coloring notes

###EasyScore
VexFlow provides freedom to notate music the way one chooses,  but this comes at the cost of extra complexity. Notes with flats/sharps do not automatically have those flats/sharps rendered, notes are not automatically beamed, etc.

Given that VexFlow is a JavaScript library

 - [ ] Add EasyScore analogous to `VexFlow`'s EasyScore

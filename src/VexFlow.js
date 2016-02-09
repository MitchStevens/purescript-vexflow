// module VexFlow

module.exports = {

    createCanvas: (function(div) {
	return function(){
	    return document.getElementById(div);
	};
    }),

    createRenderer: (function(canvas) {
	return function() {
	    console.log(canvas);
	    var renderer = new Vex.Flow.Renderer(canvas, Vex.Flow.Renderer.Backends.CANVAS);
	    return renderer;
	};
    }),

    createCtx: (function(renderer) {
	return function() {
	    console.log ("Creating context for: " + renderer);
	    return renderer.getContext();
	};
    }),

    createStave: (function(x) {
	return function(y) {
	    return function(width) {
		return function() {
		    console.log ("createStave");
		    var stave = new Vex.Flow.Stave(x, y, width);
		    return stave;
		};
	    };
	
	};
    }),

    drawStave: function(stave) {
	return function(clef) {
	    return function(ctx) {
		return function() {
		    console.log(stave);
		    console.log(clef);
		    console.log(ctx);
		    stave.addClef(clef).setContext(ctx).draw();
		};
	    };
	};
    },

    createNote: function(notes) {
	    return function(duration_) {
		console.log (notes + " " + duration_);
		return function() {
    		    var note = new Vex.Flow.StaveNote({ keys: notes, duration: duration_});
		    return note;
		};
	};
    },

    createNewVoice: function(numBeats) {
	return function(beatValue) {
	    return function() {
		var voice = new Vex.Flow.Voice({
		    num_beats: numBeats,
		    beat_value: beatValue,
		    resolution: Vex.Flow.RESOLUTION
		});
		return voice;
	    };
	};
    },

    addNotesToVoice: function(notes) {
	return function(voice) {
	    return function() {
		console.log (voice + " " + notes);
		voice.addTickables(notes);
	    };
	};
    },

    // Format and justify the notes to 500 pixels
    formatter: function(voices) {
	return function(pxRes) {
	    console.log (voices + " " + pxRes);
	    var formatter = new Vex.Flow.Formatter().joinVoices([voices]).format([voices], pxRes);
	    return formatter;
	};
    },
	
    drawVoice: function(ctx) {
	return function(stave) {
	    voice.draw(ctx, stave);
	};
    }
};

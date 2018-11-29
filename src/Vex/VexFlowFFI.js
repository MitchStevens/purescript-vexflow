"use strict";

var VF = require("vexflow").Flow;

exports.onload = function(action){
  return new function() {
    window.onload = action();
  };
};

exports.getElement = function(div) {
  return function() {
    return document.getElementById(div);
  };
};

exports.createRendererSVG = function(element) {
  return function() {
    return new VF.Renderer(element, VF.Renderer.Backends.SVG);
  };
};

exports.createRendererCanvas = function(element) {
  return function() {
    return new VF.Renderer(element, VF.Renderer.Backends.CANVAS);
  };
};

exports.resize = function(dims) {
  return function(renderer) {
    return function() {
      return renderer.resize(dims.width, dims.height);
    };
  };
};


//Formatter functions
exports.newFormatter = function() {
  return new VF.Formatter();
};

exports.format = function(voices) {
  return function(justifyWidth) {
    return function(formatter) {
      return function() {
        return formatter.format(voices, justifyWidth);
      };
    };
  };
};

exports.formatAndDraw = function(context) {
  console.log("formatAndDraw");
  return function(stave) {
    return function(notes) {
      return function() {
        VF.Formatter.FormatAndDraw(context, stave, notes);
      };
    };
  };
};

exports.joinVoices = function(voices) {
  return function(formatter) {
    return function() {
      return formatter.joinVoices(voices);
    };
  };
};

exports.getContextRenderer = function(renderer) {
  return function() {
    return renderer.getContext();
  };
};


//Stave functions
exports.newStave = function(s) {
  return function() {
    return new VF.Stave(s.x, s.y, s.width);
  };
};

exports.addClef = function(clef) { 
  return function(stave) {
    return function() {
      return stave.setClef(clef);
    };
  };
};

exports.addKeySignature = function(key) {
  return function(stave) {
    return function() {
      return stave.setKeySignature(key);
    };
  };
};

exports.addTimeSignature = function(time) {
  return function(stave) {
    return function() {
      return stave.setTimeSignature(time);
    };
  };
};

exports.getContextStave = function(stave) {
  return function() {
    return stave.getContext();
  };
};

exports.setContextStave = function(context) {
  return function(stave) {
    return function() {
      return stave.setContext(context);
    };
  };
};

exports.drawStave = function(stave) {
  return function() {
    stave.draw();
  };
};


//StaveNote functions
exports.newStaveNote = function(note) {
  return function() {
    return new VF.StaveNote(note);
  };
};

exports.addAccidental = function(i) {
  return function(accidental) {
    return function(stave) {
      return function() {
        return stave.addAccidental(i, new VF.Accidental(accidental));
      };
    };
  };
};


exports.addArticulation = function(i) {
  return function(articulation) {
    return function(stave) {
      return function() {
        return stave.addAccidental(i, new VF.Articulation(articulation));
      };
    };
  };
};

// addAnnotation(i, annotation, stave) {
//   return stave.addAnnotation(i, new VF.Annotation(annotation));
// },

exports.addDot = function(i) {
  return function(stave) {
    return function() {
      return stave.addDot(i);
    };
  };
};

exports.addDotToAll = function(stave) {
  return function() {
    return stave.addDotToAll();
  }
};


//Beam functions
exports.newBeam = function(notes) {
  return function() {
    return new VF.Beam(notes);
  };
};

exports.getContextBeam = function(beam) {
  return function() {
    return beam.getContext();
  };
};

exports.setContextBeam = function (ctx) {
  return function(beam) {
    return function() {
      return beam.setContext(ctx);
    };
  };
};

exports.generateBeams = function(notes) {
  return function() {
    return VF.Beam.generateBeams(notes);
  };
};

exports.drawBeam = function(beam) {
  return function() {
    beam.draw();
  }
}


//Voice functions
exports.newVoice = function(timeSignature) {
  return function() {
    return new VF.Voice(timeSignature);
  };
};

exports.addTickable = function(note) {
  return function(voice) {
    return function() {
      return voice.addTickable(note);
    };
  };
};

exports.addTickables = function(notes) {
  return function(voice) {
    return function() {
      return voice.addTickables(notes);
    };
  };
};

exports.getContextVoice = function(voice) {
  return function() {
    return stave.getContext();
  };
};

exports.setContextVoice = function(context) {
  return function(voice) {
    return function() {
      return voice.setContext(context);
    };
  };
};

exports.getStaveVoice =  function(voice) {
  return function() {
    return voice.getStave();
  };
};

exports.setStaveVoice = function(stave) {
  return function(voice) {
    return function() {
      return voice.setStave(stave);
    };
  };
};

exports.drawVoice = function(voice) {
  return function() {
    voice.draw(voice.context, voice.stave);
  }; 
};
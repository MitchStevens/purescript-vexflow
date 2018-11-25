"use strict";

var VF = require("vexflow").Flow;

exports.onload = function(action){
  return new function() {
    window.onload = function() {
      action();
    };
  };
};

exports.getElement = function(div) {
  return function() {
    return document.getElementById(div);
  };
};

exports.createRendererSVG = function(element) {
  console.log("createRendererSVGs");
  return function() {
    return new VF.Renderer(element, VF.Renderer.Backends.SVG);
  };
};

exports.createRendererCanvas = function(element) {
  console.log("the other thing");
  return function() {
    return new VF.Renderer(element, VF.Renderer.Backends.CANVAS);
  };
};

exports.resize = function(dims) {
  return function(renderer) {
    return function() {
      console.log(renderer.resize(dims.width, dims.height));
      return renderer.resize(dims.width, dims.height);
    };
  };
};

exports.getContextRenderer = function(renderer) {
  return function() {
    return renderer.getContext();
  };
};


//Formatter functions
exports.newFormatter = function() {
  return VF.Formatter();
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
      formatter.joinVoices(voices);
    };
  };
};


//Stave functions
exports.newStave = function(s) {
  console.log("newStave");
  console.log(new VF.Stave(s.x, s.y, s.width));
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
      console.log(time)
      return stave.setTimeSignature(time);
    };
  };
};

exports.getContextStave = function(stave) {
  return function() {
    stave.getContext();
  };
};

exports.setContextStave = function(context) {
  return function(stave) {
    return function() {
      console.log("set5COntxt");
      console.log(context);
      console.log(stave);
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
  console.log("dddd");
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


//Voice functions
exports.newVoice = function(timeSignature) {
  return function() {
    console.log("new voice +-+-+");
    console.log(timeSignature);
    var x = new VF.Voice(timeSignature);
    console.log(x);
    return x;
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
      var v = voice.addTickables(notes);
      return v;
    };
  };
};

exports.getContextVoice = function(voice) {
  return function() {
    stave.getContext();
  };
};

exports.setContextVoice = function(context) {
  return function(voice) {
    return function() {
      return stave.setContext(context);
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

exports.drawVoice = function(context) {
  console.log("drawVoice");
  return function(stave) {
    return function(voice) {
      return function() {
        voice.draw(context, stave);
      };
    };
  };
};
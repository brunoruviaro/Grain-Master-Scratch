/////////////////////////////
// Grain Master Scratch
// May 2013
////////////////////////////

// Select All (ctrl + A)
// Evaluate (ctrl + B)
// Play by moving through sections in the graphical interface (buttons) and modulating the sound with the trackpad.

s.waitForBoot({

	var wid = 129, hei = 90;

	Window.closeAll;
	Buffer.freeAll;
	~myPulse = 7;
	~mybuffer = Buffer.read(
		server: s,
		path: "~/Music/wheels-mono.wav".standardizePath,
		bufnum: 55); // just an arbitrary number I chose for this buffer
	Ndef(\a).play; // start;
	Ndef(\a).fadeTime = 5;

	~silence = {SinOsc.ar(440,0,0)};

	Ndef(\a, ~silence);

	~intro = {
		var buffer = ~mybuffer.bufnum;
		var bufdur = BufDur.kr(buffer);
		var dur = rrand(55,65);
		Mix(FreeVerb.ar(
			in: BPF.ar(
				in: TGrains.ar(
					numChannels: 2,
					trigger: Impulse.ar(Line.kr(100,rrand(0.5,1),dur)),
					bufnum: buffer,
					rate: XLine.kr(5,1,dur/2)+TRand.kr(0.01, 0.02, Dust.kr(3)),
					centerPos: Lag.kr(MouseX.kr(0, 0.5),5),
					dur: MouseY.kr(0.1, 0.3),
					amp: Lag.kr(MouseY.kr(1,0), 3)),
				freq: MouseX.kr(50, Line.kr(4500,450,dur)),
				rq: 0.5),
			mix: Line.kr(0.1, 0.5, dur),
			room: 0.8,
			damp: 0.5))};

	~original = {
		var buffer = ~mybuffer.bufnum;
		var bufdur = BufDur.kr(buffer);
		var dur = rrand(15,25);
		Mix(FreeVerb.ar(
			in: BPF.ar(
				in: TGrains.ar(
					numChannels: 2,
					trigger: Impulse.ar(MouseX.kr(0.5,1.5)),
					bufnum: buffer,
					rate: TRand.kr(1.01, 1.02, Dust.kr(3)),
					centerPos: Lag.kr(MouseX.kr(0, rrand(1.5,1.9)),5),
					dur: MouseY.kr(0.5,1),
					amp: Lag.kr(MouseY.kr(1,0), 3)),
				freq: MouseX.kr(50, rrand(150,550)),
				rq: 0.9),
			mix: Line.kr(0.5, 0.001, dur),
			room: 0.01, //Line.kr(0.8,0.3,dur),
			damp: 0.2))};


	~low = {
		var buffer = ~mybuffer.bufnum;
		var bufdur = BufDur.kr(buffer);
		Mix(TGrains.ar(
			numChannels: 2,
			trigger: Impulse.ar(MouseX.kr(40,50)),
			bufnum: buffer,
			rate: MouseX.kr(0.51,0.94),
			centerPos: LFNoise2.kr(1/5).range(1,4),
			dur: MouseY.kr(0.1,0.3),
			amp: Lag.kr(MouseY.kr(1,0), 3)))};

	~lowVerb = {
		var buffer = ~mybuffer.bufnum;
		var bufdur = BufDur.kr(buffer);
		Mix(FreeVerb.ar(
			in: LPF.ar(
				in: TGrains.ar(
					numChannels: 2,
					trigger: Impulse.ar(MouseX.kr(10,30)),
					bufnum: buffer,
					rate: MouseX.kr(0.7,0.75),
					centerPos: LFNoise1.kr(1).range(2,4),
					dur: MouseX.kr(0.9,0.1),
					amp: Lag.kr(MouseY.kr(1,0),3)),
				freq: MouseX.kr(1500, 5000)),
			mix: 0.4,
			room: 0.8))};

	~highPopcorn1 = {
		var buffer = ~mybuffer.bufnum;
		var bufdur = BufDur.kr(buffer);
		Mix(FreeVerb.ar(
			in: HPF.ar(
				in: TGrains.ar(
					numChannels: 2,
					trigger: Impulse.ar(MouseX.kr(10,100)),
					bufnum: buffer,
					rate: MouseX.kr(1,1.4),
					centerPos: LFNoise1.kr(4).range(3,4),
					dur: MouseY.kr(0.1,0.91),
					amp: SinOsc.kr(1/15).range(0.2, 1.0))*Lag.kr(MouseY.kr(1,0), 3),
				freq: MouseX.kr(1250, 2500)),
			mix: 0.33,
			room: 0.5))};


	~highPopcorn2 = {
		var buffer = ~mybuffer.bufnum;
		var bufdur = BufDur.kr(buffer);
		Mix(HPF.ar(
			in: TGrains.ar(
				numChannels: 2,
				trigger: Impulse.ar(MouseX.kr(9,60)),
				bufnum: buffer,
				rate: MouseX.kr(0.5,2.4),
				centerPos: LFNoise1.kr(4).range(3,4),
				dur: MouseY.kr(0.1,0.11),
				amp: SinOsc.kr(1/~myPulse).range(0.01,1) * MouseY.kr(0.9, 0.001)),
			freq: MouseX.kr(50, 4500)))};

	~raspberry = {
		var buffer = ~mybuffer.bufnum;
		var bufdur = BufDur.kr(buffer);
		Mix(TGrains.ar(
			numChannels: 2,
			trigger: Impulse.ar(MouseX.kr(40,50)),
			bufnum: buffer,
			rate: MouseX.kr(0.51,0.94),
			centerPos: LFNoise2.kr(1/5).range(1,4),
			dur: MouseY.kr(0.1,0.3),
			amp: Lag.kr(MouseY.kr(1,0), 3)))};

	~blueberry = {
		var buffer = ~mybuffer.bufnum;
		var bufdur = BufDur.kr(buffer);
		Mix(TGrains.ar(
			numChannels: 2,
			trigger: Impulse.ar(LFNoise0.kr(3).range(10,30)),
			bufnum: buffer,
			rate: Line.kr(0.5, 1.1, 20),
			centerPos: LFNoise2.kr(1/2).range(0,0.3),
			dur: MouseY.kr(0.1,0.9),
			amp: SinOsc.kr(1/(~myPulse-2)).range(0.1,0.2)*Lag.kr(MouseY.kr(1,0.3),1)))};

	~throat1 = {
		var buffer = ~mybuffer.bufnum;
		var bufdur = BufDur.kr(buffer);
		Mix(TGrains.ar(
			numChannels: 2,
			trigger: Impulse.ar(MouseX.kr(40,100)),
			bufnum: buffer,
			rate: MouseX.kr(1,1.4),
			centerPos: LFNoise1.kr(1).range(0,rrand(1,5)),
			dur: MouseY.kr(0.2,0.91),
			amp: Lag.kr(MouseY.kr(1,0.01),1)))};

	~throat2 = {
		var buffer = ~mybuffer.bufnum;
		var bufdur = BufDur.kr(buffer);
		Mix(HPF.ar(
			in: TGrains.ar(
				numChannels: 2,
				trigger: Impulse.ar(MouseY.kr(1,100)), // change these numbers
				bufnum: buffer,
				rate: MouseX.kr(1,1.4), // change these numbers
				centerPos: LFNoise1.kr(4).range(3,4),
				dur: MouseY.kr(0.1,0.91),
				amp: Lag.kr(MouseY.kr(1,0.01),1)),
			freq: MouseY.kr(50, 4500)))};

	~originalEnd = {
		var buffer = ~mybuffer.bufnum;
		var bufdur = BufDur.kr(buffer);
		var dur = rrand(15,25);
		Mix(FreeVerb.ar(
			in: TGrains.ar(
				numChannels: 2,
				trigger: Impulse.ar(MouseX.kr(1.5,0.9)),
				bufnum: buffer,
				rate: TRand.kr(1.01, 1.1, Dust.kr(3)),
				centerPos: Lag.kr(MouseY.kr(0, rrand(3.5,5.5)),5),
				dur: MouseX.kr(0.2,3),
				amp: Lag.kr(MouseY.kr(1,0), 3)),
			mix: Line.kr(0.5, 0.1, dur),
			room: 0.1, //Line.kr(0.8,0.3,dur),
			damp: 0.2))};


	// end of definitions

	// GUI
	f = FlowView.new(windowTitle:"Grain Master Scratch");

	b = { arg width, heigth, label, action;
		Button(f, Rect(10, 10, width, heigth))
		.states_([
			[label, Color.white, Color.black],
			[label, Color.white, Color.gray]])
		.action_({Ndef(\a, action)})};

	b.value(wid, hei, "intro", ~intro);
	b.value(wid, hei, "original", ~original);
	b.value(wid, hei, "low", ~low);
	b.value(wid, hei, "lowVerb", ~lowVerb);
	b.value(wid, hei, "highPopcorn1", ~highPopcorn1);
	b.value(wid, hei, "highPopcorn2", ~highPopcorn2);
	b.value(wid, hei, "raspberry", ~raspberry);
	b.value(wid, hei, "blueberry", ~blueberry);
	b.value(wid, hei, "throat1", ~throat1);
	b.value(wid, hei, "throat2", ~throat2);

});





// test
/*
Ndef(\a, ~silence);
Ndef(\a, ~intro);
Ndef(\a, ~original);
Ndef(\a, ~low);
Ndef(\a, ~lowVerb);
Ndef(\a, ~highPopcorn1);
Ndef(\a, ~highPopcorn2);
Ndef(\a, ~raspberry);
Ndef(\a, ~blueberry);
Ndef(\a, ~throat1);
Ndef(\a, ~throat2);
Ndef(\a, ~originalEnd);
*/
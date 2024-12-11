import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recorder"
export default class extends Controller {
  static targets = ["recordButton", "stopButton", "soundClips", "canvas", "mainSection"];

  connect() {
    console.log(this.recordButtonTarget, this.stopButtonTarget, this.soundClipsTarget, this.canvasTarget, this.mainSectionTarget);
    this.stopButton.disabled = true;
    this.audioCtx = null;
    this.chunks = [];
    this.canvasCtx = this.canvas.getContext("2d");

    //Vérification de la compatibilité du navigateur
    if (navigator.mediaDevices.getUserMedia) {
      const constraints = { audio: true };

      navigator.mediaDevices.getUserMedia(constraints).then(this.onSuccess.bind(this), this.onError);
    } else {
      console.log("MediaDevices.getUserMedia() not supported on your browser!");
    }
  }

  onSuccess(stream) {
    this.mediaRecorder = new MediaRecorder(stream);
    this.visualize(stream);

    this.recordButton.addEventListener("click", () => {
      this.mediaRecorder.start();
      this.recordButton.classList.add("recording");
      this.stopButton.disabled = false;
      this.recordButton.disabled = true;
    });

    this.stopButton.addEventListener("click", () => {
      this.mediaRecorder.stop();
      this.recordButton.classList.remove("recording");
      this.stopButton.disabled = true;
      this.recordButton.disabled = false;
    });

    this.mediaRecorder.onstop = this.onStop.bind(this);
    this.mediaRecorder.ondataavailable = (e) => this.chunks.push(e.data);
  }

  onError(err) {
    console.log("The following error occurred: " + err);
  }

  onStop() {
    const clipName = prompt("Enter a name for your sound clip?", "My unnamed clip");

    const clipContainer = document.createElement("article");
    const clipLabel = document.createElement("p");
    const audio = document.createElement("audio");
    const deleteButton = document.createElement("button");

    clipContainer.classList.add("clip");
    audio.setAttribute("controls", "");
    deleteButton.textContent = "Delete";
    deleteButton.className = "delete";

    // Enregistrement de l'audio
    clipLabel.textContent = clipName || "My unnamed clip";

    clipContainer.appendChild(audio);
    clipContainer.appendChild(clipLabel);
    clipContainer.appendChild(deleteButton);
    this.soundClips.appendChild(clipContainer);

    const blob = new Blob(this.chunks, { type: this.mediaRecorder.mimeType });
    this.chunks = [];
    const audioURL = window.URL.createObjectURL(blob);
    audio.src = audioURL;

    // Suppression de l'audio
    deleteButton.addEventListener("click", (e) => {
      e.target.closest(".clip").remove();
    });

    // Renommage de l'audio au clic sur le label
    clipLabel.addEventListener("click", () => {
      const existingName = clipLabel.textContent;
      const newClipName = prompt("Enter a new name for your sound clip?");
      clipLabel.textContent = newClipName || existingName;
    });
  }

  visualize(stream) {
    if (!this.audioCtx) {
      this.audioCtx = new AudioContext();
    }

    const source = this.audioCtx.createMediaStreamSource(stream);
    const analyser = this.audioCtx.createAnalyser();
    analyser.fftSize = 2048;
    const bufferLength = analyser.frequencyBinCount;
    const dataArray = new Uint8Array(bufferLength);

    source.connect(analyser);

    this.draw(analyser, dataArray);
  }

  draw(analyser, dataArray) {
    const WIDTH = this.canvas.width;
    const HEIGHT = this.canvas.height;

    requestAnimationFrame(() => this.draw(analyser, dataArray));

    analyser.getByteTimeDomainData(dataArray);

    // Couleurs du canvas
    this.canvasCtx.fillStyle = "rgb(200, 200, 200)";
    this.canvasCtx.fillRect(0, 0, WIDTH, HEIGHT);

    this.canvasCtx.lineWidth = 2;
    this.canvasCtx.strokeStyle = "rgb(0, 0, 0)";

    this.canvasCtx.beginPath();

    let sliceWidth = (WIDTH * 1.0) / analyser.frequencyBinCount;
    let x = 0;

    for (let i = 0; i < analyser.frequencyBinCount; i++) {
      const v = dataArray[i] / 128.0;
      const y = (v * HEIGHT) / 2;

      if (i === 0) {
        this.canvasCtx.moveTo(x, y);
      } else {
        this.canvasCtx.lineTo(x, y);
      }

      x += sliceWidth;
    }

    this.canvasCtx.lineTo(this.canvas.width, this.canvas.height / 2);
    this.canvasCtx.stroke();
  }

  resizeCanvas() {
    this.canvas.width = this.mainSection.offsetWidth;
  }
}

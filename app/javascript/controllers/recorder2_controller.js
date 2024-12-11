import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recorder2"
export default class extends Controller {
  connect() {
    console.log('Recorder2 connected')
    // document.addEventListener"DOMContentLoaded", () => {
      const recordButton = document.querySelector(".record");
      const stopButton = document.querySelector(".stop");
      const soundClips = document.querySelector(".sound-clips");
      const canvas = document.querySelector(".visualizer");
      const mainSection = document.querySelector(".main-controls");

      // Disable stop button while not recording
      stopButton.disabled = true;

      // Visualiser setup - create web audio api context and canvas
      let audioCtx;
      const canvasCtx = canvas.getContext("2d");

      // Main block for doing the audio recording
      if (navigator.mediaDevices.getUserMedia) {
        console.log("The mediaDevices.getUserMedia() method is supported.");

        const constraints = { audio: true };
        let chunks = [];

        let onSuccess = function (stream) {
          const mediaRecorder = new MediaRecorder(stream);

          visualize(stream);

          recordButton.addEventListener("click", () => {
            mediaRecorder.start();
            console.log(mediaRecorder.state);
            console.log("Recorder started.");
            recordButton.classList.add("recording"); // Add class for styling
            stopButton.disabled = false;
            recordButton.disabled = true;
          });

          stopButton.addEventListener("click", () => {
            mediaRecorder.stop();
            console.log(mediaRecorder.state);
            console.log("Recorder stopped.");
            recordButton.classList.remove("recording");
            stopButton.disabled = true;
            recordButton.disabled = true; // Disable record button after recording is saved
          });

          mediaRecorder.onstop = function () {
            console.log("Last data to read (after MediaRecorder.stop() called).");

            const clipContainer = document.createElement("article");
            const clipLabel = document.createElement("p");
            const audio = document.createElement("audio");
            const deleteButton = document.createElement("button");

            clipContainer.classList.add("clip");
            audio.setAttribute("controls", "");
            deleteButton.textContent = "Delete & Re-record";
            deleteButton.className = "delete";

            clipLabel.textContent = "La capsule a bien été enregistrée :)";

            clipContainer.appendChild(audio);
            clipContainer.appendChild(clipLabel);
            clipContainer.appendChild(deleteButton);
            soundClips.appendChild(clipContainer);

            const blob = new Blob(chunks, { type: mediaRecorder.mimeType });
            chunks = [];
            const audioURL = window.URL.createObjectURL(blob);
            audio.src = audioURL;

            deleteButton.addEventListener("click", (e) => {
              e.target.closest(".clip").remove();
              recordButton.disabled = false; // Re-enable the record button when deleting a clip
              recordButton.click(); // Automatically start a new recording
            });
          };

          mediaRecorder.ondataavailable = function (e) {
            chunks.push(e.data);
          };
        };

        let onError = function (err) {
          console.log("The following error occurred: " + err);
        };

        navigator.mediaDevices.getUserMedia(constraints).then(onSuccess, onError);
      } else {
        console.log("MediaDevices.getUserMedia() not supported on your browser!");
      }

      function visualize(stream) {
        if (!audioCtx) {
          audioCtx = new AudioContext();
        }

        const source = audioCtx.createMediaStreamSource(stream);
        const analyser = audioCtx.createAnalyser();
        analyser.fftSize = 2048;
        const bufferLength = analyser.frequencyBinCount;
        const dataArray = new Uint8Array(bufferLength);

        source.connect(analyser);

        draw();

        // Draw the visualizer
        function draw() {
          const WIDTH = canvas.width;
          const HEIGHT = canvas.height;

          requestAnimationFrame(draw);

          analyser.getByteTimeDomainData(dataArray);

          canvasCtx.fillStyle = "#FFF5E1";
          canvasCtx.fillRect(0, 0, WIDTH, HEIGHT);

          canvasCtx.lineWidth = 2;
          canvasCtx.strokeStyle = "0C1844";

          canvasCtx.beginPath();

          let sliceWidth = (WIDTH * 1.0) / bufferLength;
          let x = 0;

          for (let i = 0; i < bufferLength; i++) {
            let v = dataArray[i] / 128.0;
            let y = (v * HEIGHT) / 2;

            if (i === 0) {
              canvasCtx.moveTo(x, y);
            } else {
              canvasCtx.lineTo(x, y);
            }

            x += sliceWidth;
          }

          canvasCtx.lineTo(canvas.width, canvas.height / 2);
          canvasCtx.stroke();
        }
      }

      // Resize canvas on window resize
      window.addEventListener("resize", () => {
        canvas.width = mainSection.offsetWidth;
      });

      // Initial resize
      window.dispatchEvent(new Event("resize"));
    };

  }
// }

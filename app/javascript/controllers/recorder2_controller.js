import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="recorder2"
export default class extends Controller {
  connect() {
    console.log("Recorder2 connected");

    const recordButton = document.querySelector(".record");
    const stopButton = document.querySelector(".stop");
    const redoButton = document.querySelector(".redo");
    const canvas = document.querySelector(".visualizer");
    const mainSection = document.querySelector(".main-controls");

    // Désactiver les boutons inutiles initialement
    stopButton.disabled = true;
    redoButton.disabled = true;

    let audioCtx;
    const canvasCtx = canvas.getContext("2d");

    if (navigator.mediaDevices.getUserMedia) {
      console.log("The mediaDevices.getUserMedia() method is supported.");

      const constraints = { audio: true };
      let chunks = [];

      const onSuccess = (stream) => {
        const mediaRecorder = new MediaRecorder(stream);

        visualize(stream);

        recordButton.addEventListener("click", () => {
          mediaRecorder.start();
          console.log("Recorder started.");
          recordButton.classList.add("recording");
          recordButton.disabled = true;
          stopButton.disabled = false;
          redoButton.disabled = true;
        });

        stopButton.addEventListener("click", () => {
          mediaRecorder.stop();
          console.log("Recorder stopped.");
          recordButton.classList.remove("recording");
          stopButton.disabled = true;
          redoButton.disabled = false;
        });

        redoButton.addEventListener("click", () => {
          chunks = []; // Réinitialiser les données de l'enregistrement
          console.log("Redo clicked. Ready for a new recording.");
          recordButton.disabled = false;
          stopButton.disabled = true;
          redoButton.disabled = true;

          // Supprime les champs cachés précédents
          document.querySelectorAll("input[name='capsule[audio_url]']").forEach((input) => {
            input.remove();
          });
        });

        mediaRecorder.onstop = async () => {
          console.log("Recording stopped. Preparing upload...");

          const blob = new Blob(chunks, { type: mediaRecorder.mimeType });
          chunks = [];
          const formData = new FormData();
          formData.append("file", blob);
          formData.append("upload_preset", "audio_capsules");
          formData.append("folder", "user-recordings");

          try {
            const response = await fetch(
              "https://api.cloudinary.com/v1_1/dkrxx2ews/video/upload",
              {
                method: "POST",
                body: formData,
              }
            );
            const data = await response.json();
            console.log("Audio uploaded to Cloudinary:", data.secure_url);

            const hiddenInput = document.createElement("input");
            hiddenInput.type = "hidden";
            hiddenInput.name = "capsule[audio_url]";
            hiddenInput.value = data.secure_url;
            document.querySelector("#capsule-form form").appendChild(hiddenInput);
          } catch (error) {
            console.error("Error uploading audio:", error);
          }
        };

        mediaRecorder.ondataavailable = (e) => {
          chunks.push(e.data);
        };
      };

      const onError = (err) => {
        console.error("The following error occurred:", err);
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

      function draw() {
        const WIDTH = canvas.width;
        const HEIGHT = canvas.height;

        requestAnimationFrame(draw);

        analyser.getByteTimeDomainData(dataArray);

        canvasCtx.fillStyle = "#FFF5E1";
        canvasCtx.fillRect(0, 0, WIDTH, HEIGHT);

        canvasCtx.lineWidth = 2;
        canvasCtx.strokeStyle = "#0C1844";

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

    window.addEventListener("resize", () => {
      canvas.width = mainSection.offsetWidth;
    });

    window.dispatchEvent(new Event("resize"));
  }
}

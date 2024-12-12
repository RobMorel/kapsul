import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="audio-reviews"
export default class extends Controller {

  static targets = ["audio", "playButton", "replayButton", "feedbackSection", "heartIcon"]

  connect() {
    console.log("Audio controller connected");
    //console.log(this.audioTarget);
    console.log(this.feedbackSectionTarget);

  }

  audioEnded() {
    this.feedbackSectionTarget.classList.remove("d-none");
    this.audioTarget.classList.add("d-none");
    this.replayButtonTarget.style.display = "block";
    this.heartIconTarget.style.display = "block";
  }

  togglePlayPause() {
    if (this.audioElement.paused) {
      this.audioElement.play()
    } else {
      this.audioElement.pause()
    }
  }

  replayAudio() {
    this.audioTarget.currentTime = 0; // Revenir au début de l'audio
    this.audioTarget.play(); // Rejouer l'audio
    this.playButtonTarget.style.display = "none"; // Masquer le bouton play
   
  }
}

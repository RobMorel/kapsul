import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="audio-reviews"
export default class extends Controller {

  static targets = ["audio", "playButton", "replayButton", "feedbackSection", "likeCount","likeBtn","dislikeBtn"]

  connect() {
    console.log("Audio controller connected");
    //console.log(this.audioTarget);
    console.log(this.feedbackSectionTarget);

  }

  audioEnded() {
    this.feedbackSectionTarget.classList.remove("d-none");
    this.audioTarget.classList.add("d-none");
    this.replayButtonTarget.style.display = "block";
    //this.heartIconTarget.style.display = "block";
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

  like(event) {
    this.likeBtnTarget.disabled = true;
    this.dislikeBtnTarget.disabled = false;
    fetch( this.likeBtnTarget.dataset.url, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content
      }
    })
      .then(response => response.json())
      .then((data) => {
        this.updateLikeCount(data);
      });


  }

  dislike(event) {
    this.dislikeBtnTarget.disabled = true;
    this.likeBtnTarget.disabled = false;
    fetch( this.dislikeBtnTarget.dataset.url, {
      method: "DELETE",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content
      }
    })
      .then(response => response.json())
      .then((data) => {
        this.updateLikeCount(data);
      });


  }



  updateLikeCount(data) {
   console.log(data);
    this.likeCountTarget.innerText = data.count;
  }
}

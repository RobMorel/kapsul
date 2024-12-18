import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["frame", "list", "input", "form"];

  toggleFrame(event) {
    console.log("toggleFrame called");
    const capsuleId = event.currentTarget.dataset.commentsCapsuleId;
    console.log("Capsule ID:", capsuleId);
    this.frameTarget.classList.remove("hidden"); // Afficher la popup
    this.loadComments(capsuleId); // Charger les commentaires
  }

  closeFrame() {
    this.frameTarget.classList.add("hidden"); // Masquer la popup
  }

  loadComments(capsuleId) {
    fetch(`/capsules/${capsuleId}/comments`)
      .then(response => response.json())
      .then(comments => {
        if (comments.length === 0) {
          this.listTarget.innerHTML = "<p>No comments yet.</p>";
        } else {
          this.listTarget.innerHTML = comments.map(comment => this.renderComment(comment)).join("");
        }
      })
      .catch(error => {
        console.error("Erreur lors du chargement des commentaires :", error);
        this.listTarget.innerHTML = "<p>Failed to load comments.</p>";
      });
  }

  submitComment(event) {
    event.preventDefault();

    // On récupère le champ hidden qui contient la valeur du commentaire
    let hiddenInput = this.formTarget.querySelector('input[name="comment[comment]"]');

    // Vérifier si le champ caché existe sinon le créer
    if (!hiddenInput) {
      const hiddenInput = document.createElement('input');
      hiddenInput.type = 'hidden';
      hiddenInput.name = 'comment[comment]';
      hiddenInput.value = this.inputTarget.value;
      this.formTarget.appendChild(hiddenInput);
    } else {
      // Si champ caché existe on met à jour sa valeur
      hiddenInput.value = this.inputTarget.value;
    }

    // récupère toutes les données du formulaire
    const formData = new FormData(this.formTarget);
    const capsuleId = this.formTarget.dataset.commentsCapsuleId;

    // Envoi de la requête POST avec FormData
    fetch(`/capsules/${capsuleId}/comments`, {
      method: "POST",
      headers: {
        "X-CSRF-Token": this.getCsrfToken(), // Ajouter le token CSRF
      },
      body: formData, // Envoie des données du formulaire
    })
      .then(response => {
        if (!response.ok) throw response;
        return response.json();
      })
      .then(comment => {
        this.listTarget.insertAdjacentHTML("afterbegin", this.renderComment(comment));
        this.inputTarget.value = ""; // Vide le textarea après soumission
      })
      .catch(error => {
        console.error("Erreur lors de l'ajout du commentaire :", error);
        alert("Failed to add comment.");
      });
  }

  renderComment(comment) {
    return `
      <div class="comment" data-comment-id="${comment.id}">
        <strong>${comment.user_name}</strong>
        <p>${comment.content}</p>
        <small>${comment.created_at}</small>
      </div>
    `;
  }


  getCsrfToken() {
    return document.querySelector("meta[name='csrf-token']").content;
  }
}

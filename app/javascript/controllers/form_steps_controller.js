import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["step"];

  connect() {
    this.showStep(0);
  }

  nextStep() {
    const currentIndex = this.currentStepIndex();
    if (this.isStepValid(currentIndex)) {
      this.showStep(currentIndex + 1);
    } else {
      alert("Please fill in all required fields before continuing.");
    }
  }

  previousStep() {
    const currentIndex = this.currentStepIndex();
    this.showStep(currentIndex - 1);
  }

  handleErrors(event) {
    if (event.detail.success === false) {
      alert("There are errors in your form. Please check all fields.");
    }
  }

  currentStepIndex() {
    return this.stepTargets.findIndex((step) => !step.classList.contains("d-none"));
  }

  showStep(index) {
    this.stepTargets.forEach((step, i) => {
      step.classList.toggle("d-none", i !== index);
    });
  }

  isStepValid(index) {
    const fields = this.stepTargets[index].querySelectorAll("input, textarea, select");
    return Array.from(fields).every((field) => field.value.trim() !== "");
  }
}

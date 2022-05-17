import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  copy(e) {
    const container = e.target.parentElement;
    const value = container.querySelector("input").value;
    const notificationSpan = container.querySelector("span");
    navigator.clipboard.writeText(value);
    notificationSpan.classList.remove("hidden");
  }
}

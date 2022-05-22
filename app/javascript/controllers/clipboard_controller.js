import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  copy(e) {
    const container = e.target.parentElement;
    const value = container.querySelector("input").value;
    e.target.textContent = 'Copied!';
    navigator.clipboard.writeText(value);

    document.querySelectorAll('.clipboard-btn').forEach(element => {
      if (!element.isEqualNode(e.target)) element.textContent = 'Copy ✂️';
    });
  }
}

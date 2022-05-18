import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle() {
    const mobileMenu = document.querySelector("#mobile-menu")
    mobileMenu.classList.toggle("hidden")
  }
}

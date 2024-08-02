import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    document.addEventListener("modal:close", this.close.bind(this));
  }

  disconnect() {
    document.removeEventListener("modal:close", this.close.bind(this));
  }

  close(e) {
    e.preventDefault();

    const modal = document.getElementById("modal");
    modal.innerHTML = "";
    modal.removeAttribute("src");
    modal.removeAttribute("complete");
  }
}

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.modal = new window.bootstrap.Modal(this.element);
    this.modal.show();
  }

  close() {
    this.modal.hide();
  }
}

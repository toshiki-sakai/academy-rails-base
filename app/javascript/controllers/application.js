import { Application } from "@hotwired/stimulus";

const application = Application.start();

// Stimulus の開発環境を設定
application.debug = false;
window.Stimulus = application;

export { application };
